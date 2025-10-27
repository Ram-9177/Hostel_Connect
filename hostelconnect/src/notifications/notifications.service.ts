import { Injectable, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In } from 'typeorm';
import { Notification } from './entities/notification.entity';
import { Student } from '../students/entities/student.entity';
import { Room } from '../rooms/entities/room.entity';
import { Block } from '../hostels/entities/block.entity';
import { CreateTargetedNotificationDto, TargetType } from './dto/create-targeted-notification.dto';

export interface CreateNotificationDto {
  title: string;
  body: string;
  type: 'gate_pass' | 'attendance' | 'room_allocation' | 'meal_intent' | 'notice' | 'system' | 'announcement';
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
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @InjectRepository(Room)
    private readonly roomRepository: Repository<Room>,
    @InjectRepository(Block)
    private readonly blockRepository: Repository<Block>,
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

  /**
   * Create targeted notification for specific groups
   * Supports: All students, Hostel, Block, Floor, Room, Individual student
   */
  async createTargetedNotification(dto: CreateTargetedNotificationDto, createdBy: string): Promise<{ notification: Notification, targetCount: number }> {
    let targetStudentIds: string[] = [];

    switch (dto.targetType) {
      case TargetType.ALL:
        // Get all active students
        const allStudents = await this.studentRepository.find({
          where: { isActive: true },
          select: ['id'],
        });
        targetStudentIds = allStudents.map(s => s.id);
        break;

      case TargetType.HOSTEL:
        if (!dto.hostelId) {
          throw new BadRequestException('Hostel ID is required for hostel-targeted notifications');
        }
        const hostelStudents = await this.studentRepository.find({
          where: { hostelId: dto.hostelId, isActive: true },
          select: ['id'],
        });
        targetStudentIds = hostelStudents.map(s => s.id);
        break;

      case TargetType.BLOCK:
        if (!dto.blockId) {
          throw new BadRequestException('Block ID is required for block-targeted notifications');
        }
        // Get all rooms in the block
        const blockRooms = await this.roomRepository.find({
          where: { blockId: dto.blockId, isActive: true },
          select: ['id'],
        });
        const blockRoomIds = blockRooms.map(r => r.id);
        const blockStudents = await this.studentRepository.find({
          where: { roomId: In(blockRoomIds), isActive: true },
          select: ['id'],
        });
        targetStudentIds = blockStudents.map(s => s.id);
        break;

      case TargetType.FLOOR:
        if (!dto.blockId || dto.floor === undefined) {
          throw new BadRequestException('Block ID and floor number are required for floor-targeted notifications');
        }
        const floorRooms = await this.roomRepository.find({
          where: { blockId: dto.blockId, floor: dto.floor, isActive: true },
          select: ['id'],
        });
        const floorRoomIds = floorRooms.map(r => r.id);
        const floorStudents = await this.studentRepository.find({
          where: { roomId: In(floorRoomIds), isActive: true },
          select: ['id'],
        });
        targetStudentIds = floorStudents.map(s => s.id);
        break;

      case TargetType.ROOM:
        if (!dto.roomId) {
          throw new BadRequestException('Room ID is required for room-targeted notifications');
        }
        const roomStudents = await this.studentRepository.find({
          where: { roomId: dto.roomId, isActive: true },
          select: ['id'],
        });
        targetStudentIds = roomStudents.map(s => s.id);
        break;

      case TargetType.STUDENT:
        if (!dto.studentId) {
          throw new BadRequestException('Student ID is required for student-targeted notifications');
        }
        targetStudentIds = [dto.studentId];
        break;

      case TargetType.ROLE:
        // For role-based, we'll use the targetRole field instead of individual IDs
        const notification = await this.createNotification({
          title: dto.title,
          body: dto.body,
          type: dto.type.toLowerCase() as CreateNotificationDto['type'],
          priority: dto.priority.toLowerCase() as CreateNotificationDto['priority'],
          targetRole: dto.role || 'STUDENT',
          data: { ...dto.data, createdBy },
          expiresAt: dto.expiresAt,
        });
        return { notification, targetCount: -1 }; // -1 indicates role-based (unknown count)

      default:
        throw new BadRequestException('Invalid target type');
    }

    // Create notifications for all target students
    const notifications = [];
    for (const studentId of targetStudentIds) {
      const notification = this.notificationRepository.create({
        title: dto.title,
        body: dto.body,
        type: dto.type,
        priority: dto.priority,
        targetUserId: studentId,
        data: { ...dto.data, createdBy },
        expiresAt: dto.expiresAt,
        isRead: false,
        createdAt: new Date(),
      });
      notifications.push(notification);
    }

    // Batch save for better performance
    const savedNotifications = await this.notificationRepository.save(notifications);
    
    return {
      notification: savedNotifications[0] || null,
      targetCount: targetStudentIds.length,
    };
  }
}
