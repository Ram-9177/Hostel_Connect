import { GatePassType } from '../entities/gate-pass.entity';
export declare class CreateGatePassDto {
    studentId: string;
    reason: string;
    description?: string;
    startTime: string;
    endTime: string;
    type?: GatePassType;
    isEmergency?: boolean;
}
export declare class ApproveGatePassDto {
    reason: string;
    note?: string;
}
export declare class RejectGatePassDto {
    reason: string;
}
