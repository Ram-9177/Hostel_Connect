import { Injectable, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Student } from '../students/entities/student.entity';
import { NotificationsService } from '../notifications/notifications.service';
import { SocketService } from '../socket/socket.service';

@Injectable()
export class MealSchedulerService {
  private readonly logger = new Logger(MealSchedulerService.name);

  constructor(
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    private readonly notificationsService: NotificationsService,
    private readonly socketService: SocketService,
  ) {}

  /**
   * Send morning meal intent reminder
   * Runs daily at 7:00 AM
   */
  @Cron('0 7 * * *', {
    name: 'morning-meal-reminder',
    timeZone: 'Asia/Kolkata',
  })
  async sendMorningMealReminder() {
    this.logger.log('Sending morning meal intent reminder...');

    try {
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      const dateStr = tomorrow.toISOString().split('T')[0];

      // Get all active students
      const students = await this.studentRepository.find({
        where: { isActive: true },
        select: ['id', 'firstName', 'email'],
      });

      this.logger.log(`Sending meal reminders to ${students.length} students`);

      // Create notification for each student
      const notifications = [];
      for (const student of students) {
        const notification = await this.notificationsService.createNotification({
          title: '🍽️ Meal Intent Reminder',
          body: `Good morning! Don't forget to submit your meal preferences for tomorrow (${dateStr}). Deadline: 8:00 PM today.`,
          type: 'meal_intent',
          priority: 'medium',
          targetUserId: student.id,
          data: {
            date: dateStr,
            cutoffTime: '20:00',
          },
          expiresAt: new Date(new Date().getTime() + 24 * 60 * 60 * 1000), // Expires in 24 hours
        });

        notifications.push(notification);

        // Send real-time notification
        await this.socketService.notifyUser(student.id, notification);
      }

      this.logger.log(`Successfully sent ${notifications.length} meal reminders`);

      return {
        success: true,
        sentCount: notifications.length,
      };
    } catch (error) {
      this.logger.error(`Failed to send meal reminders: ${error.message}`, error.stack);
      throw error;
    }
  }

  /**
   * Send evening meal intent cutoff warning
   * Runs daily at 6:00 PM
   */
  @Cron('0 18 * * *', {
    name: 'evening-meal-cutoff-warning',
    timeZone: 'Asia/Kolkata',
  })
  async sendEveningCutoffWarning() {
    this.logger.log('Sending evening meal cutoff warning...');

    try {
      const tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      const dateStr = tomorrow.toISOString().split('T')[0];

      // Get all active students
      const students = await this.studentRepository.find({
        where: { isActive: true },
        select: ['id'],
      });

      this.logger.log(`Sending cutoff warnings to ${students.length} students`);

      // Create notification for each student
      const notifications = [];
      for (const student of students) {
        const notification = await this.notificationsService.createNotification({
          title: '⏰ Meal Intent Deadline Approaching',
          body: `Only 2 hours left! Submit your meal preferences for tomorrow (${dateStr}) before 8:00 PM.`,
          type: 'meal_intent',
          priority: 'high',
          targetUserId: student.id,
          data: {
            date: dateStr,
            cutoffTime: '20:00',
            hoursRemaining: 2,
          },
          expiresAt: new Date(new Date().getTime() + 4 * 60 * 60 * 1000), // Expires in 4 hours
        });

        notifications.push(notification);

        // Send real-time notification
        await this.socketService.notifyUser(student.id, notification);
      }

      this.logger.log(`Successfully sent ${notifications.length} cutoff warnings`);

      return {
        success: true,
        sentCount: notifications.length,
      };
    } catch (error) {
      this.logger.error(`Failed to send cutoff warnings: ${error.message}`, error.stack);
      throw error;
    }
  }

  /**
   * Send meal menu announcement
   * Runs daily at 9:00 AM (after breakfast)
   */
  @Cron('0 9 * * *', {
    name: 'daily-meal-menu',
    timeZone: 'Asia/Kolkata',
  })
  async sendDailyMenuAnnouncement() {
    this.logger.log('Sending daily meal menu announcement...');

    try {
      const today = new Date().toISOString().split('T')[0];

      // Get all active students
      const students = await this.studentRepository.find({
        where: { isActive: true },
        select: ['id'],
      });

      this.logger.log(`Sending menu announcements to ${students.length} students`);

      // Create notification for each student
      const notifications = [];
      for (const student of students) {
        const notification = await this.notificationsService.createNotification({
          title: '📋 Today\'s Menu Available',
          body: `Check out today's meal menu! View your meal schedule for ${today}.`,
          type: 'meal_intent',
          priority: 'low',
          targetUserId: student.id,
          data: {
            date: today,
            type: 'menu_announcement',
          },
          expiresAt: new Date(new Date().getTime() + 12 * 60 * 60 * 1000), // Expires in 12 hours
        });

        notifications.push(notification);

        // Send real-time notification
        await this.socketService.notifyUser(student.id, notification);
      }

      this.logger.log(`Successfully sent ${notifications.length} menu announcements`);

      return {
        success: true,
        sentCount: notifications.length,
      };
    } catch (error) {
      this.logger.error(`Failed to send menu announcements: ${error.message}`, error.stack);
      throw error;
    }
  }

  /**
   * Manual trigger for meal reminder (for testing or manual sends)
   */
  async triggerMealReminder(type: 'morning' | 'evening' | 'menu'): Promise<any> {
    switch (type) {
      case 'morning':
        return this.sendMorningMealReminder();
      case 'evening':
        return this.sendEveningCutoffWarning();
      case 'menu':
        return this.sendDailyMenuAnnouncement();
      default:
        throw new Error('Invalid reminder type');
    }
  }
}
