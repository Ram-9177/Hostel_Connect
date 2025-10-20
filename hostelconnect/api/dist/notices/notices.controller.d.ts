import { NoticesService } from './notices.service';
export declare class NoticesController {
    private readonly noticesService;
    constructor(noticesService: NoticesService);
    findAll(): Promise<{
        message: string;
    }>;
    create(createDto: any): Promise<{
        message: string;
    }>;
}
