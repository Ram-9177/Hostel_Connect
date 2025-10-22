import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HostelsController } from './hostels.controller';
import { HostelsService } from './hostels.service';
import { Hostel } from './entities/hostel.entity';
import { Block } from './entities/block.entity';
import { Room } from '../rooms/entities/room.entity';
import { Student } from '../students/entities/student.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Hostel, Block, Room, Student])
  ],
  controllers: [HostelsController],
  providers: [HostelsService],
  exports: [HostelsService],
})
export class HostelsModule {}
