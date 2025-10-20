import { Repository } from 'typeorm';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
export interface ScanGatePassDto {
    qrToken: string;
    eventType: string;
    deviceId?: string;
    guardUserId?: string;
    latitude?: number;
    longitude?: number;
}
export declare class GateService {
    private readonly gateEventRepository;
    private readonly gatePassRepository;
    private readonly qrTokenService;
    constructor(gateEventRepository: Repository<GateEvent>, gatePassRepository: Repository<GatePass>, qrTokenService: QRTokenService);
    scanGatePass(scanDto: ScanGatePassDto): Promise<GateEvent>;
    getGatePassEvents(passId: string): Promise<GateEvent[]>;
    getStudentGateEvents(studentId: string, limit?: number): Promise<GateEvent[]>;
}
