import { AttendanceSession } from './attendance-session.entity';
import { Student } from '../../students/entities/student.entity';
import { User } from '../../users/entities/user.entity';
import { Device } from '../../devices/entities/device.entity';
export declare enum AttendanceCheckMethod {
    STUDENT_QR = "STUDENT_QR",
    MANUAL = "MANUAL",
    GATE = "GATE"
}
export declare class AttendanceCheck {
    id: string;
    sessionId: string;
    studentId: string;
    method: string;
    timestamp: Date;
    wardenId?: string;
    deviceId?: string;
    reason?: string;
    photoUrl?: string;
    createdAt: Date;
    session: AttendanceSession;
    student: Student;
    warden?: User;
    device?: Device;
}
