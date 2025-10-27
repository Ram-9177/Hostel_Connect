import { Student } from '../../students/entities/student.entity';
export declare enum GatePassType {
    REGULAR = "REGULAR",
    EMERGENCY = "EMERGENCY",
    MEDICAL = "MEDICAL",
    FAMILY = "FAMILY",
    ACADEMIC = "ACADEMIC",
    FOOD = "FOOD"
}
export declare enum GatePassStatus {
    PENDING = "PENDING",
    APPROVED = "APPROVED",
    REJECTED = "REJECTED",
    ACTIVE = "ACTIVE",
    COMPLETED = "COMPLETED",
    EXPIRED = "EXPIRED"
}
export declare class GatePass {
    id: string;
    studentId: string;
    firstName: string;
    lastName: string;
    hostelId: string;
    roomNumber: string;
    reason: string;
    description: string;
    startTime: Date;
    endTime: Date;
    status: GatePassStatus;
    type: GatePassType;
    approvedBy: string;
    approvedByName: string;
    approvedAt: Date;
    rejectedBy: string;
    rejectedByName: string;
    rejectedAt: Date;
    rejectionReason: string;
    qrCode: string;
    qrTokenHash: string;
    qrTokenExpiresAt: Date;
    lastUsedAt: Date;
    completedAt: Date;
    expiredAt: Date;
    isEmergency: boolean;
    decisionBy: string;
    decisionAt: Date;
    note: string;
    createdAt: Date;
    updatedAt: Date;
    student: Student;
}
