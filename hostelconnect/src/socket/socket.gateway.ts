import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Injectable, UseGuards } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { SocketService } from './socket.service';
import { NotificationService } from './notification.service';

@Injectable()
@WebSocketGateway({
  cors: {
    origin: process.env.FRONTEND_URL || 'http://localhost:3000',
    credentials: true,
  },
  namespace: '/notifications',
})
export class SocketGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private connectedUsers = new Map<string, string>(); // userId -> socketId

  constructor(
    private readonly socketService: SocketService,
    private readonly notificationService: NotificationService,
    private readonly jwtService: JwtService,
  ) {}

  async handleConnection(client: Socket) {
    try {
      const token = client.handshake.auth?.token || client.handshake.headers?.authorization?.replace('Bearer ', '');
      
      if (!token) {
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token);
      const userId = payload.sub;

      // Store user connection
      this.connectedUsers.set(userId, client.id);
      client.data.userId = userId;
      client.data.userRole = payload.role;

      // Join user to their role-based room
      client.join(`user:${userId}`);
      client.join(`role:${payload.role}`);

      console.log(`User ${userId} connected with socket ${client.id}`);

      // Send connection confirmation
      client.emit('connected', {
        message: 'Connected to HostelConnect notifications',
        userId,
        role: payload.role,
      });

      // Send any pending notifications
      await this.sendPendingNotifications(userId, client);

    } catch (error) {
      console.error('Connection error:', error);
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    const userId = client.data.userId;
    if (userId) {
      this.connectedUsers.delete(userId);
      console.log(`User ${userId} disconnected`);
    }
  }

  @SubscribeMessage('join_room')
  async handleJoinRoom(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { room: string },
  ) {
    const userId = client.data.userId;
    const room = data.room;

    // Validate room access based on user role
    if (this.canJoinRoom(client.data.userRole, room)) {
      client.join(room);
      client.emit('joined_room', { room });
      console.log(`User ${userId} joined room ${room}`);
    } else {
      client.emit('error', { message: 'Unauthorized to join this room' });
    }
  }

  @SubscribeMessage('leave_room')
  async handleLeaveRoom(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { room: string },
  ) {
    client.leave(data.room);
    client.emit('left_room', { room: data.room });
  }

  @SubscribeMessage('mark_notification_read')
  async handleMarkNotificationRead(
    @ConnectedSocket() client: Socket,
    @MessageBody() data: { notificationId: string },
  ) {
    const userId = client.data.userId;
    await this.notificationService.markAsRead(data.notificationId, userId);
    
    client.emit('notification_read', { 
      notificationId: data.notificationId,
      success: true 
    });
  }

  // Broadcast methods for different notification types
  async broadcastGatePassUpdate(gatePassId: string, update: any) {
    this.server.emit('gate_pass_update', {
      gatePassId,
      update,
      timestamp: new Date(),
    });
  }

  async broadcastAttendanceUpdate(studentId: string, attendance: any) {
    this.server.emit('attendance_update', {
      studentId,
      attendance,
      timestamp: new Date(),
    });
  }

  async broadcastRoomAllocationUpdate(allocation: any) {
    this.server.emit('room_allocation_update', {
      allocation,
      timestamp: new Date(),
    });
  }

  async broadcastMealIntentUpdate(mealIntent: any) {
    this.server.emit('meal_intent_update', {
      mealIntent,
      timestamp: new Date(),
    });
  }

  async broadcastNotice(notice: any) {
    // Broadcast to all users or specific roles
    if (notice.targetRoles && notice.targetRoles.length > 0) {
      notice.targetRoles.forEach((role: string) => {
        this.server.to(`role:${role}`).emit('new_notice', {
          notice,
          timestamp: new Date(),
        });
      });
    } else {
      this.server.emit('new_notice', {
        notice,
        timestamp: new Date(),
      });
    }
  }

  async sendNotificationToUser(userId: string, notification: any) {
    const socketId = this.connectedUsers.get(userId);
    if (socketId) {
      this.server.to(socketId).emit('notification', {
        notification,
        timestamp: new Date(),
      });
    }
  }

  async sendNotificationToRole(role: string, notification: any) {
    this.server.to(`role:${role}`).emit('notification', {
      notification,
      timestamp: new Date(),
    });
  }

  private async sendPendingNotifications(userId: string, client: Socket) {
    try {
      const pendingNotifications = await this.notificationService.getPendingNotifications(userId);
      
      if (pendingNotifications.length > 0) {
        client.emit('pending_notifications', {
          notifications: pendingNotifications,
          count: pendingNotifications.length,
        });
      }
    } catch (error) {
      console.error('Error sending pending notifications:', error);
    }
  }

  private canJoinRoom(userRole: string, room: string): boolean {
    // Define room access rules based on user role
    const rolePermissions = {
      'SUPER_ADMIN': ['admin', 'warden', 'student', 'chef'],
      'WARDEN_HEAD': ['warden', 'student'],
      'WARDEN': ['student'],
      'STUDENT': [],
      'CHEF': ['kitchen'],
    };

    const allowedRooms = rolePermissions[userRole] || [];
    return allowedRooms.some(allowedRoom => room.includes(allowedRoom));
  }
}
