import { Ad } from './ad.entity';
import { User } from '../../users/entities/user.entity';
export declare enum AdEventResult {
    STARTED = "STARTED",
    COMPLETED = "COMPLETED",
    SKIPPED = "SKIPPED"
}
export declare class AdEvent {
    id: string;
    adId: string;
    userId: string;
    module: string;
    timestamp: Date;
    result: string;
    createdAt: Date;
    ad: Ad;
    user: User;
}
