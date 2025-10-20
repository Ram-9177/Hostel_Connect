import { Hostel } from '../../hostels/entities/hostel.entity';
import { User } from '../../users/entities/user.entity';
export declare class MealOverride {
    id: string;
    date: Date;
    meal: string;
    hostelId: string;
    delta: number;
    reason: string;
    createdBy: string;
    createdAt: Date;
    hostel: Hostel;
    createdByUser: User;
}
