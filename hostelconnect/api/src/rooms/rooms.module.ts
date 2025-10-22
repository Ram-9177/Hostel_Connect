import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RoomsController } from './rooms.controller';
import { RoomsService } from './rooms.service';
import { Room } from './entities/room.entity';
import { Student } from '../students/entities/student.entity';
import { Block } from '../hostels/entities/block.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Room, Student, Block])
  ],
  controllers: [RoomsController],
  providers: [RoomsService],
  exports: [RoomsService],
})
export class RoomsModule {}