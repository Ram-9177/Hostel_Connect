export declare class NoticesService {
    findAll(): Promise<{
        message: string;
    }>;
    create(createDto: any): Promise<{
        message: string;
    }>;
}
