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
Object.defineProperty(exports, "__esModule", { value: true });
exports.FirebaseService = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const admin = require("firebase-admin");
let FirebaseService = class FirebaseService {
    constructor(configService) {
        this.configService = configService;
        this.initializeFirebase();
    }
    initializeFirebase() {
        try {
            const serviceAccount = {
                projectId: this.configService.get('FIREBASE_PROJECT_ID'),
                privateKey: this.configService.get('FIREBASE_PRIVATE_KEY')?.replace(/\\n/g, '\n'),
                clientEmail: this.configService.get('FIREBASE_CLIENT_EMAIL'),
            };
            this.firebaseApp = admin.initializeApp({
                credential: admin.credential.cert(serviceAccount),
                projectId: serviceAccount.projectId,
            });
            console.log('Firebase Admin SDK initialized successfully');
        }
        catch (error) {
            console.error('Failed to initialize Firebase Admin SDK:', error);
        }
    }
    async sendPushNotification(target, notification) {
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
            };
            let result;
            if (target.deviceTokens && target.deviceTokens.length > 0) {
                const multicastMessage = {
                    ...baseMessage,
                    tokens: target.deviceTokens,
                };
                result = await admin.messaging().sendMulticast(multicastMessage);
            }
            else if (target.role) {
                const topicMessage = {
                    ...baseMessage,
                    topic: `role_${target.role.toLowerCase()}`,
                };
                result = await admin.messaging().send(topicMessage);
            }
            else if (target.userId) {
                const topicMessage = {
                    ...baseMessage,
                    topic: `user_${target.userId}`,
                };
                result = await admin.messaging().send(topicMessage);
            }
            else {
                throw new Error('No valid target specified');
            }
            return {
                success: true,
                messageId: result.messageId || 'multicast',
            };
        }
        catch (error) {
            console.error('Error sending push notification:', error);
            return {
                success: false,
                error: error.message,
            };
        }
    }
    async sendToDeviceTokens(deviceTokens, notification) {
        try {
            if (!this.firebaseApp) {
                throw new Error('Firebase not initialized');
            }
            const message = {
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
        }
        catch (error) {
            console.error('Error sending multicast notification:', error);
            return {
                success: false,
                results: [],
            };
        }
    }
    async subscribeToTopic(deviceToken, topic) {
        try {
            if (!this.firebaseApp) {
                throw new Error('Firebase not initialized');
            }
            await admin.messaging().subscribeToTopic(deviceToken, topic);
            return true;
        }
        catch (error) {
            console.error('Error subscribing to topic:', error);
            return false;
        }
    }
    async unsubscribeFromTopic(deviceToken, topic) {
        try {
            if (!this.firebaseApp) {
                throw new Error('Firebase not initialized');
            }
            await admin.messaging().unsubscribeFromTopic(deviceToken, topic);
            return true;
        }
        catch (error) {
            console.error('Error unsubscribing from topic:', error);
            return false;
        }
    }
    async sendToTopic(topic, notification) {
        try {
            if (!this.firebaseApp) {
                throw new Error('Firebase not initialized');
            }
            const message = {
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
        }
        catch (error) {
            console.error('Error sending to topic:', error);
            return {
                success: false,
            };
        }
    }
    convertDataToString(data) {
        const result = {};
        for (const [key, value] of Object.entries(data)) {
            if (typeof value === 'string') {
                result[key] = value;
            }
            else {
                result[key] = JSON.stringify(value);
            }
        }
        return result;
    }
    async sendGatePassNotification(userId, gatePassId, status, deviceTokens) {
        const titles = {
            'PENDING': 'Gate Pass Request Submitted',
            'APPROVED': 'Gate Pass Approved',
            'REJECTED': 'Gate Pass Rejected',
            'COMPLETED': 'Gate Pass Completed',
        };
        const notification = {
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
        }
        else {
            return this.sendToTopic(`user_${userId}`, notification);
        }
    }
    async sendAttendanceNotification(userId, attendanceData, deviceTokens) {
        const notification = {
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
        }
        else {
            return this.sendToTopic(`user_${userId}`, notification);
        }
    }
    async sendRoomAllocationNotification(userId, roomData, deviceTokens) {
        const notification = {
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
        }
        else {
            return this.sendToTopic(`user_${userId}`, notification);
        }
    }
    async sendMealIntentReminder(userId, mealData, deviceTokens) {
        const notification = {
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
        }
        else {
            return this.sendToTopic(`user_${userId}`, notification);
        }
    }
    async sendEmergencyNotice(notice, targetRole) {
        const notification = {
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
    async sendSystemMaintenanceNotice(message, targetRole) {
        const notification = {
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
};
exports.FirebaseService = FirebaseService;
exports.FirebaseService = FirebaseService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [config_1.ConfigService])
], FirebaseService);
//# sourceMappingURL=firebase.service.js.map