import { Repository } from 'typeorm';
import { Notification } from './entities/notification.entity';
export interface NotificationData {
    title: string;
    body: string;
    type: 'gate_pass' | 'attendance' | 'room_allocation' | 'meal_intent' | 'notice' | 'system';
    priority: 'low' | 'medium' | 'high' | 'urgent';
    targetUserId?: string;
    targetRole?: string;
    data?: any;
    expiresAt?: Date;
}
export declare class NotificationService {
    private readonly notificationRepository;
    constructor(notificationRepository: Repository<Notification>);
    createNotification(notificationData: NotificationData): Promise<Notification>;
    getNotificationsForUser(userId: string, limit?: number): Promise<Notification[]>;
    getPendingNotifications(userId: string): Promise<Notification[]>;
    markAsRead(notificationId: string, userId: string): Promise<void>;
    markAllAsRead(userId: string): Promise<void>;
    getUnreadCount(userId: string): Promise<number>;
    deleteExpiredNotifications(): Promise<void>;
    createGatePassNotification(gatePassId: string, studentId: string, status: string): Promise<Notification>;
    createAttendanceNotification(studentId: string, attendanceData: any): Promise<Notification>;
    createRoomAllocationNotification(studentId: string, roomData: any): Promise<Notification>;
    createMealIntentNotification(studentId: string, mealData: any): Promise<Notification>;
    createSystemNotification(title: string, body: string, targetRole?: string): Promise<Notification>;
}
