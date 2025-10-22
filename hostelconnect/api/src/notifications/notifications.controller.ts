import { Controller, Get, Post, Body, UseGuards, Request, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { NotificationsService } from './notifications.service';
import { SocketService } from '../socket/socket.service';

@ApiTags('Notifications')
@Controller('notifications')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class NotificationsController {
  constructor(
    private readonly notificationsService: NotificationsService,
    private readonly socketService: SocketService,
  ) {}

  @Get()
  @ApiOperation({ summary: 'Get user notifications' })
  @ApiResponse({ status: 200, description: 'Notifications retrieved' })
  async getUserNotifications(@Request() req, @Query('limit') limit?: number) {
    return this.notificationsService.getNotificationsForUser(req.user.id, limit);
  }

  @Get('unread-count')
  @ApiOperation({ summary: 'Get unread notifications count' })
  @ApiResponse({ status: 200, description: 'Unread count retrieved' })
  async getUnreadCount(@Request() req) {
    const count = await this.notificationsService.getUnreadCount(req.user.id);
    return { unreadCount: count };
  }

  @Post('mark-read')
  @ApiOperation({ summary: 'Mark notification as read' })
  @ApiResponse({ status: 200, description: 'Notification marked as read' })
  async markAsRead(@Request() req, @Body() body: { notificationId: string }) {
    await this.notificationsService.markAsRead(body.notificationId, req.user.id);
    return { success: true };
  }

  @Post('mark-all-read')
  @ApiOperation({ summary: 'Mark all notifications as read' })
  @ApiResponse({ status: 200, description: 'All notifications marked as read' })
  async markAllAsRead(@Request() req) {
    await this.notificationsService.markAllAsRead(req.user.id);
    return { success: true };
  }

  @Post('send')
  @ApiOperation({ summary: 'Send notification (Admin only)' })
  @ApiResponse({ status: 201, description: 'Notification sent' })
  async sendNotification(@Request() req, @Body() notificationData: any) {
    // Check if user has permission to send notifications
    if (!['SUPER_ADMIN', 'WARDEN_HEAD'].includes(req.user.role)) {
      throw new Error('Unauthorized to send notifications');
    }

    const notification = await this.notificationsService.createNotification(notificationData);
    
    // Send real-time notification
    if (notificationData.targetUserId) {
      await this.socketService.notifyUser(notificationData.targetUserId, notification);
    } else if (notificationData.targetRole) {
      await this.socketService.notifyRole(notificationData.targetRole, notification);
    } else {
      await this.socketService.broadcastToAll(notification);
    }

    return notification;
  }

  @Post('test')
  @ApiOperation({ summary: 'Send test notification' })
  @ApiResponse({ status: 200, description: 'Test notification sent' })
  async sendTestNotification(@Request() req) {
    const testNotification = {
      title: 'Test Notification',
      body: 'This is a test notification from HostelConnect',
      type: 'system' as const,
      priority: 'low' as const,
      targetUserId: req.user.id,
    };

    const notification = await this.notificationsService.createNotification(testNotification);
    await this.socketService.notifyUser(req.user.id, notification);

    return { success: true, notification };
  }
}
