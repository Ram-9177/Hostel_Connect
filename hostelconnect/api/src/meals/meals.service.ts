import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { MealIntent, MealType, MealIntentValue } from './entities/meal-intent.entity';
import { MealOverride } from './entities/meal-override.entity';
import { Student } from '../students/entities/student.entity';
import { Hostel } from '../hostels/entities/hostel.entity';

export interface OpenMealIntentsDto {
  date: Date;
}

export interface SetDayIntentsDto {
  date: Date;
  intents: {
    BREAKFAST: MealIntentValue;
    LUNCH: MealIntentValue;
    SNACKS: MealIntentValue;
    DINNER: MealIntentValue;
  };
}

export interface UpdateIntentDto {
  date: Date;
  meal: MealType;
  value: MealIntentValue;
  diet?: string;
}

export interface CreateOverrideDto {
  date: Date;
  meal: MealType;
  hostelId: string;
  delta: number;
  reason: string;
}

@Injectable()
export class MealsService {
  constructor(
    @InjectRepository(MealIntent)
    private readonly mealIntentRepository: Repository<MealIntent>,
    @InjectRepository(MealOverride)
    private readonly mealOverrideRepository: Repository<MealOverride>,
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @InjectRepository(Hostel)
    private readonly hostelRepository: Repository<Hostel>,
  ) {}

  async openIntents(openDto: OpenMealIntentsDto): Promise<{ date: Date; isOpen: boolean; cutoffTime: Date }> {
    const cutoffTime = new Date(openDto.date);
    cutoffTime.setHours(20, 0, 0, 0); // 20:00 IST cutoff

    // Check if intents are already open for this date
    const existingIntents = await this.mealIntentRepository.findOne({
      where: { date: openDto.date },
    });

    const isOpen = !existingIntents || new Date() < cutoffTime;

    return {
      date: openDto.date,
      isOpen,
      cutoffTime,
    };
  }

  async setDayIntents(intentsDto: SetDayIntentsDto, studentId: string): Promise<MealIntent[]> {
    const cutoffTime = new Date(intentsDto.date);
    cutoffTime.setHours(20, 0, 0, 0); // 20:00 IST cutoff

    // Check if cutoff has passed
    if (new Date() > cutoffTime) {
      throw new BadRequestException('Meal intent cutoff has passed');
    }

    const intents: MealIntent[] = [];

    // Create or update intents for each meal
    for (const [meal, value] of Object.entries(intentsDto.intents)) {
      const existingIntent = await this.mealIntentRepository.findOne({
        where: {
          studentId,
          date: intentsDto.date,
          meal: meal as MealType,
        },
      });

      if (existingIntent) {
        existingIntent.value = value;
        existingIntent.decidedAt = new Date();
        intents.push(await this.mealIntentRepository.save(existingIntent));
      } else {
        const intent = this.mealIntentRepository.create({
          studentId,
          date: intentsDto.date,
          meal: meal as MealType,
          value,
          decidedAt: new Date(),
        });
        intents.push(await this.mealIntentRepository.save(intent));
      }
    }

    return intents;
  }

  async updateIntent(updateDto: UpdateIntentDto, studentId: string): Promise<MealIntent> {
    const cutoffTime = new Date(updateDto.date);
    cutoffTime.setHours(20, 0, 0, 0); // 20:00 IST cutoff

    // Check if cutoff has passed
    if (new Date() > cutoffTime) {
      throw new BadRequestException('Meal intent cutoff has passed');
    }

    const existingIntent = await this.mealIntentRepository.findOne({
      where: {
        studentId,
        date: updateDto.date,
        meal: updateDto.meal,
      },
    });

    if (existingIntent) {
      existingIntent.value = updateDto.value;
      existingIntent.diet = updateDto.diet;
      existingIntent.decidedAt = new Date();
      return this.mealIntentRepository.save(existingIntent);
    } else {
      const intent = this.mealIntentRepository.create({
        studentId,
        date: updateDto.date,
        meal: updateDto.meal,
        value: updateDto.value,
        diet: updateDto.diet,
        decidedAt: new Date(),
      });
      return this.mealIntentRepository.save(intent);
    }
  }

  async getForecast(days: number = 7): Promise<any> {
    const forecasts = [];
    const today = new Date();

    for (let i = 0; i < days; i++) {
      const date = new Date(today);
      date.setDate(today.getDate() + i);

      const dayForecast = {
        date,
        meals: {},
      };

      // Get forecast for each meal type
      for (const meal of Object.values(MealType)) {
        const intents = await this.mealIntentRepository.find({
          where: {
            date,
            meal,
          },
        });

        const yesCount = intents.filter(i => i.value === MealIntentValue.YES).length;
        const noCount = intents.filter(i => i.value === MealIntentValue.NO).length;
        const totalIntents = intents.length;

        // Get override for this meal
        const override = await this.mealOverrideRepository.findOne({
          where: {
            date,
            meal,
          },
        });

        const overrideDelta = override ? override.delta : 0;
        const forecastCount = Math.round(yesCount + (yesCount * 0.05) + overrideDelta); // 5% buffer

        dayForecast.meals[meal] = {
          yesCount,
          noCount,
          totalIntents,
          forecastCount,
          overrideDelta,
        };
      }

      forecasts.push(dayForecast);
    }

    return { forecasts };
  }

  async createOverride(overrideDto: CreateOverrideDto, createdBy: string): Promise<MealOverride> {
    // Check if override already exists for this date and meal
    const existingOverride = await this.mealOverrideRepository.findOne({
      where: {
        date: overrideDto.date,
        meal: overrideDto.meal,
        hostelId: overrideDto.hostelId,
      },
    });

    if (existingOverride) {
      throw new BadRequestException('Override already exists for this meal');
    }

    const override = this.mealOverrideRepository.create({
      ...overrideDto,
      createdBy,
    });

    return this.mealOverrideRepository.save(override);
  }

  async getStudentIntents(studentId: string, date: Date): Promise<MealIntent[]> {
    return this.mealIntentRepository.find({
      where: {
        studentId,
        date,
      },
      order: { meal: 'ASC' },
    });
  }

  async getChefBoard(date: Date): Promise<any> {
    const meals = Object.values(MealType);
    const chefBoard = {
      date,
      meals: {},
    };

    for (const meal of meals) {
      const intents = await this.mealIntentRepository.find({
        where: {
          date,
          meal,
        },
      });

      const yesCount = intents.filter(i => i.value === MealIntentValue.YES).length;
      const noCount = intents.filter(i => i.value === MealIntentValue.NO).length;
      const totalIntents = intents.length;

      // Get override
      const override = await this.mealOverrideRepository.findOne({
        where: {
          date,
          meal,
        },
      });

      const overrideDelta = override ? override.delta : 0;
      const forecastCount = Math.round(yesCount + (yesCount * 0.05) + overrideDelta);

      chefBoard.meals[meal] = {
        yesCount,
        noCount,
        totalIntents,
        forecastCount,
        overrideDelta,
        overrideReason: override?.reason,
      };
    }

    return chefBoard;
  }

  async getQuickActions(studentId: string): Promise<any> {
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(today.getDate() - 1);

    // Get yesterday's intents
    const yesterdayIntents = await this.mealIntentRepository.find({
      where: {
        studentId,
        date: yesterday,
      },
    });

    const yesterdayMap = yesterdayIntents.reduce((acc, intent) => {
      acc[intent.meal] = intent.value;
      return acc;
    }, {} as Record<MealType, MealIntentValue>);

    return {
      allYes: Object.values(MealType).reduce((acc, meal) => {
        acc[meal] = MealIntentValue.YES;
        return acc;
      }, {} as Record<MealType, MealIntentValue>),
      allNo: Object.values(MealType).reduce((acc, meal) => {
        acc[meal] = MealIntentValue.NO;
        return acc;
      }, {} as Record<MealType, MealIntentValue>),
      sameAsYesterday: yesterdayMap,
    };
  }
}
