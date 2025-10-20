import { Repository } from 'typeorm';
import { GatePass, GatePassType } from './entities/gate-pass.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
import { AdEvent } from '../ads/entities/ad-event.entity';
export interface CreateGatePassDto {
    studentId: string;
    hostelId: string;
    type: GatePassType;
    startTime: Date;
    endTime: Date;
    reason: string;
    note?: string;
    isEmergency?: boolean;
}
export interface ApproveGatePassDto {
    approved: boolean;
    reason?: string;
}
export declare class GatePassService {
    private readonly gatePassRepository;
    private readonly adEventRepository;
    private readonly qrTokenService;
    constructor(gatePassRepository: Repository<GatePass>, adEventRepository: Repository<AdEvent>, qrTokenService: QRTokenService);
    create(createDto: CreateGatePassDto, studentId: string): Promise<GatePass>;
    findAll(studentId?: string, hostelId?: string): Promise<GatePass[]>;
    findById(id: string): Promise<GatePass>;
    approve(id: string, approveDto: ApproveGatePassDto, wardenId: string): Promise<GatePass>;
    cancel(id: string, studentId: string): Promise<GatePass>;
    getQRToken(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
        adRequired: boolean;
    }>;
    refreshQRToken(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
    checkAdWatched(studentId: string, module: string): Promise<boolean>;
    markAdWatched(studentId: string, adId: string, module: string): Promise<void>;
    unlockQRTokenAfterAd(id: string, studentId: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
}
