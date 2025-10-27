import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SocketGateway } from './socket.gateway';
import { SocketService } from './socket.service';
import { Notification } from './entities/notification.entity';
import { NotificationService } from './notification.service';

@Module({
  imports: [TypeOrmModule.forFeature([Notification])],
  providers: [SocketGateway, SocketService, NotificationService],
  exports: [SocketGateway, SocketService, NotificationService],
})
export class SocketModule {}
