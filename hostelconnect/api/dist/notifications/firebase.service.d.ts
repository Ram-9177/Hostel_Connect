import { ConfigService } from '@nestjs/config';
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
export declare class FirebaseService {
    private readonly configService;
    private firebaseApp;
    constructor(configService: ConfigService);
    private initializeFirebase;
    sendPushNotification(target: PushNotificationTarget, notification: PushNotificationData): Promise<{
        success: boolean;
        messageId?: string;
        error?: string;
    }>;
    sendToDeviceTokens(deviceTokens: string[], notification: PushNotificationData): Promise<{
        success: boolean;
        results: any[];
    }>;
    subscribeToTopic(deviceToken: string, topic: string): Promise<boolean>;
    unsubscribeFromTopic(deviceToken: string, topic: string): Promise<boolean>;
    sendToTopic(topic: string, notification: PushNotificationData): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    private convertDataToString;
    sendGatePassNotification(userId: string, gatePassId: string, status: string, deviceTokens?: string[]): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    sendAttendanceNotification(userId: string, attendanceData: any, deviceTokens?: string[]): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    sendRoomAllocationNotification(userId: string, roomData: any, deviceTokens?: string[]): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    sendMealIntentReminder(userId: string, mealData: any, deviceTokens?: string[]): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    sendEmergencyNotice(notice: any, targetRole?: string): Promise<{
        success: boolean;
        messageId?: string;
    }>;
    sendSystemMaintenanceNotice(message: string, targetRole?: string): Promise<{
        success: boolean;
        messageId?: string;
    }>;
}
