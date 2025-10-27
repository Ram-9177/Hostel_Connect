import { Repository } from 'typeorm';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';
export declare class GateService {
    private readonly gateEventRepository;
    private readonly gatePassRepository;
    constructor(gateEventRepository: Repository<GateEvent>, gatePassRepository: Repository<GatePass>);
    scanGatePass(scanDto: ScanGatePassDto): Promise<{
        success: boolean;
        message: string;
        event: any;
        gatePass?: undefined;
        error?: undefined;
    } | {
        success: boolean;
        message: string;
        event: GateEvent;
        gatePass: GatePass;
        error?: undefined;
    } | {
        success: boolean;
        message: string;
        error: any;
        event: GateEvent;
        gatePass?: undefined;
    }>;
    validateGatePass(qrCode: string): Promise<GatePass>;
    determineEventType(studentId: string): Promise<'IN' | 'OUT'>;
    getGateEvents(): Promise<GateEvent[]>;
    getTodayEvents(): Promise<GateEvent[]>;
    getStudentEvents(studentId: string): Promise<GateEvent[]>;
    getGateStats(): Promise<{
        totalScans: number;
        successfulScans: number;
        failedScans: number;
        studentsOut: number;
        studentsIn: number;
        uniqueStudents: number;
    }>;
    private extractPassIdFromQR;
}
