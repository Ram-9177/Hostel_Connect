import { Injectable } from '@nestjs/common';
import { SocketGateway } from './socket.gateway';

@Injectable()
export class SocketService {
  constructor(private readonly socketGateway: SocketGateway) {}

  // Gate Pass Notifications
  async notifyGatePassUpdate(gatePassId: string, update: any) {
    await this.socketGateway.broadcastGatePassUpdate(gatePassId, update);
  }

  async notifyGatePassStatusChange(gatePassId: string, studentId: string, status: string) {
    const update = {
      gatePassId,
      studentId,
      status,
      timestamp: new Date(),
    };
    
    await this.socketGateway.broadcastGatePassUpdate(gatePassId, update);
    
    // Send specific notification to student
    await this.socketGateway.sendNotificationToUser(studentId, {
      title: `Gate Pass ${status}`,
      body: `Your gate pass request has been ${status.toLowerCase()}`,
      type: 'gate_pass',
      data: update,
    });
  }

  // Attendance Notifications
  async notifyAttendanceUpdate(studentId: string, attendance: any) {
    await this.socketGateway.broadcastAttendanceUpdate(studentId, attendance);
  }

  async notifyAttendanceRecorded(studentId: string, attendanceData: any) {
    const notification = {
      title: 'Attendance Recorded',
      body: `Your attendance has been recorded for ${attendanceData.date}`,
      type: 'attendance',
      data: attendanceData,
    };

    await this.socketGateway.sendNotificationToUser(studentId, notification);
    await this.socketGateway.broadcastAttendanceUpdate(studentId, attendanceData);
  }

  // Room Allocation Notifications
  async notifyRoomAllocation(allocation: any) {
    await this.socketGateway.broadcastRoomAllocationUpdate(allocation);
  }

  async notifyRoomAllocated(studentId: string, roomData: any) {
    const notification = {
      title: 'Room Allocated',
      body: `You have been allocated to Room ${roomData.roomNumber}`,
      type: 'room_allocation',
      data: roomData,
    };

    await this.socketGateway.sendNotificationToUser(studentId, notification);
    await this.socketGateway.broadcastRoomAllocationUpdate(roomData);
  }

  // Meal Intent Notifications
  async notifyMealIntentUpdate(mealIntent: any) {
    await this.socketGateway.broadcastMealIntentUpdate(mealIntent);
  }

  async notifyMealIntentReminder(studentId: string, mealData: any) {
    const notification = {
      title: 'Meal Intent Reminder',
      body: `Don't forget to submit your meal intent for ${mealData.mealType}`,
      type: 'meal_intent',
      data: mealData,
    };

    await this.socketGateway.sendNotificationToUser(studentId, notification);
  }

  // Notice Notifications
  async notifyNewNotice(notice: any) {
    await this.socketGateway.broadcastNotice(notice);
  }

  async notifyEmergencyNotice(notice: any) {
    const notification = {
      title: '🚨 EMERGENCY NOTICE',
      body: notice.title,
      type: 'notice',
      priority: 'urgent',
      data: notice,
    };

    // Broadcast to all users immediately
    await this.socketGateway.broadcastNotice(notification);
  }

  // System Notifications
  async notifySystemMaintenance(message: string, targetRole?: string) {
    const notification = {
      title: 'System Maintenance',
      body: message,
      type: 'system',
      priority: 'high',
      data: { maintenance: true },
    };

    if (targetRole) {
      await this.socketGateway.sendNotificationToRole(targetRole, notification);
    } else {
      await this.socketGateway.broadcastNotice(notification);
    }
  }

  async notifySystemUpdate(message: string) {
    const notification = {
      title: 'System Update',
      body: message,
      type: 'system',
      priority: 'medium',
      data: { update: true },
    };

    await this.socketGateway.broadcastNotice(notification);
  }

  // User-specific notifications
  async notifyUser(userId: string, notification: any) {
    await this.socketGateway.sendNotificationToUser(userId, notification);
  }

  async notifyRole(role: string, notification: any) {
    await this.socketGateway.sendNotificationToRole(role, notification);
  }

  // Broadcast to all connected users
  async broadcastToAll(notification: any) {
    await this.socketGateway.broadcastNotice(notification);
  }
}
