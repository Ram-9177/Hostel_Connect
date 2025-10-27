import { Repository } from 'typeorm';
import { GatePass } from './entities/gate-pass.entity';
import { Student } from '../students/entities/student.entity';
import { CreateGatePassDto, ApproveGatePassDto, RejectGatePassDto } from './dto/create-gate-pass.dto';
export declare class GatePassService {
    private readonly gatePassRepository;
    private readonly studentRepository;
    constructor(gatePassRepository: Repository<GatePass>, studentRepository: Repository<Student>);
    createGatePass(createGatePassDto: CreateGatePassDto): Promise<GatePass>;
    getAllGatePasses(): Promise<GatePass[]>;
    getPendingGatePasses(): Promise<GatePass[]>;
    getStudentGatePasses(studentId: string): Promise<GatePass[]>;
    approveGatePass(id: string, approveDto: ApproveGatePassDto): Promise<GatePass>;
    rejectGatePass(id: string, rejectDto: RejectGatePassDto): Promise<GatePass>;
    generateQRCode(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
    useGatePass(id: string): Promise<GatePass>;
    refreshQRToken(id: string): Promise<{
        qrToken: string;
        expiresAt: Date;
    }>;
}
