import { Controller, Post, Get, Delete, Param, UseGuards, Request, UseInterceptors, UploadedFile, Body } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiConsumes } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { Response } from 'express';
import { FilesService } from './files.service';

@ApiTags('Files')
@Controller('files')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class FilesController {
  constructor(private readonly filesService: FilesService) {}

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  @ApiConsumes('multipart/form-data')
  @ApiOperation({ summary: 'Upload a file' })
  @ApiResponse({ status: 201, description: 'File uploaded successfully' })
  async uploadFile(
    @UploadedFile() file: Express.Multer.File,
    @Request() req,
    @Body('category') category: 'profile' | 'document' | 'notice' = 'document',
  ) {
    if (!file) {
      throw new Error('No file uploaded');
    }

    return this.filesService.saveFile(file, req.user.id, category);
  }

  @Post('upload/profile-picture')
  @UseInterceptors(FileInterceptor('file'))
  @ApiConsumes('multipart/form-data')
  @ApiOperation({ summary: 'Upload profile picture' })
  @ApiResponse({ status: 201, description: 'Profile picture uploaded successfully' })
  async uploadProfilePicture(
    @UploadedFile() file: Express.Multer.File,
    @Request() req,
  ) {
    if (!file) {
      throw new Error('No file uploaded');
    }

    return this.filesService.uploadProfilePicture(file, req.user.id);
  }

  @Post('upload/document')
  @UseInterceptors(FileInterceptor('file'))
  @ApiConsumes('multipart/form-data')
  @ApiOperation({ summary: 'Upload document' })
  @ApiResponse({ status: 201, description: 'Document uploaded successfully' })
  async uploadDocument(
    @UploadedFile() file: Express.Multer.File,
    @Request() req,
  ) {
    if (!file) {
      throw new Error('No file uploaded');
    }

    return this.filesService.uploadDocument(file, req.user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get file by ID' })
  @ApiResponse({ status: 200, description: 'File retrieved successfully' })
  async getFile(@Param('id') id: string, @Request() req, res: Response) {
    const { stream, file } = await this.filesService.getFile(id);
    
    res.set({
      'Content-Type': file.mimetype,
      'Content-Disposition': `inline; filename="${file.originalName}"`,
      'Content-Length': file.size.toString(),
    });

    stream.pipe(res);
  }

  @Get('thumbnail/:id')
  @ApiOperation({ summary: 'Get file thumbnail' })
  @ApiResponse({ status: 200, description: 'Thumbnail retrieved successfully' })
  async getThumbnail(@Param('id') id: string, res: Response) {
    const { stream, file } = await this.filesService.getThumbnail(id);
    
    res.set({
      'Content-Type': 'image/jpeg',
      'Content-Disposition': `inline; filename="thumb_${file.originalName}"`,
    });

    stream.pipe(res);
  }

  @Get('user/files')
  @ApiOperation({ summary: 'Get user files' })
  @ApiResponse({ status: 200, description: 'User files retrieved successfully' })
  async getUserFiles(
    @Request() req,
    @Body('category') category?: string,
  ) {
    return this.filesService.getUserFiles(req.user.id, category);
  }

  @Get('user/profile-picture')
  @ApiOperation({ summary: 'Get user profile picture' })
  @ApiResponse({ status: 200, description: 'Profile picture retrieved successfully' })
  async getUserProfilePicture(@Request() req) {
    return this.filesService.getUserProfilePicture(req.user.id);
  }

  @Get('user/documents')
  @ApiOperation({ summary: 'Get user documents' })
  @ApiResponse({ status: 200, description: 'User documents retrieved successfully' })
  async getUserDocuments(@Request() req) {
    return this.filesService.getUserDocuments(req.user.id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete file' })
  @ApiResponse({ status: 200, description: 'File deleted successfully' })
  async deleteFile(@Param('id') id: string, @Request() req) {
    await this.filesService.deleteFile(id, req.user.id);
    return { success: true };
  }

  @Delete('profile-picture')
  @ApiOperation({ summary: 'Delete user profile picture' })
  @ApiResponse({ status: 200, description: 'Profile picture deleted successfully' })
  async deleteProfilePicture(@Request() req) {
    await this.filesService.deleteUserProfilePicture(req.user.id);
    return { success: true };
  }

  @Get('stats/overview')
  @ApiOperation({ summary: 'Get file statistics (Admin only)' })
  @ApiResponse({ status: 200, description: 'File statistics retrieved successfully' })
  async getFileStats(@Request() req) {
    // Check if user is admin
    if (!['SUPER_ADMIN', 'WARDEN_HEAD'].includes(req.user.role)) {
      throw new Error('Unauthorized to view file statistics');
    }

    return this.filesService.getFileStats();
  }
}
