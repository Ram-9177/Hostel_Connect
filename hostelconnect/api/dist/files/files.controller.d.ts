import { Response } from 'express';
import { FilesService } from './files.service';
export declare class FilesController {
    private readonly filesService;
    constructor(filesService: FilesService);
    uploadFile(file: Express.Multer.File, req: any, category?: 'profile' | 'document' | 'notice'): Promise<import("./files.service").FileUploadResult>;
    uploadProfilePicture(file: Express.Multer.File, req: any): Promise<import("./files.service").FileUploadResult>;
    uploadDocument(file: Express.Multer.File, req: any): Promise<import("./files.service").FileUploadResult>;
    getFile(id: string, req: any, res: Response): Promise<void>;
    getThumbnail(id: string, res: Response): Promise<void>;
    getUserFiles(req: any, category?: string): Promise<import("./entities/file-upload.entity").FileUpload[]>;
    getUserProfilePicture(req: any): Promise<import("./entities/file-upload.entity").FileUpload>;
    getUserDocuments(req: any): Promise<import("./entities/file-upload.entity").FileUpload[]>;
    deleteFile(id: string, req: any): Promise<{
        success: boolean;
    }>;
    deleteProfilePicture(req: any): Promise<{
        success: boolean;
    }>;
    getFileStats(req: any): Promise<{
        totalFiles: number;
        totalSize: number;
        filesByCategory: {
            [key: string]: number;
        };
        filesByMimetype: {
            [key: string]: number;
        };
    }>;
}
