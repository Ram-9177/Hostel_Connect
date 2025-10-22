"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FilesService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const file_upload_entity_1 = require("./entities/file-upload.entity");
const fs_1 = require("fs");
const path_1 = require("path");
const sharp = require("sharp");
let FilesService = class FilesService {
    constructor(fileUploadRepository) {
        this.fileUploadRepository = fileUploadRepository;
    }
    async saveFile(file, userId, category = 'document') {
        try {
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
            let thumbnailUrl;
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
        }
        catch (error) {
            throw new common_1.BadRequestException('Failed to save file: ' + error.message);
        }
    }
    async getFile(fileId) {
        const file = await this.fileUploadRepository.findOne({
            where: { id: fileId },
        });
        if (!file) {
            throw new common_1.NotFoundException('File not found');
        }
        const filePath = (0, path_1.join)(process.cwd(), 'uploads', file.filename);
        if (!(0, fs_1.existsSync)(filePath)) {
            throw new common_1.NotFoundException('File not found on disk');
        }
        const stream = (0, fs_1.createReadStream)(filePath);
        return { stream, file };
    }
    async getThumbnail(fileId) {
        const file = await this.fileUploadRepository.findOne({
            where: { id: fileId },
        });
        if (!file) {
            throw new common_1.NotFoundException('File not found');
        }
        const thumbnailPath = (0, path_1.join)(process.cwd(), 'uploads', 'thumbnails', file.filename);
        if (!(0, fs_1.existsSync)(thumbnailPath)) {
            throw new common_1.NotFoundException('Thumbnail not found');
        }
        const stream = (0, fs_1.createReadStream)(thumbnailPath);
        return { stream, file };
    }
    async getUserFiles(userId, category) {
        const whereCondition = { userId };
        if (category) {
            whereCondition.category = category;
        }
        return this.fileUploadRepository.find({
            where: whereCondition,
            order: { uploadedAt: 'DESC' },
        });
    }
    async deleteFile(fileId, userId) {
        const file = await this.fileUploadRepository.findOne({
            where: { id: fileId, userId },
        });
        if (!file) {
            throw new common_1.NotFoundException('File not found');
        }
        const filePath = (0, path_1.join)(process.cwd(), 'uploads', file.filename);
        if ((0, fs_1.existsSync)(filePath)) {
            (0, fs_1.unlinkSync)(filePath);
        }
        const thumbnailPath = (0, path_1.join)(process.cwd(), 'uploads', 'thumbnails', file.filename);
        if ((0, fs_1.existsSync)(thumbnailPath)) {
            (0, fs_1.unlinkSync)(thumbnailPath);
        }
        await this.fileUploadRepository.remove(file);
    }
    async updateFileMetadata(fileId, userId, metadata) {
        const file = await this.fileUploadRepository.findOne({
            where: { id: fileId, userId },
        });
        if (!file) {
            throw new common_1.NotFoundException('File not found');
        }
        Object.assign(file, metadata);
        return this.fileUploadRepository.save(file);
    }
    async getFileStats() {
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
    async generateThumbnail(filename) {
        try {
            const inputPath = (0, path_1.join)(process.cwd(), 'uploads', filename);
            const outputDir = (0, path_1.join)(process.cwd(), 'uploads', 'thumbnails');
            const outputPath = (0, path_1.join)(outputDir, filename);
            const fs = require('fs');
            if (!fs.existsSync(outputDir)) {
                fs.mkdirSync(outputDir, { recursive: true });
            }
            await sharp(inputPath)
                .resize(300, 300, { fit: 'inside', withoutEnlargement: true })
                .jpeg({ quality: 80 })
                .toFile(outputPath);
            return outputPath;
        }
        catch (error) {
            console.error('Error generating thumbnail:', error);
            return null;
        }
    }
    async uploadProfilePicture(file, userId) {
        if (!file.mimetype.startsWith('image/')) {
            throw new common_1.BadRequestException('Only image files are allowed for profile pictures');
        }
        await this.deleteUserProfilePicture(userId);
        return this.saveFile(file, userId, 'profile');
    }
    async getUserProfilePicture(userId) {
        return this.fileUploadRepository.findOne({
            where: { userId, category: 'profile' },
            order: { uploadedAt: 'DESC' },
        });
    }
    async deleteUserProfilePicture(userId) {
        const profilePicture = await this.getUserProfilePicture(userId);
        if (profilePicture) {
            await this.deleteFile(profilePicture.id, userId);
        }
    }
    async uploadDocument(file, userId) {
        return this.saveFile(file, userId, 'document');
    }
    async getUserDocuments(userId) {
        return this.getUserFiles(userId, 'document');
    }
    async uploadNoticeAttachment(file, userId) {
        return this.saveFile(file, userId, 'notice');
    }
    async getNoticeAttachments(noticeId) {
        return this.fileUploadRepository.find({
            where: { noticeId },
            order: { uploadedAt: 'DESC' },
        });
    }
};
exports.FilesService = FilesService;
exports.FilesService = FilesService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(file_upload_entity_1.FileUpload)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], FilesService);
//# sourceMappingURL=files.service.js.map