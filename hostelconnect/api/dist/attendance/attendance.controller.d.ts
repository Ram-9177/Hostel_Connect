import { AttendanceService, CreateAttendanceSessionDto, ScanAttendanceDto, ManualAttendanceDto } from './attendance.service';
export declare class AttendanceController {
    private readonly attendanceService;
    constructor(attendanceService: AttendanceService);
    createSession(createSessionDto: CreateAttendanceSessionDto): Promise<import("./entities/attendance-session.entity").AttendanceSession>;
    getRoster(id: string): Promise<{
        sessionId: string;
        totalStudents: number;
        roster: any[];
    }>;
    scan(scanDto: ScanAttendanceDto): Promise<import("./entities/attendance-check.entity").AttendanceCheck>;
    manual(manualDto: ManualAttendanceDto): Promise<import("./entities/attendance-check.entity").AttendanceCheck>;
    closeSession(id: string): Promise<import("./entities/attendance-session.entity").AttendanceSession>;
    getSummary(id: string): Promise<any>;
    generateQR(id: string): Promise<{
        qrToken: string;
    }>;
}
