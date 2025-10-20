import { Repository } from 'typeorm';
import { Ad } from './entities/ad.entity';
import { AdEvent } from './entities/ad-event.entity';
export interface EligibleAdResponse {
    id: string;
    type: string;
    assetUrl: string;
    durationS: number;
}
export interface AdEventDto {
    adId: string;
    module: string;
    result: string;
}
export declare class AdsService {
    private readonly adRepository;
    private readonly adEventRepository;
    constructor(adRepository: Repository<Ad>, adEventRepository: Repository<AdEvent>);
    getEligibleAd(module: string): Promise<EligibleAdResponse | null>;
    logAdEvent(eventDto: AdEventDto, userId: string): Promise<AdEvent>;
    getAdStats(adId: string): Promise<{
        totalViews: number;
        completedViews: number;
        skippedViews: number;
        completionRate: number;
    }>;
    createAd(adData: Partial<Ad>): Promise<Ad>;
    findAll(): Promise<Ad[]>;
}
