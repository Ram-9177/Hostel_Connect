import { MealsService, OpenMealIntentsDto, SetDayIntentsDto, UpdateIntentDto, CreateOverrideDto } from './meals.service';
export declare class MealsController {
    private readonly mealsService;
    constructor(mealsService: MealsService);
    openIntents(openDto: OpenMealIntentsDto): Promise<{
        date: Date;
        isOpen: boolean;
        cutoffTime: Date;
    }>;
    setDayIntents(intentsDto: SetDayIntentsDto, req: any): Promise<import("./entities/meal-intent.entity").MealIntent[]>;
    updateIntent(updateDto: UpdateIntentDto, req: any): Promise<import("./entities/meal-intent.entity").MealIntent>;
    getForecast(days?: number): Promise<any>;
    createOverride(overrideDto: CreateOverrideDto, req: any): Promise<import("./entities/meal-override.entity").MealOverride>;
    getStudentIntents(date: string, req: any): Promise<import("./entities/meal-intent.entity").MealIntent[]>;
    getChefBoard(date: string): Promise<any>;
    getQuickActions(req: any): Promise<any>;
}
