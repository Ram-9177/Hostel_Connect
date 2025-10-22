import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Notification } from './entities/notification.entity';

export interface CreateNotificationDto {
  title: string;
  body: string;
  type: 'gate_pass' | 'attendance' | 'room_allocation' | 'meal_intent' | 'notice' | 'system';
  priority: 'low' | 'medium' | 'high' | 'urgent';
  targetUserId?: string;
  targetRole?: string;
  data?: any;
  expiresAt?: Date;
}

@Injectable()
export class NotificationsService {
  constructor(
    @InjectRepository(Notification)
    private readonly notificationRepository: Repository<Notification>,
  ) {}

  async createNotification(notificationData: CreateNotificationDto): Promise<Notification> {
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

  async getNotificationsForUser(userId: string, limit: number = 50): Promise<Notification[]> {
    return this.notificationRepository.find({
      where: [
        { targetUserId: userId },
        { targetRole: 'all' },
      ],
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }

  async getPendingNotifications(userId: string): Promise<Notification[]> {
    return this.notificationRepository.find({
      where: [
        { targetUserId: userId, isRead: false },
        { targetRole: 'all', isRead: false },
      ],
      order: { createdAt: 'DESC' },
      take: 10,
    });
  }

  async markAsRead(notificationId: string, userId: string): Promise<void> {
    await this.notificationRepository.update(
      { id: notificationId, targetUserId: userId },
      { isRead: true, readAt: new Date() },
    );
  }

  async markAllAsRead(userId: string): Promise<void> {
    await this.notificationRepository.update(
      { targetUserId: userId, isRead: false },
      { isRead: true, readAt: new Date() },
    );
  }

  async getUnreadCount(userId: string): Promise<number> {
    return this.notificationRepository.count({
      where: [
        { targetUserId: userId, isRead: false },
        { targetRole: 'all', isRead: false },
      ],
    });
  }

  async deleteExpiredNotifications(): Promise<void> {
    await this.notificationRepository.delete({
      expiresAt: new Date(),
    });
  }

  // Specific notification creators
  async createGatePassNotification(gatePassId: string, studentId: string, status: string): Promise<Notification> {
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

  async createAttendanceNotification(studentId: string, attendanceData: any): Promise<Notification> {
    return this.createNotification({
      title: 'Attendance Recorded',
      body: `Your attendance has been recorded for ${attendanceData.date}`,
      type: 'attendance',
      priority: 'low',
      targetUserId: studentId,
      data: attendanceData,
    });
  }

  async createRoomAllocationNotification(studentId: string, roomData: any): Promise<Notification> {
    return this.createNotification({
      title: 'Room Allocation Update',
      body: `You have been allocated to Room ${roomData.roomNumber}`,
      type: 'room_allocation',
      priority: 'high',
      targetUserId: studentId,
      data: roomData,
    });
  }

  async createMealIntentNotification(studentId: string, mealData: any): Promise<Notification> {
    return this.createNotification({
      title: 'Meal Intent Reminder',
      body: `Don't forget to submit your meal intent for ${mealData.mealType}`,
      type: 'meal_intent',
      priority: 'medium',
      targetUserId: studentId,
      data: mealData,
    });
  }

  async createSystemNotification(title: string, body: string, targetRole?: string): Promise<Notification> {
    return this.createNotification({
      title,
      body,
      type: 'system',
      priority: 'medium',
      targetRole: targetRole || 'all',
    });
  }
}
