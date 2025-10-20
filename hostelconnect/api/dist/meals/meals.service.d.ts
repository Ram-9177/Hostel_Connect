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
export declare class MealsService {
    private readonly mealIntentRepository;
    private readonly mealOverrideRepository;
    private readonly studentRepository;
    private readonly hostelRepository;
    constructor(mealIntentRepository: Repository<MealIntent>, mealOverrideRepository: Repository<MealOverride>, studentRepository: Repository<Student>, hostelRepository: Repository<Hostel>);
    openIntents(openDto: OpenMealIntentsDto): Promise<{
        date: Date;
        isOpen: boolean;
        cutoffTime: Date;
    }>;
    setDayIntents(intentsDto: SetDayIntentsDto, studentId: string): Promise<MealIntent[]>;
    updateIntent(updateDto: UpdateIntentDto, studentId: string): Promise<MealIntent>;
    getForecast(days?: number): Promise<any>;
    createOverride(overrideDto: CreateOverrideDto, createdBy: string): Promise<MealOverride>;
    getStudentIntents(studentId: string, date: Date): Promise<MealIntent[]>;
    getChefBoard(date: Date): Promise<any>;
    getQuickActions(studentId: string): Promise<any>;
}
