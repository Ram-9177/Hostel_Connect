import { TicketsService } from './tickets.service';
export declare class TicketsController {
    private readonly ticketsService;
    constructor(ticketsService: TicketsService);
    findAll(): Promise<{
        message: string;
    }>;
    create(createDto: any): Promise<{
        message: string;
    }>;
}
