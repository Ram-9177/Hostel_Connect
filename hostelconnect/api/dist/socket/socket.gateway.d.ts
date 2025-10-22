import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { JwtService } from '@nestjs/jwt';
import { SocketService } from './socket.service';
import { NotificationService } from './notification.service';
export declare class SocketGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private readonly socketService;
    private readonly notificationService;
    private readonly jwtService;
    server: Server;
    private connectedUsers;
    constructor(socketService: SocketService, notificationService: NotificationService, jwtService: JwtService);
    handleConnection(client: Socket): Promise<void>;
    handleDisconnect(client: Socket): void;
    handleJoinRoom(client: Socket, data: {
        room: string;
    }): Promise<void>;
    handleLeaveRoom(client: Socket, data: {
        room: string;
    }): Promise<void>;
    handleMarkNotificationRead(client: Socket, data: {
        notificationId: string;
    }): Promise<void>;
    broadcastGatePassUpdate(gatePassId: string, update: any): Promise<void>;
    broadcastAttendanceUpdate(studentId: string, attendance: any): Promise<void>;
    broadcastRoomAllocationUpdate(allocation: any): Promise<void>;
    broadcastMealIntentUpdate(mealIntent: any): Promise<void>;
    broadcastNotice(notice: any): Promise<void>;
    sendNotificationToUser(userId: string, notification: any): Promise<void>;
    sendNotificationToRole(role: string, notification: any): Promise<void>;
    private sendPendingNotifications;
    private canJoinRoom;
}
