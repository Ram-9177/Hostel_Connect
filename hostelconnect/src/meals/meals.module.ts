import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ScheduleModule } from '@nestjs/schedule';
import { MealsController } from './meals.controller';
import { MealsService } from './meals.service';
import { MealSchedulerService } from './meal-scheduler.service';
import { MealIntent } from './entities/meal-intent.entity';
import { MealOverride } from './entities/meal-override.entity';
import { Student } from '../students/entities/student.entity';
import { Hostel } from '../hostels/entities/hostel.entity';
import { NotificationsModule } from '../notifications/notifications.module';
import { SocketService } from '../socket/socket.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      MealIntent,
      MealOverride,
      Student,
      Hostel,
    ]),
    ScheduleModule.forRoot(),
    NotificationsModule,
  ],
  controllers: [MealsController],
  providers: [MealsService, MealSchedulerService, SocketService],
  exports: [MealsService, MealSchedulerService],
})
export class MealsModule {}
