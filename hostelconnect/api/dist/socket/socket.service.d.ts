import { SocketGateway } from './socket.gateway';
export declare class SocketService {
    private readonly socketGateway;
    constructor(socketGateway: SocketGateway);
    notifyGatePassUpdate(gatePassId: string, update: any): Promise<void>;
    notifyGatePassStatusChange(gatePassId: string, studentId: string, status: string): Promise<void>;
    notifyAttendanceUpdate(studentId: string, attendance: any): Promise<void>;
    notifyAttendanceRecorded(studentId: string, attendanceData: any): Promise<void>;
    notifyRoomAllocation(allocation: any): Promise<void>;
    notifyRoomAllocated(studentId: string, roomData: any): Promise<void>;
    notifyMealIntentUpdate(mealIntent: any): Promise<void>;
    notifyMealIntentReminder(studentId: string, mealData: any): Promise<void>;
    notifyNewNotice(notice: any): Promise<void>;
    notifyEmergencyNotice(notice: any): Promise<void>;
    notifySystemMaintenance(message: string, targetRole?: string): Promise<void>;
    notifySystemUpdate(message: string): Promise<void>;
    notifyUser(userId: string, notification: any): Promise<void>;
    notifyRole(role: string, notification: any): Promise<void>;
    broadcastToAll(notification: any): Promise<void>;
}
