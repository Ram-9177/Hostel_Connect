import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MealsController } from './meals.controller';
import { MealsService } from './meals.service';
import { MealIntent } from './entities/meal-intent.entity';
import { MealOverride } from './entities/meal-override.entity';
import { Student } from '../students/entities/student.entity';
import { Hostel } from '../hostels/entities/hostel.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      MealIntent,
      MealOverride,
      Student,
      Hostel,
    ]),
  ],
  controllers: [MealsController],
  providers: [MealsService],
  exports: [MealsService],
})
export class MealsModule {}
