import { Hostel } from '../../hostels/entities/hostel.entity';
export declare enum DeviceType {
    KIOSK_SCANNER = "KIOSK_SCANNER",
    WARDEN_SCANNER = "WARDEN_SCANNER",
    GATE = "GATE"
}
export declare class Device {
    id: string;
    deviceId: string;
    name: string;
    type: string;
    hostelId: string;
    location?: string;
    isActive: boolean;
    lastSeen?: Date;
    createdAt: Date;
    updatedAt: Date;
    hostel: Hostel;
}
