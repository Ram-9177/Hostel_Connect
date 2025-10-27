import { GatePassService } from './gatepass.service';
import { CreateGatePassDto, ApproveGatePassDto, RejectGatePassDto } from './dto/create-gate-pass.dto';
export declare class GatePassController {
    private readonly gatePassService;
    constructor(gatePassService: GatePassService);
    createGatePass(createGatePassDto: CreateGatePassDto): Promise<import("./entities/gate-pass.entity").GatePass>;
    getAllGatePasses(): Promise<import("./entities/gate-pass.entity").GatePass[]>;
    getPendingGatePasses(): Promise<import("./entities/gate-pass.entity").GatePass[]>;
    getStudentGatePasses(studentId: string): Promise<import("./entities/gate-pass.entity").GatePass[]>;
    approveGatePass(id: string, approveDto: ApproveGatePassDto): Promise<import("./entities/gate-pass.entity").GatePass>;
    rejectGatePass(id: string, rejectDto: RejectGatePassDto): Promise<import("./entities/gate-pass.entity").GatePass>;
    getQRCode(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
    useGatePass(id: string): Promise<import("./entities/gate-pass.entity").GatePass>;
}
