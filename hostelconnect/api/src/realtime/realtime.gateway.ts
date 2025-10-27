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
import { JwtService } from '@nestjs/jwt';
import { Injectable, UseGuards } from '@nestjs/common';
import { WsJwtGuard } from './ws-jwt.guard';

@Injectable()
@WebSocketGateway({
  cors: {
    origin: '*',
    methods: ['GET', 'POST'],
  },
  namespace: '/hostelconnect',
})
export class RealtimeGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private connectedUsers = new Map<string, { socketId: string; user: any }>();

  constructor(private readonly jwtService: JwtService) {}

  async handleConnection(client: Socket) {
    try {
      const token = client.handshake.auth.token;
      if (!token) {
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token);
      const user = {
        id: payload.sub,
        email: payload.email,
        role: payload.role,
        hostelId: payload.hostelId,
      };

      this.connectedUsers.set(client.id, { socketId: client.id, user });
      
      // Join user to their hostel room for hostel-specific updates
      client.join(`hostel_${user.hostelId}`);
      
      // Join user to their role room for role-specific updates
      client.join(`role_${user.role}`);
      
      // Join user to their personal room
      client.join(`user_${user.id}`);

      // Notify others in the hostel that user is online
      client.to(`hostel_${user.hostelId}`).emit('user_online', {
        userId: user.id,
        role: user.role,
        timestamp: new Date(),
      });

      // Send connection confirmation
      client.emit('connected', {
        message: 'Connected to HostelConnect real-time updates',
        user: user,
        timestamp: new Date(),
      });

      console.log(`User ${user.email} connected with socket ${client.id}`);
    } catch (error) {
      console.error('Connection error:', error);
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    const userData = this.connectedUsers.get(client.id);
    if (userData) {
      const { user } = userData;
      
      // Notify others in the hostel that user is offline
      client.to(`hostel_${user.hostelId}`).emit('user_offline', {
        userId: user.id,
        role: user.role,
        timestamp: new Date(),
      });

      this.connectedUsers.delete(client.id);
      console.log(`User ${user.email} disconnected`);
    }
  }

  @SubscribeMessage('join_room')
  handleJoinRoom(
    @MessageBody() data: { roomId: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData) {
      client.join(data.roomId);
      client.emit('joined_room', { roomId: data.roomId });
    }
  }

  @SubscribeMessage('leave_room')
  handleLeaveRoom(
    @MessageBody() data: { roomId: string },
    @ConnectedSocket() client: Socket,
  ) {
    client.leave(data.roomId);
    client.emit('left_room', { roomId: data.roomId });
  }

  @SubscribeMessage('gate_pass_request')
  handleGatePassRequest(
    @MessageBody() data: { studentId: string; reason: string; startTime: string; endTime: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData && userData.user.role === 'STUDENT') {
      // Notify wardens in the same hostel
      client.to(`hostel_${userData.user.hostelId}`).emit('new_gate_pass_request', {
        studentId: data.studentId,
        reason: data.reason,
        startTime: data.startTime,
        endTime: data.endTime,
        timestamp: new Date(),
      });
    }
  }

  @SubscribeMessage('gate_pass_approved')
  handleGatePassApproved(
    @MessageBody() data: { studentId: string; passId: string; approved: boolean },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData && userData.user.role === 'WARDEN') {
      // Notify the specific student
      client.to(`user_${data.studentId}`).emit('gate_pass_status_update', {
        passId: data.passId,
        approved: data.approved,
        timestamp: new Date(),
      });
    }
  }

  @SubscribeMessage('attendance_session_started')
  handleAttendanceSessionStarted(
    @MessageBody() data: { sessionId: string; sessionName: string; qrCode: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData && userData.user.role === 'WARDEN') {
      // Notify all students in the hostel
      client.to(`hostel_${userData.user.hostelId}`).emit('attendance_session_started', {
        sessionId: data.sessionId,
        sessionName: data.sessionName,
        qrCode: data.qrCode,
        timestamp: new Date(),
      });
    }
  }

  @SubscribeMessage('attendance_marked')
  handleAttendanceMarked(
    @MessageBody() data: { studentId: string; sessionId: string; status: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData) {
      // Notify wardens about attendance
      client.to(`hostel_${userData.user.hostelId}`).emit('attendance_marked', {
        studentId: data.studentId,
        sessionId: data.sessionId,
        status: data.status,
        timestamp: new Date(),
      });
    }
  }

  @SubscribeMessage('meal_preference_updated')
  handleMealPreferenceUpdated(
    @MessageBody() data: { studentId: string; mealType: string; preference: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData && userData.user.role === 'STUDENT') {
      // Notify chefs about meal preference changes
      client.to(`hostel_${userData.user.hostelId}`).emit('meal_preference_updated', {
        studentId: data.studentId,
        mealType: data.mealType,
        preference: data.preference,
        timestamp: new Date(),
      });
    }
  }

  @SubscribeMessage('notice_published')
  handleNoticePublished(
    @MessageBody() data: { title: string; content: string; targetRoles: string[] },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData && ['WARDEN', 'ADMIN'].includes(userData.user.role)) {
      // Notify users based on target roles
      data.targetRoles.forEach(role => {
        client.to(`role_${role}`).emit('new_notice', {
          title: data.title,
          content: data.content,
          timestamp: new Date(),
        });
      });
    }
  }

  @SubscribeMessage('send_message')
  handleSendMessage(
    @MessageBody() data: { roomId: string; message: string; type: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userData = this.connectedUsers.get(client.id);
    if (userData) {
      client.to(data.roomId).emit('message_received', {
        from: userData.user.id,
        message: data.message,
        type: data.type,
        timestamp: new Date(),
      });
    }
  }

  // Helper methods for server-side events
  notifyUser(userId: string, event: string, data: any) {
    this.server.to(`user_${userId}`).emit(event, data);
  }

  notifyHostel(hostelId: string, event: string, data: any) {
    this.server.to(`hostel_${hostelId}`).emit(event, data);
  }

  notifyRole(role: string, event: string, data: any) {
    this.server.to(`role_${role}`).emit(event, data);
  }

  getConnectedUsers(): any[] {
    return Array.from(this.connectedUsers.values()).map(u => u.user);
  }

  getOnlineUsersByHostel(hostelId: string): any[] {
    return Array.from(this.connectedUsers.values())
      .filter(u => u.user.hostelId === hostelId)
      .map(u => u.user);
  }
}
