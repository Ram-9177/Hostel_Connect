import { GateService } from './gate.service';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';
export declare class GateController {
    private readonly gateService;
    constructor(gateService: GateService);
    scanGatePass(scanDto: ScanGatePassDto): Promise<{
        success: boolean;
        message: string;
        event: any;
        gatePass?: undefined;
        error?: undefined;
    } | {
        success: boolean;
        message: string;
        event: import("./entities/gate-event.entity").GateEvent;
        gatePass: import("../gatepass/entities/gate-pass.entity").GatePass;
        error?: undefined;
    } | {
        success: boolean;
        message: string;
        error: any;
        event: import("./entities/gate-event.entity").GateEvent;
        gatePass?: undefined;
    }>;
    getGateEvents(): Promise<import("./entities/gate-event.entity").GateEvent[]>;
    getTodayEvents(): Promise<import("./entities/gate-event.entity").GateEvent[]>;
    getStudentEvents(studentId: string): Promise<import("./entities/gate-event.entity").GateEvent[]>;
    getGateStats(): Promise<{
        totalScans: number;
        successfulScans: number;
        failedScans: number;
        studentsOut: number;
        studentsIn: number;
        uniqueStudents: number;
    }>;
    validateGatePass(body: {
        qrCode: string;
    }): Promise<import("../gatepass/entities/gate-pass.entity").GatePass>;
}
