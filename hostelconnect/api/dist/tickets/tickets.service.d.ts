export declare class TicketsService {
    findAll(): Promise<{
        message: string;
    }>;
    create(createDto: any): Promise<{
        message: string;
    }>;
}
