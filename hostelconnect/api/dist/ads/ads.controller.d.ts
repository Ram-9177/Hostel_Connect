import { AdsService } from './ads.service';
import { AdEventDto } from './dto/ad-event.dto';
export declare class AdsController {
    private readonly adsService;
    constructor(adsService: AdsService);
    getEligibleAd(module: string): Promise<import("./ads.service").EligibleAdResponse>;
    logAdEvent(eventDto: AdEventDto, req: any): Promise<import("./entities/ad-event.entity").AdEvent>;
    getAdStats(adId: string): Promise<{
        totalViews: number;
        completedViews: number;
        skippedViews: number;
        completionRate: number;
    }>;
    findAll(): Promise<import("./entities/ad.entity").Ad[]>;
}
