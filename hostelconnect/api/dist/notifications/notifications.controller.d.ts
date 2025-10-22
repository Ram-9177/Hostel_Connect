import { NotificationsService } from './notifications.service';
import { SocketService } from '../socket/socket.service';
export declare class NotificationsController {
    private readonly notificationsService;
    private readonly socketService;
    constructor(notificationsService: NotificationsService, socketService: SocketService);
    getUserNotifications(req: any, limit?: number): Promise<import("./entities/notification.entity").Notification[]>;
    getUnreadCount(req: any): Promise<{
        unreadCount: number;
    }>;
    markAsRead(req: any, body: {
        notificationId: string;
    }): Promise<{
        success: boolean;
    }>;
    markAllAsRead(req: any): Promise<{
        success: boolean;
    }>;
    sendNotification(req: any, notificationData: any): Promise<import("./entities/notification.entity").Notification>;
    sendTestNotification(req: any): Promise<{
        success: boolean;
        notification: import("./entities/notification.entity").Notification;
    }>;
}
