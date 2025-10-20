import { DevicesService } from './devices.service';
export declare class DevicesController {
    private readonly devicesService;
    constructor(devicesService: DevicesService);
    findAll(): Promise<{
        message: string;
    }>;
    create(createDeviceDto: any): Promise<{
        message: string;
    }>;
}
