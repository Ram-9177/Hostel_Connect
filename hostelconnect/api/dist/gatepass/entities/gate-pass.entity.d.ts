export declare enum GatePassType {
    OUTING = "OUTING",
    EMERGENCY = "EMERGENCY"
}
export declare enum GatePassStatus {
    PENDING = "PENDING",
    APPROVED = "APPROVED",
    REJECTED = "REJECTED",
    CANCELLED = "CANCELLED",
    EXPIRED = "EXPIRED"
}
export declare class GatePass {
    id: string;
    studentId: string;
    hostelId: string;
    type: string;
    startTime: Date;
    endTime: Date;
    status: string;
    reason: string;
    note?: string;
    decisionBy?: string;
    decisionAt?: Date;
    qrTokenHash?: string;
    qrTokenExpiresAt?: Date;
    isEmergency: boolean;
    createdAt: Date;
    updatedAt: Date;
    student?: any;
    hostel?: any;
    decisionByUser?: any;
}
