export declare class RoomsService {
    getMap(): Promise<{
        message: string;
    }>;
    allocate(allocateDto: any): Promise<{
        message: string;
    }>;
    transfer(transferDto: any): Promise<{
        message: string;
    }>;
    swap(swapDto: any): Promise<{
        message: string;
    }>;
}
