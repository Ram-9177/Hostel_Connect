import { GatePassType } from '../entities/gate-pass.entity';
export declare class CreateGatePassDto {
    studentId: string;
    hostelId: string;
    type: GatePassType;
    startTime: Date;
    endTime: Date;
    reason: string;
    note?: string;
    isEmergency?: boolean;
}
export declare class ApproveGatePassDto {
    approved: boolean;
    reason?: string;
}
