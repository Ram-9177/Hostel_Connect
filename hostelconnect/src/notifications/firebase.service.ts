import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as admin from 'firebase-admin';

export interface PushNotificationData {
  title: string;
  body: string;
  data?: any;
  imageUrl?: string;
}

export interface PushNotificationTarget {
  userId?: string;
  role?: string;
  deviceTokens?: string[];
}

@Injectable()
export class FirebaseService {
  private firebaseApp: admin.app.App;

  constructor(private readonly configService: ConfigService) {
    this.initializeFirebase();
  }

  private initializeFirebase() {
    try {
      // Initialize Firebase Admin SDK
      const serviceAccount = {
        projectId: this.configService.get<string>('FIREBASE_PROJECT_ID'),
        privateKey: this.configService.get<string>('FIREBASE_PRIVATE_KEY')?.replace(/\\n/g, '\n'),
        clientEmail: this.configService.get<string>('FIREBASE_CLIENT_EMAIL'),
      };

      this.firebaseApp = admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
        projectId: serviceAccount.projectId,
      });

      console.log('Firebase Admin SDK initialized successfully');
    } catch (error) {
      console.error('Failed to initialize Firebase Admin SDK:', error);
    }
  }

  async sendPushNotification(
    target: PushNotificationTarget,
    notification: PushNotificationData,
  ): Promise<{ success: boolean; messageId?: string; error?: string }> {
    try {
      if (!this.firebaseApp) {
        throw new Error('Firebase not initialized');
      }

      const baseMessage = {
        notification: {
          title: notification.title,
          body: notification.body,
          imageUrl: notification.imageUrl,
        },
        data: notification.data ? this.convertDataToString(notification.data) : undefined,
        android: {
          priority: 'high' as const,
          notification: {
            sound: 'default',
            channelId: 'hostelconnect_notifications',
          },
        },
        apns: {
          payload: {
            aps: {
              sound: 'default',
              badge: 1,
            },
          },
        },
      };

      let result: any;

      if (target.deviceTokens && target.deviceTokens.length > 0) {
        // Send to specific device tokens
        const multicastMessage: admin.messaging.MulticastMessage = {
          ...baseMessage,
          tokens: target.deviceTokens,
        };
        result = await admin.messaging().sendMulticast(multicastMessage);
      } else if (target.role) {
        // Send to topic (role-based)
        const topicMessage: admin.messaging.Message = {
          ...baseMessage,
          topic: `role_${target.role.toLowerCase()}`,
        };
        result = await admin.messaging().send(topicMessage);
      } else if (target.userId) {
        // Send to user-specific topic
        const topicMessage: admin.messaging.Message = {
          ...baseMessage,
          topic: `user_${target.userId}`,
        };
        result = await admin.messaging().send(topicMessage);
      } else {
        throw new Error('No valid target specified');
      }

      return {
        success: true,
        messageId: result.messageId || 'multicast',
      };
    } catch (error) {
      console.error('Error sending push notification:', error);
      return {
        success: false,
        error: error.message,
      };
    }
  }

  async sendToDeviceTokens(
    deviceTokens: string[],
    notification: PushNotificationData,
  ): Promise<{ success: boolean; results: any[] }> {
    try {
      if (!this.firebaseApp) {
        throw new Error('Firebase not initialized');
      }

      const message: admin.messaging.MulticastMessage = {
        notification: {
          title: notification.title,
          body: notification.body,
          imageUrl: notification.imageUrl,
        },
        data: notification.data ? this.convertDataToString(notification.data) : undefined,
        android: {
          priority: 'high',
          notification: {
            sound: 'default',
            channelId: 'hostelconnect_notifications',
          },
        },
        apns: {
          payload: {
            aps: {
              sound: 'default',
              badge: 1,
            },
          },
        },
        tokens: deviceTokens,
      };

      const result = await admin.messaging().sendMulticast(message);

      return {
        success: result.successCount > 0,
        results: result.responses.map((response, index) => ({
          token: deviceTokens[index],
          success: response.success,
          error: response.error?.message,
        })),
      };
    } catch (error) {
      console.error('Error sending multicast notification:', error);
      return {
        success: false,
        results: [],
      };
    }
  }

  async subscribeToTopic(deviceToken: string, topic: string): Promise<boolean> {
    try {
      if (!this.firebaseApp) {
        throw new Error('Firebase not initialized');
      }

      await admin.messaging().subscribeToTopic(deviceToken, topic);
      return true;
    } catch (error) {
      console.error('Error subscribing to topic:', error);
      return false;
    }
  }

  async unsubscribeFromTopic(deviceToken: string, topic: string): Promise<boolean> {
    try {
      if (!this.firebaseApp) {
        throw new Error('Firebase not initialized');
      }

      await admin.messaging().unsubscribeFromTopic(deviceToken, topic);
      return true;
    } catch (error) {
      console.error('Error unsubscribing from topic:', error);
      return false;
    }
  }

  async sendToTopic(
    topic: string,
    notification: PushNotificationData,
  ): Promise<{ success: boolean; messageId?: string }> {
    try {
      if (!this.firebaseApp) {
        throw new Error('Firebase not initialized');
      }

      const message: admin.messaging.Message = {
        notification: {
          title: notification.title,
          body: notification.body,
          imageUrl: notification.imageUrl,
        },
        data: notification.data ? this.convertDataToString(notification.data) : undefined,
        android: {
          priority: 'high',
          notification: {
            sound: 'default',
            channelId: 'hostelconnect_notifications',
          },
        },
        apns: {
          payload: {
            aps: {
              sound: 'default',
              badge: 1,
            },
          },
        },
        topic,
      };

      const result = await admin.messaging().send(message);

      return {
        success: true,
        messageId: result,
      };
    } catch (error) {
      console.error('Error sending to topic:', error);
      return {
        success: false,
      };
    }
  }

  private convertDataToString(data: any): { [key: string]: string } {
    const result: { [key: string]: string } = {};
    
    for (const [key, value] of Object.entries(data)) {
      if (typeof value === 'string') {
        result[key] = value;
      } else {
        result[key] = JSON.stringify(value);
      }
    }
    
    return result;
  }

  // Specific notification methods for HostelConnect
  async sendGatePassNotification(
    userId: string,
    gatePassId: string,
    status: string,
    deviceTokens?: string[],
  ): Promise<{ success: boolean; messageId?: string }> {
    const titles = {
      'PENDING': 'Gate Pass Request Submitted',
      'APPROVED': 'Gate Pass Approved',
      'REJECTED': 'Gate Pass Rejected',
      'COMPLETED': 'Gate Pass Completed',
    };

    const notification: PushNotificationData = {
      title: titles[status] || 'Gate Pass Update',
      body: `Your gate pass request has been ${status.toLowerCase()}`,
      data: {
        type: 'gate_pass',
        gatePassId,
        status,
        userId,
      },
    };

    if (deviceTokens && deviceTokens.length > 0) {
      const result = await this.sendToDeviceTokens(deviceTokens, notification);
      return { success: result.success };
    } else {
      return this.sendToTopic(`user_${userId}`, notification);
    }
  }

  async sendAttendanceNotification(
    userId: string,
    attendanceData: any,
    deviceTokens?: string[],
  ): Promise<{ success: boolean; messageId?: string }> {
    const notification: PushNotificationData = {
      title: 'Attendance Recorded',
      body: `Your attendance has been recorded for ${attendanceData.date}`,
      data: {
        type: 'attendance',
        userId,
        ...attendanceData,
      },
    };

    if (deviceTokens && deviceTokens.length > 0) {
      const result = await this.sendToDeviceTokens(deviceTokens, notification);
      return { success: result.success };
    } else {
      return this.sendToTopic(`user_${userId}`, notification);
    }
  }

  async sendRoomAllocationNotification(
    userId: string,
    roomData: any,
    deviceTokens?: string[],
  ): Promise<{ success: boolean; messageId?: string }> {
    const notification: PushNotificationData = {
      title: 'Room Allocation Update',
      body: `You have been allocated to Room ${roomData.roomNumber}`,
      data: {
        type: 'room_allocation',
        userId,
        ...roomData,
      },
    };

    if (deviceTokens && deviceTokens.length > 0) {
      const result = await this.sendToDeviceTokens(deviceTokens, notification);
      return { success: result.success };
    } else {
      return this.sendToTopic(`user_${userId}`, notification);
    }
  }

  async sendMealIntentReminder(
    userId: string,
    mealData: any,
    deviceTokens?: string[],
  ): Promise<{ success: boolean; messageId?: string }> {
    const notification: PushNotificationData = {
      title: 'Meal Intent Reminder',
      body: `Don't forget to submit your meal intent for ${mealData.mealType}`,
      data: {
        type: 'meal_intent',
        userId,
        ...mealData,
      },
    };

    if (deviceTokens && deviceTokens.length > 0) {
      const result = await this.sendToDeviceTokens(deviceTokens, notification);
      return { success: result.success };
    } else {
      return this.sendToTopic(`user_${userId}`, notification);
    }
  }

  async sendEmergencyNotice(
    notice: any,
    targetRole?: string,
  ): Promise<{ success: boolean; messageId?: string }> {
    const notification: PushNotificationData = {
      title: '🚨 EMERGENCY NOTICE',
      body: notice.title,
      data: {
        type: 'notice',
        noticeId: notice.id,
        priority: 'urgent',
      },
    };

    const topic = targetRole ? `role_${targetRole.toLowerCase()}` : 'all_users';
    return this.sendToTopic(topic, notification);
  }

  async sendSystemMaintenanceNotice(
    message: string,
    targetRole?: string,
  ): Promise<{ success: boolean; messageId?: string }> {
    const notification: PushNotificationData = {
      title: 'System Maintenance',
      body: message,
      data: {
        type: 'system',
        priority: 'high',
      },
    };

    const topic = targetRole ? `role_${targetRole.toLowerCase()}` : 'all_users';
    return this.sendToTopic(topic, notification);
  }
}
