import { Repository } from 'typeorm';
import { Device } from './entities/device.entity';
import { FirebaseService } from './firebase.service';
export interface DeviceRegistrationDto {
    deviceToken: string;
    deviceType: 'ios' | 'android' | 'web';
    deviceName?: string;
    appVersion?: string;
    osVersion?: string;
}
export declare class DeviceService {
    private readonly deviceRepository;
    private readonly firebaseService;
    constructor(deviceRepository: Repository<Device>, firebaseService: FirebaseService);
    registerDevice(userId: string, deviceData: DeviceRegistrationDto): Promise<Device>;
    unregisterDevice(deviceToken: string): Promise<void>;
    getDevicesForUser(userId: string): Promise<Device[]>;
    getDeviceTokensForUser(userId: string): Promise<string[]>;
    getDevicesForRole(role: string): Promise<Device[]>;
    getDeviceTokensForRole(role: string): Promise<string[]>;
    updateDeviceLastActive(deviceToken: string): Promise<void>;
    deactivateInactiveDevices(daysInactive?: number): Promise<number>;
    getDeviceStats(): Promise<{
        totalDevices: number;
        activeDevices: number;
        devicesByType: {
            [key: string]: number;
        };
        devicesByRole: {
            [key: string]: number;
        };
    }>;
}
