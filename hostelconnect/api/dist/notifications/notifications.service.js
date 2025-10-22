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
exports.NotificationsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const notification_entity_1 = require("./entities/notification.entity");
let NotificationsService = class NotificationsService {
    constructor(notificationRepository) {
        this.notificationRepository = notificationRepository;
    }
    async createNotification(notificationData) {
        const notification = this.notificationRepository.create({
            title: notificationData.title,
            body: notificationData.body,
            type: notificationData.type,
            priority: notificationData.priority,
            targetUserId: notificationData.targetUserId,
            targetRole: notificationData.targetRole,
            data: notificationData.data,
            expiresAt: notificationData.expiresAt,
            isRead: false,
            createdAt: new Date(),
        });
        return this.notificationRepository.save(notification);
    }
    async getNotificationsForUser(userId, limit = 50) {
        return this.notificationRepository.find({
            where: [
                { targetUserId: userId },
                { targetRole: 'all' },
            ],
            order: { createdAt: 'DESC' },
            take: limit,
        });
    }
    async getPendingNotifications(userId) {
        return this.notificationRepository.find({
            where: [
                { targetUserId: userId, isRead: false },
                { targetRole: 'all', isRead: false },
            ],
            order: { createdAt: 'DESC' },
            take: 10,
        });
    }
    async markAsRead(notificationId, userId) {
        await this.notificationRepository.update({ id: notificationId, targetUserId: userId }, { isRead: true, readAt: new Date() });
    }
    async markAllAsRead(userId) {
        await this.notificationRepository.update({ targetUserId: userId, isRead: false }, { isRead: true, readAt: new Date() });
    }
    async getUnreadCount(userId) {
        return this.notificationRepository.count({
            where: [
                { targetUserId: userId, isRead: false },
                { targetRole: 'all', isRead: false },
            ],
        });
    }
    async deleteExpiredNotifications() {
        await this.notificationRepository.delete({
            expiresAt: new Date(),
        });
    }
    async createGatePassNotification(gatePassId, studentId, status) {
        const titles = {
            'PENDING': 'Gate Pass Request Submitted',
            'APPROVED': 'Gate Pass Approved',
            'REJECTED': 'Gate Pass Rejected',
            'COMPLETED': 'Gate Pass Completed',
        };
        return this.createNotification({
            title: titles[status] || 'Gate Pass Update',
            body: `Your gate pass request has been ${status.toLowerCase()}`,
            type: 'gate_pass',
            priority: status === 'REJECTED' ? 'high' : 'medium',
            targetUserId: studentId,
            data: { gatePassId, status },
        });
    }
    async createAttendanceNotification(studentId, attendanceData) {
        return this.createNotification({
            title: 'Attendance Recorded',
            body: `Your attendance has been recorded for ${attendanceData.date}`,
            type: 'attendance',
            priority: 'low',
            targetUserId: studentId,
            data: attendanceData,
        });
    }
    async createRoomAllocationNotification(studentId, roomData) {
        return this.createNotification({
            title: 'Room Allocation Update',
            body: `You have been allocated to Room ${roomData.roomNumber}`,
            type: 'room_allocation',
            priority: 'high',
            targetUserId: studentId,
            data: roomData,
        });
    }
    async createMealIntentNotification(studentId, mealData) {
        return this.createNotification({
            title: 'Meal Intent Reminder',
            body: `Don't forget to submit your meal intent for ${mealData.mealType}`,
            type: 'meal_intent',
            priority: 'medium',
            targetUserId: studentId,
            data: mealData,
        });
    }
    async createSystemNotification(title, body, targetRole) {
        return this.createNotification({
            title,
            body,
            type: 'system',
            priority: 'medium',
            targetRole: targetRole || 'all',
        });
    }
};
exports.NotificationsService = NotificationsService;
exports.NotificationsService = NotificationsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(notification_entity_1.Notification)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], NotificationsService);
//# sourceMappingURL=notifications.service.js.map