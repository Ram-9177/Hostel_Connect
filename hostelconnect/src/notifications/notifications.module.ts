import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { NotificationsController } from './notifications.controller';
import { NotificationsService } from './notifications.service';
import { Notification } from './entities/notification.entity';
import { Device } from './entities/device.entity';
import { Student } from '../students/entities/student.entity';
import { Room } from '../rooms/entities/room.entity';
import { Block } from '../hostels/entities/block.entity';
import { SocketService } from '../socket/socket.service';
import { FirebaseService } from './firebase.service';
import { DeviceService } from './device.service';

@Module({
  imports: [TypeOrmModule.forFeature([Notification, Device, Student, Room, Block])],
  controllers: [NotificationsController],
  providers: [NotificationsService, SocketService, FirebaseService, DeviceService],
  exports: [NotificationsService, FirebaseService, DeviceService],
})
export class NotificationsModule {}
