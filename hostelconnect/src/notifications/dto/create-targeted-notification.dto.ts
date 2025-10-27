import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsEnum, IsOptional, IsArray, IsDateString } from 'class-validator';

export enum NotificationType {
  GATE_PASS = 'gate_pass',
  ATTENDANCE = 'attendance',
  ROOM_ALLOCATION = 'room_allocation',
  MEAL_INTENT = 'meal_intent',
  NOTICE = 'notice',
  SYSTEM = 'system',
  ANNOUNCEMENT = 'announcement',
}

export enum NotificationPriority {
  LOW = 'low',
  MEDIUM = 'medium',
  HIGH = 'high',
  URGENT = 'urgent',
}

export enum TargetType {
  ALL = 'all',
  HOSTEL = 'hostel',
  BLOCK = 'block',
  FLOOR = 'floor',
  ROOM = 'room',
  STUDENT = 'student',
  ROLE = 'role',
}

export class CreateTargetedNotificationDto {
  @ApiProperty({ description: 'Notification title' })
  @IsString()
  title: string;

  @ApiProperty({ description: 'Notification body/message' })
  @IsString()
  body: string;

  @ApiProperty({ enum: NotificationType, description: 'Type of notification' })
  @IsEnum(NotificationType)
  type: NotificationType;

  @ApiProperty({ enum: NotificationPriority, description: 'Priority level' })
  @IsEnum(NotificationPriority)
  priority: NotificationPriority;

  @ApiProperty({ enum: TargetType, description: 'Target audience type' })
  @IsEnum(TargetType)
  targetType: TargetType;

  @ApiPropertyOptional({ description: 'Hostel ID (when targetType is HOSTEL, BLOCK, FLOOR, or ROOM)' })
  @IsOptional()
  @IsString()
  hostelId?: string;

  @ApiPropertyOptional({ description: 'Block ID (when targetType is BLOCK, FLOOR, or ROOM)' })
  @IsOptional()
  @IsString()
  blockId?: string;

  @ApiPropertyOptional({ description: 'Floor number (when targetType is FLOOR)' })
  @IsOptional()
  floor?: number;

  @ApiPropertyOptional({ description: 'Room ID (when targetType is ROOM)' })
  @IsOptional()
  @IsString()
  roomId?: string;

  @ApiPropertyOptional({ description: 'Student ID (when targetType is STUDENT)' })
  @IsOptional()
  @IsString()
  studentId?: string;

  @ApiPropertyOptional({ description: 'Role (when targetType is ROLE)' })
  @IsOptional()
  @IsString()
  role?: string;

  @ApiPropertyOptional({ description: 'Additional data payload' })
  @IsOptional()
  data?: any;

  @ApiPropertyOptional({ description: 'Expiration date for the notification' })
  @IsOptional()
  @IsDateString()
  expiresAt?: Date;
}
