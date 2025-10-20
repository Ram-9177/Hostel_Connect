export declare class DevicesService {
    findAll(): Promise<{
        message: string;
    }>;
    create(createDeviceDto: any): Promise<{
        message: string;
    }>;
}
