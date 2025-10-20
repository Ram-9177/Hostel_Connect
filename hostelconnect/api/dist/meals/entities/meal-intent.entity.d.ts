import { Student } from '../../students/entities/student.entity';
export declare enum MealType {
    BREAKFAST = "BREAKFAST",
    LUNCH = "LUNCH",
    SNACKS = "SNACKS",
    DINNER = "DINNER"
}
export declare enum MealIntentValue {
    YES = "YES",
    NO = "NO"
}
export declare class MealIntent {
    id: string;
    date: Date;
    meal: string;
    studentId: string;
    value: string;
    decidedAt: Date;
    diet?: string;
    createdAt: Date;
    updatedAt: Date;
    student: Student;
}
