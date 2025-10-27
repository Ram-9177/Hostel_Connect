import { GatePass } from '../../gatepass/entities/gate-pass.entity';
export declare class GateEvent {
    id: string;
    gatePassId: string;
    studentId: string;
    studentName: string;
    eventType: 'IN' | 'OUT' | 'UNKNOWN';
    timestamp: Date;
    location: string;
    status: 'SUCCESS' | 'FAILED';
    qrCode: string;
    reason: string;
    securityGuardId: string;
    securityGuardName: string;
    createdAt: Date;
    updatedAt: Date;
    gatePass: GatePass;
}
