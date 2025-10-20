import { GatePass } from '../../gatepass/entities/gate-pass.entity';
import { Student } from '../../students/entities/student.entity';
import { Device } from '../../devices/entities/device.entity';
import { User } from '../../users/entities/user.entity';
export declare class GateEvent {
    id: string;
    passId: string;
    studentId: string;
    eventType: string;
    method: string;
    deviceId?: string;
    guardUserId?: string;
    timestamp: Date;
    latitude?: number;
    longitude?: number;
    createdAt: Date;
    pass: GatePass;
    student: Student;
    device?: Device;
    guardUser?: User;
}
