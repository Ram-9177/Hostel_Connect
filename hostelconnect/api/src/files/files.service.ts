import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { FileUpload } from './entities/file-upload.entity';
import { createReadStream, existsSync, unlinkSync } from 'fs';
import { join } from 'path';
import * as sharp from 'sharp';

export interface FileUploadResult {
  id: string;
  filename: string;
  originalName: string;
  mimetype: string;
  size: number;
  url: string;
  thumbnailUrl?: string;
}

@Injectable()
export class FilesService {
  constructor(
    @InjectRepository(FileUpload)
    private readonly fileUploadRepository: Repository<FileUpload>,
  ) {}

  async saveFile(
    file: Express.Multer.File,
    userId: string,
    category: 'profile' | 'document' | 'notice' = 'document',
  ): Promise<FileUploadResult> {
    try {
      // Create file record
      const fileUpload = this.fileUploadRepository.create({
        filename: file.filename,
        originalName: file.originalname,
        mimetype: file.mimetype,
        size: file.size,
        userId,
        category,
        uploadedAt: new Date(),
      });

      const savedFile = await this.fileUploadRepository.save(fileUpload);

      // Generate thumbnail for images
      let thumbnailUrl: string | undefined;
      if (file.mimetype.startsWith('image/')) {
        thumbnailUrl = await this.generateThumbnail(file.filename);
      }

      return {
        id: savedFile.id,
        filename: savedFile.filename,
        originalName: savedFile.originalName,
        mimetype: savedFile.mimetype,
        size: savedFile.size,
        url: `/api/v1/files/${savedFile.id}`,
        thumbnailUrl: thumbnailUrl ? `/api/v1/files/thumbnail/${savedFile.id}` : undefined,
      };
    } catch (error) {
      throw new BadRequestException('Failed to save file: ' + error.message);
    }
  }

  async getFile(fileId: string): Promise<{ stream: NodeJS.ReadableStream; file: FileUpload }> {
    const file = await this.fileUploadRepository.findOne({
      where: { id: fileId },
    });

    if (!file) {
      throw new NotFoundException('File not found');
    }

    const filePath = join(process.cwd(), 'uploads', file.filename);
    
    if (!existsSync(filePath)) {
      throw new NotFoundException('File not found on disk');
    }

    const stream = createReadStream(filePath);
    return { stream, file };
  }

  async getThumbnail(fileId: string): Promise<{ stream: NodeJS.ReadableStream; file: FileUpload }> {
    const file = await this.fileUploadRepository.findOne({
      where: { id: fileId },
    });

    if (!file) {
      throw new NotFoundException('File not found');
    }

    const thumbnailPath = join(process.cwd(), 'uploads', 'thumbnails', file.filename);
    
    if (!existsSync(thumbnailPath)) {
      throw new NotFoundException('Thumbnail not found');
    }

    const stream = createReadStream(thumbnailPath);
    return { stream, file };
  }

  async getUserFiles(userId: string, category?: string): Promise<FileUpload[]> {
    const whereCondition: any = { userId };
    if (category) {
      whereCondition.category = category;
    }

    return this.fileUploadRepository.find({
      where: whereCondition,
      order: { uploadedAt: 'DESC' },
    });
  }

  async deleteFile(fileId: string, userId: string): Promise<void> {
    const file = await this.fileUploadRepository.findOne({
      where: { id: fileId, userId },
    });

    if (!file) {
      throw new NotFoundException('File not found');
    }

    // Delete physical file
    const filePath = join(process.cwd(), 'uploads', file.filename);
    if (existsSync(filePath)) {
      unlinkSync(filePath);
    }

    // Delete thumbnail if exists
    const thumbnailPath = join(process.cwd(), 'uploads', 'thumbnails', file.filename);
    if (existsSync(thumbnailPath)) {
      unlinkSync(thumbnailPath);
    }

    // Delete database record
    await this.fileUploadRepository.remove(file);
  }

  async updateFileMetadata(fileId: string, userId: string, metadata: any): Promise<FileUpload> {
    const file = await this.fileUploadRepository.findOne({
      where: { id: fileId, userId },
    });

    if (!file) {
      throw new NotFoundException('File not found');
    }

    Object.assign(file, metadata);
    return this.fileUploadRepository.save(file);
  }

  async getFileStats(): Promise<{
    totalFiles: number;
    totalSize: number;
    filesByCategory: { [key: string]: number };
    filesByMimetype: { [key: string]: number };
  }> {
    const totalFiles = await this.fileUploadRepository.count();
    
    const totalSizeResult = await this.fileUploadRepository
      .createQueryBuilder('file')
      .select('SUM(file.size)', 'totalSize')
      .getRawOne();

    const filesByCategory = await this.fileUploadRepository
      .createQueryBuilder('file')
      .select('file.category', 'category')
      .addSelect('COUNT(*)', 'count')
      .groupBy('file.category')
      .getRawMany();

    const filesByMimetype = await this.fileUploadRepository
      .createQueryBuilder('file')
      .select('file.mimetype', 'mimetype')
      .addSelect('COUNT(*)', 'count')
      .groupBy('file.mimetype')
      .getRawMany();

    return {
      totalFiles,
      totalSize: parseInt(totalSizeResult.totalSize) || 0,
      filesByCategory: filesByCategory.reduce((acc, item) => {
        acc[item.category] = parseInt(item.count);
        return acc;
      }, {}),
      filesByMimetype: filesByMimetype.reduce((acc, item) => {
        acc[item.mimetype] = parseInt(item.count);
        return acc;
      }, {}),
    };
  }

  private async generateThumbnail(filename: string): Promise<string> {
    try {
      const inputPath = join(process.cwd(), 'uploads', filename);
      const outputDir = join(process.cwd(), 'uploads', 'thumbnails');
      const outputPath = join(outputDir, filename);

      // Ensure thumbnails directory exists
      const fs = require('fs');
      if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
      }

      // Generate thumbnail using sharp
      await sharp(inputPath)
        .resize(300, 300, { fit: 'inside', withoutEnlargement: true })
        .jpeg({ quality: 80 })
        .toFile(outputPath);

      return outputPath;
    } catch (error) {
      console.error('Error generating thumbnail:', error);
      return null;
    }
  }

  // Profile picture specific methods
  async uploadProfilePicture(file: Express.Multer.File, userId: string): Promise<FileUploadResult> {
    // Validate image type
    if (!file.mimetype.startsWith('image/')) {
      throw new BadRequestException('Only image files are allowed for profile pictures');
    }

    // Delete existing profile picture
    await this.deleteUserProfilePicture(userId);

    return this.saveFile(file, userId, 'profile');
  }

  async getUserProfilePicture(userId: string): Promise<FileUpload | null> {
    return this.fileUploadRepository.findOne({
      where: { userId, category: 'profile' },
      order: { uploadedAt: 'DESC' },
    });
  }

  async deleteUserProfilePicture(userId: string): Promise<void> {
    const profilePicture = await this.getUserProfilePicture(userId);
    if (profilePicture) {
      await this.deleteFile(profilePicture.id, userId);
    }
  }

  // Document upload methods
  async uploadDocument(file: Express.Multer.File, userId: string): Promise<FileUploadResult> {
    return this.saveFile(file, userId, 'document');
  }

  async getUserDocuments(userId: string): Promise<FileUpload[]> {
    return this.getUserFiles(userId, 'document');
  }

  // Notice attachment methods
  async uploadNoticeAttachment(file: Express.Multer.File, userId: string): Promise<FileUploadResult> {
    return this.saveFile(file, userId, 'notice');
  }

  async getNoticeAttachments(noticeId: string): Promise<FileUpload[]> {
    return this.fileUploadRepository.find({
      where: { noticeId },
      order: { uploadedAt: 'DESC' },
    });
  }
}
