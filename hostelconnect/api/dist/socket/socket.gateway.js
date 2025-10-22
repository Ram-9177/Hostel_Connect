"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SocketGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const common_1 = require("@nestjs/common");
const jwt_1 = require("@nestjs/jwt");
const socket_service_1 = require("./socket.service");
const notification_service_1 = require("./notification.service");
let SocketGateway = class SocketGateway {
    constructor(socketService, notificationService, jwtService) {
        this.socketService = socketService;
        this.notificationService = notificationService;
        this.jwtService = jwtService;
        this.connectedUsers = new Map();
    }
    async handleConnection(client) {
        try {
            const token = client.handshake.auth?.token || client.handshake.headers?.authorization?.replace('Bearer ', '');
            if (!token) {
                client.disconnect();
                return;
            }
            const payload = this.jwtService.verify(token);
            const userId = payload.sub;
            this.connectedUsers.set(userId, client.id);
            client.data.userId = userId;
            client.data.userRole = payload.role;
            client.join(`user:${userId}`);
            client.join(`role:${payload.role}`);
            console.log(`User ${userId} connected with socket ${client.id}`);
            client.emit('connected', {
                message: 'Connected to HostelConnect notifications',
                userId,
                role: payload.role,
            });
            await this.sendPendingNotifications(userId, client);
        }
        catch (error) {
            console.error('Connection error:', error);
            client.disconnect();
        }
    }
    handleDisconnect(client) {
        const userId = client.data.userId;
        if (userId) {
            this.connectedUsers.delete(userId);
            console.log(`User ${userId} disconnected`);
        }
    }
    async handleJoinRoom(client, data) {
        const userId = client.data.userId;
        const room = data.room;
        if (this.canJoinRoom(client.data.userRole, room)) {
            client.join(room);
            client.emit('joined_room', { room });
            console.log(`User ${userId} joined room ${room}`);
        }
        else {
            client.emit('error', { message: 'Unauthorized to join this room' });
        }
    }
    async handleLeaveRoom(client, data) {
        client.leave(data.room);
        client.emit('left_room', { room: data.room });
    }
    async handleMarkNotificationRead(client, data) {
        const userId = client.data.userId;
        await this.notificationService.markAsRead(data.notificationId, userId);
        client.emit('notification_read', {
            notificationId: data.notificationId,
            success: true
        });
    }
    async broadcastGatePassUpdate(gatePassId, update) {
        this.server.emit('gate_pass_update', {
            gatePassId,
            update,
            timestamp: new Date(),
        });
    }
    async broadcastAttendanceUpdate(studentId, attendance) {
        this.server.emit('attendance_update', {
            studentId,
            attendance,
            timestamp: new Date(),
        });
    }
    async broadcastRoomAllocationUpdate(allocation) {
        this.server.emit('room_allocation_update', {
            allocation,
            timestamp: new Date(),
        });
    }
    async broadcastMealIntentUpdate(mealIntent) {
        this.server.emit('meal_intent_update', {
            mealIntent,
            timestamp: new Date(),
        });
    }
    async broadcastNotice(notice) {
        if (notice.targetRoles && notice.targetRoles.length > 0) {
            notice.targetRoles.forEach((role) => {
                this.server.to(`role:${role}`).emit('new_notice', {
                    notice,
                    timestamp: new Date(),
                });
            });
        }
        else {
            this.server.emit('new_notice', {
                notice,
                timestamp: new Date(),
            });
        }
    }
    async sendNotificationToUser(userId, notification) {
        const socketId = this.connectedUsers.get(userId);
        if (socketId) {
            this.server.to(socketId).emit('notification', {
                notification,
                timestamp: new Date(),
            });
        }
    }
    async sendNotificationToRole(role, notification) {
        this.server.to(`role:${role}`).emit('notification', {
            notification,
            timestamp: new Date(),
        });
    }
    async sendPendingNotifications(userId, client) {
        try {
            const pendingNotifications = await this.notificationService.getPendingNotifications(userId);
            if (pendingNotifications.length > 0) {
                client.emit('pending_notifications', {
                    notifications: pendingNotifications,
                    count: pendingNotifications.length,
                });
            }
        }
        catch (error) {
            console.error('Error sending pending notifications:', error);
        }
    }
    canJoinRoom(userRole, room) {
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
};
exports.SocketGateway = SocketGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], SocketGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('join_room'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], SocketGateway.prototype, "handleJoinRoom", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('leave_room'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], SocketGateway.prototype, "handleLeaveRoom", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('mark_notification_read'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], SocketGateway.prototype, "handleMarkNotificationRead", null);
exports.SocketGateway = SocketGateway = __decorate([
    (0, common_1.Injectable)(),
    (0, websockets_1.WebSocketGateway)({
        cors: {
            origin: process.env.FRONTEND_URL || 'http://localhost:3000',
            credentials: true,
        },
        namespace: '/notifications',
    }),
    __metadata("design:paramtypes", [socket_service_1.SocketService,
        notification_service_1.NotificationService,
        jwt_1.JwtService])
], SocketGateway);
//# sourceMappingURL=socket.gateway.js.map