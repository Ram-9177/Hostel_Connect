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
exports.FilesController = void 0;
const common_1 = require("@nestjs/common");
const platform_express_1 = require("@nestjs/platform-express");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const files_service_1 = require("./files.service");
let FilesController = class FilesController {
    constructor(filesService) {
        this.filesService = filesService;
    }
    async uploadFile(file, req, category = 'document') {
        if (!file) {
            throw new Error('No file uploaded');
        }
        return this.filesService.saveFile(file, req.user.id, category);
    }
    async uploadProfilePicture(file, req) {
        if (!file) {
            throw new Error('No file uploaded');
        }
        return this.filesService.uploadProfilePicture(file, req.user.id);
    }
    async uploadDocument(file, req) {
        if (!file) {
            throw new Error('No file uploaded');
        }
        return this.filesService.uploadDocument(file, req.user.id);
    }
    async getFile(id, req, res) {
        const { stream, file } = await this.filesService.getFile(id);
        res.set({
            'Content-Type': file.mimetype,
            'Content-Disposition': `inline; filename="${file.originalName}"`,
            'Content-Length': file.size.toString(),
        });
        stream.pipe(res);
    }
    async getThumbnail(id, res) {
        const { stream, file } = await this.filesService.getThumbnail(id);
        res.set({
            'Content-Type': 'image/jpeg',
            'Content-Disposition': `inline; filename="thumb_${file.originalName}"`,
        });
        stream.pipe(res);
    }
    async getUserFiles(req, category) {
        return this.filesService.getUserFiles(req.user.id, category);
    }
    async getUserProfilePicture(req) {
        return this.filesService.getUserProfilePicture(req.user.id);
    }
    async getUserDocuments(req) {
        return this.filesService.getUserDocuments(req.user.id);
    }
    async deleteFile(id, req) {
        await this.filesService.deleteFile(id, req.user.id);
        return { success: true };
    }
    async deleteProfilePicture(req) {
        await this.filesService.deleteUserProfilePicture(req.user.id);
        return { success: true };
    }
    async getFileStats(req) {
        if (!['SUPER_ADMIN', 'WARDEN_HEAD'].includes(req.user.role)) {
            throw new Error('Unauthorized to view file statistics');
        }
        return this.filesService.getFileStats();
    }
};
exports.FilesController = FilesController;
__decorate([
    (0, common_1.Post)('upload'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file')),
    (0, swagger_1.ApiConsumes)('multipart/form-data'),
    (0, swagger_1.ApiOperation)({ summary: 'Upload a file' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'File uploaded successfully' }),
    __param(0, (0, common_1.UploadedFile)()),
    __param(1, (0, common_1.Request)()),
    __param(2, (0, common_1.Body)('category')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, String]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "uploadFile", null);
__decorate([
    (0, common_1.Post)('upload/profile-picture'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file')),
    (0, swagger_1.ApiConsumes)('multipart/form-data'),
    (0, swagger_1.ApiOperation)({ summary: 'Upload profile picture' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Profile picture uploaded successfully' }),
    __param(0, (0, common_1.UploadedFile)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "uploadProfilePicture", null);
__decorate([
    (0, common_1.Post)('upload/document'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file')),
    (0, swagger_1.ApiConsumes)('multipart/form-data'),
    (0, swagger_1.ApiOperation)({ summary: 'Upload document' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Document uploaded successfully' }),
    __param(0, (0, common_1.UploadedFile)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "uploadDocument", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get file by ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'File retrieved successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getFile", null);
__decorate([
    (0, common_1.Get)('thumbnail/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get file thumbnail' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Thumbnail retrieved successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getThumbnail", null);
__decorate([
    (0, common_1.Get)('user/files'),
    (0, swagger_1.ApiOperation)({ summary: 'Get user files' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'User files retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)('category')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getUserFiles", null);
__decorate([
    (0, common_1.Get)('user/profile-picture'),
    (0, swagger_1.ApiOperation)({ summary: 'Get user profile picture' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Profile picture retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getUserProfilePicture", null);
__decorate([
    (0, common_1.Get)('user/documents'),
    (0, swagger_1.ApiOperation)({ summary: 'Get user documents' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'User documents retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getUserDocuments", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete file' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'File deleted successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "deleteFile", null);
__decorate([
    (0, common_1.Delete)('profile-picture'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete user profile picture' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Profile picture deleted successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "deleteProfilePicture", null);
__decorate([
    (0, common_1.Get)('stats/overview'),
    (0, swagger_1.ApiOperation)({ summary: 'Get file statistics (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'File statistics retrieved successfully' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], FilesController.prototype, "getFileStats", null);
exports.FilesController = FilesController = __decorate([
    (0, swagger_1.ApiTags)('Files'),
    (0, common_1.Controller)('files'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [files_service_1.FilesService])
], FilesController);
//# sourceMappingURL=files.controller.js.map