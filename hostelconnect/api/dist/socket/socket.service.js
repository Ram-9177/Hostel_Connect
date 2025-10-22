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
Object.defineProperty(exports, "__esModule", { value: true });
exports.SocketService = void 0;
const common_1 = require("@nestjs/common");
const socket_gateway_1 = require("./socket.gateway");
let SocketService = class SocketService {
    constructor(socketGateway) {
        this.socketGateway = socketGateway;
    }
    async notifyGatePassUpdate(gatePassId, update) {
        await this.socketGateway.broadcastGatePassUpdate(gatePassId, update);
    }
    async notifyGatePassStatusChange(gatePassId, studentId, status) {
        const update = {
            gatePassId,
            studentId,
            status,
            timestamp: new Date(),
        };
        await this.socketGateway.broadcastGatePassUpdate(gatePassId, update);
        await this.socketGateway.sendNotificationToUser(studentId, {
            title: `Gate Pass ${status}`,
            body: `Your gate pass request has been ${status.toLowerCase()}`,
            type: 'gate_pass',
            data: update,
        });
    }
    async notifyAttendanceUpdate(studentId, attendance) {
        await this.socketGateway.broadcastAttendanceUpdate(studentId, attendance);
    }
    async notifyAttendanceRecorded(studentId, attendanceData) {
        const notification = {
            title: 'Attendance Recorded',
            body: `Your attendance has been recorded for ${attendanceData.date}`,
            type: 'attendance',
            data: attendanceData,
        };
        await this.socketGateway.sendNotificationToUser(studentId, notification);
        await this.socketGateway.broadcastAttendanceUpdate(studentId, attendanceData);
    }
    async notifyRoomAllocation(allocation) {
        await this.socketGateway.broadcastRoomAllocationUpdate(allocation);
    }
    async notifyRoomAllocated(studentId, roomData) {
        const notification = {
            title: 'Room Allocated',
            body: `You have been allocated to Room ${roomData.roomNumber}`,
            type: 'room_allocation',
            data: roomData,
        };
        await this.socketGateway.sendNotificationToUser(studentId, notification);
        await this.socketGateway.broadcastRoomAllocationUpdate(roomData);
    }
    async notifyMealIntentUpdate(mealIntent) {
        await this.socketGateway.broadcastMealIntentUpdate(mealIntent);
    }
    async notifyMealIntentReminder(studentId, mealData) {
        const notification = {
            title: 'Meal Intent Reminder',
            body: `Don't forget to submit your meal intent for ${mealData.mealType}`,
            type: 'meal_intent',
            data: mealData,
        };
        await this.socketGateway.sendNotificationToUser(studentId, notification);
    }
    async notifyNewNotice(notice) {
        await this.socketGateway.broadcastNotice(notice);
    }
    async notifyEmergencyNotice(notice) {
        const notification = {
            title: '🚨 EMERGENCY NOTICE',
            body: notice.title,
            type: 'notice',
            priority: 'urgent',
            data: notice,
        };
        await this.socketGateway.broadcastNotice(notification);
    }
    async notifySystemMaintenance(message, targetRole) {
        const notification = {
            title: 'System Maintenance',
            body: message,
            type: 'system',
            priority: 'high',
            data: { maintenance: true },
        };
        if (targetRole) {
            await this.socketGateway.sendNotificationToRole(targetRole, notification);
        }
        else {
            await this.socketGateway.broadcastNotice(notification);
        }
    }
    async notifySystemUpdate(message) {
        const notification = {
            title: 'System Update',
            body: message,
            type: 'system',
            priority: 'medium',
            data: { update: true },
        };
        await this.socketGateway.broadcastNotice(notification);
    }
    async notifyUser(userId, notification) {
        await this.socketGateway.sendNotificationToUser(userId, notification);
    }
    async notifyRole(role, notification) {
        await this.socketGateway.sendNotificationToRole(role, notification);
    }
    async broadcastToAll(notification) {
        await this.socketGateway.broadcastNotice(notification);
    }
};
exports.SocketService = SocketService;
exports.SocketService = SocketService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [socket_gateway_1.SocketGateway])
], SocketService);
//# sourceMappingURL=socket.service.js.map