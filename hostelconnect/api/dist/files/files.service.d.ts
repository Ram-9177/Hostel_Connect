import { Repository } from 'typeorm';
import { FileUpload } from './entities/file-upload.entity';
export interface FileUploadResult {
    id: string;
    filename: string;
    originalName: string;
    mimetype: string;
    size: number;
    url: string;
    thumbnailUrl?: string;
}
export declare class FilesService {
    private readonly fileUploadRepository;
    constructor(fileUploadRepository: Repository<FileUpload>);
    saveFile(file: Express.Multer.File, userId: string, category?: 'profile' | 'document' | 'notice'): Promise<FileUploadResult>;
    getFile(fileId: string): Promise<{
        stream: NodeJS.ReadableStream;
        file: FileUpload;
    }>;
    getThumbnail(fileId: string): Promise<{
        stream: NodeJS.ReadableStream;
        file: FileUpload;
    }>;
    getUserFiles(userId: string, category?: string): Promise<FileUpload[]>;
    deleteFile(fileId: string, userId: string): Promise<void>;
    updateFileMetadata(fileId: string, userId: string, metadata: any): Promise<FileUpload>;
    getFileStats(): Promise<{
        totalFiles: number;
        totalSize: number;
        filesByCategory: {
            [key: string]: number;
        };
        filesByMimetype: {
            [key: string]: number;
        };
    }>;
    private generateThumbnail;
    uploadProfilePicture(file: Express.Multer.File, userId: string): Promise<FileUploadResult>;
    getUserProfilePicture(userId: string): Promise<FileUpload | null>;
    deleteUserProfilePicture(userId: string): Promise<void>;
    uploadDocument(file: Express.Multer.File, userId: string): Promise<FileUploadResult>;
    getUserDocuments(userId: string): Promise<FileUpload[]>;
    uploadNoticeAttachment(file: Express.Multer.File, userId: string): Promise<FileUploadResult>;
    getNoticeAttachments(noticeId: string): Promise<FileUpload[]>;
}
