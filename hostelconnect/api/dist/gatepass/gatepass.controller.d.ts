import { GatePassService } from './gatepass.service';
import { CreateGatePassDto } from './dto/create-gate-pass.dto';
import { ApproveGatePassDto } from './dto/approve-gate-pass.dto';
export declare class GatePassController {
    private readonly gatePassService;
    constructor(gatePassService: GatePassService);
    create(createDto: CreateGatePassDto, req: any): Promise<import("./entities/gate-pass.entity").GatePass>;
    findAll(req: any): Promise<import("./entities/gate-pass.entity").GatePass[]>;
    findOne(id: string): Promise<import("./entities/gate-pass.entity").GatePass>;
    approve(id: string, approveDto: ApproveGatePassDto, req: any): Promise<import("./entities/gate-pass.entity").GatePass>;
    cancel(id: string, req: any): Promise<import("./entities/gate-pass.entity").GatePass>;
    getQRToken(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
        adRequired: boolean;
    }>;
    unlockQRTokenAfterAd(id: string, req: any): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
    markAdWatched(id: string, body: {
        adId: string;
    }, req: any): Promise<{
        message: string;
    }>;
    refreshQRToken(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
}
