import { Hostel } from '../../hostels/entities/hostel.entity';
export declare class AttendanceSession {
    id: string;
    hostelId: string;
    wingIds: string[];
    date: Date;
    slot: string;
    startTime: Date;
    endTime: Date;
    mode: string;
    nonce: string;
    status: string;
    createdAt: Date;
    updatedAt: Date;
    hostel: Hostel;
}
