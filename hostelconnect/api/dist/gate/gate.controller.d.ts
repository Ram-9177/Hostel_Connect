import { GateService } from './gate.service';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';
export declare class GateController {
    private readonly gateService;
    constructor(gateService: GateService);
    scan(scanDto: ScanGatePassDto): Promise<import("./entities/gate-event.entity").GateEvent>;
    getGatePassEvents(passId: string): Promise<import("./entities/gate-event.entity").GateEvent[]>;
    getStudentGateEvents(studentId: string): Promise<import("./entities/gate-event.entity").GateEvent[]>;
}
