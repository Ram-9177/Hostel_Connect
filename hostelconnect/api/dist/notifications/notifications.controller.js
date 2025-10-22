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
exports.NotificationsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const notifications_service_1 = require("./notifications.service");
const socket_service_1 = require("../socket/socket.service");
let NotificationsController = class NotificationsController {
    constructor(notificationsService, socketService) {
        this.notificationsService = notificationsService;
        this.socketService = socketService;
    }
    async getUserNotifications(req, limit) {
        return this.notificationsService.getNotificationsForUser(req.user.id, limit);
    }
    async getUnreadCount(req) {
        const count = await this.notificationsService.getUnreadCount(req.user.id);
        return { unreadCount: count };
    }
    async markAsRead(req, body) {
        await this.notificationsService.markAsRead(body.notificationId, req.user.id);
        return { success: true };
    }
    async markAllAsRead(req) {
        await this.notificationsService.markAllAsRead(req.user.id);
        return { success: true };
    }
    async sendNotification(req, notificationData) {
        if (!['SUPER_ADMIN', 'WARDEN_HEAD'].includes(req.user.role)) {
            throw new Error('Unauthorized to send notifications');
        }
        const notification = await this.notificationsService.createNotification(notificationData);
        if (notificationData.targetUserId) {
            await this.socketService.notifyUser(notificationData.targetUserId, notification);
        }
        else if (notificationData.targetRole) {
            await this.socketService.notifyRole(notificationData.targetRole, notification);
        }
        else {
            await this.socketService.broadcastToAll(notification);
        }
        return notification;
    }
    async sendTestNotification(req) {
        const testNotification = {
            title: 'Test Notification',
            body: 'This is a test notification from HostelConnect',
            type: 'system',
            priority: 'low',
            targetUserId: req.user.id,
        };
        const notification = await this.notificationsService.createNotification(testNotification);
        await this.socketService.notifyUser(req.user.id, notification);
        return { success: true, notification };
    }
};
exports.NotificationsController = NotificationsController;
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get user notifications' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Notifications retrieved' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Number]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "getUserNotifications", null);
__decorate([
    (0, common_1.Get)('unread-count'),
    (0, swagger_1.ApiOperation)({ summary: 'Get unread notifications count' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Unread count retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "getUnreadCount", null);
__decorate([
    (0, common_1.Post)('mark-read'),
    (0, swagger_1.ApiOperation)({ summary: 'Mark notification as read' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Notification marked as read' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "markAsRead", null);
__decorate([
    (0, common_1.Post)('mark-all-read'),
    (0, swagger_1.ApiOperation)({ summary: 'Mark all notifications as read' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'All notifications marked as read' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "markAllAsRead", null);
__decorate([
    (0, common_1.Post)('send'),
    (0, swagger_1.ApiOperation)({ summary: 'Send notification (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Notification sent' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "sendNotification", null);
__decorate([
    (0, common_1.Post)('test'),
    (0, swagger_1.ApiOperation)({ summary: 'Send test notification' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Test notification sent' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], NotificationsController.prototype, "sendTestNotification", null);
exports.NotificationsController = NotificationsController = __decorate([
    (0, swagger_1.ApiTags)('Notifications'),
    (0, common_1.Controller)('notifications'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [notifications_service_1.NotificationsService,
        socket_service_1.SocketService])
], NotificationsController);
//# sourceMappingURL=notifications.controller.js.map