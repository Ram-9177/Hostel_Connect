import { Repository } from 'typeorm';
import { GatePass } from './entities/gate-pass.entity';
import { Student } from '../students/entities/student.entity';
import { CreateGatePassDto, ApproveGatePassDto, RejectGatePassDto } from './dto/create-gate-pass.dto';
import { SocketGateway } from '../socket/socket.gateway';
export declare class GatePassService {
    private readonly gatePassRepository;
    private readonly studentRepository;
    private readonly socketGateway;
    constructor(gatePassRepository: Repository<GatePass>, studentRepository: Repository<Student>, socketGateway: SocketGateway);
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
