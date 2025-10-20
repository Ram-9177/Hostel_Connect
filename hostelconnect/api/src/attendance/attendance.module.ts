import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AttendanceController } from './attendance.controller';
import { AttendanceService } from './attendance.service';
import { AttendanceSession } from './entities/attendance-session.entity';
import { AttendanceRoster } from './entities/attendance-roster.entity';
import { AttendanceCheck } from './entities/attendance-check.entity';
import { Student } from '../students/entities/student.entity';
import { Room } from '../rooms/entities/room.entity';
import { QRTokenService } from '../common/utils/qr-token.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      AttendanceSession,
      AttendanceRoster,
      AttendanceCheck,
      Student,
      Room,
    ]),
  ],
  controllers: [AttendanceController],
  providers: [AttendanceService, QRTokenService],
  exports: [AttendanceService],
})
export class AttendanceModule {}
