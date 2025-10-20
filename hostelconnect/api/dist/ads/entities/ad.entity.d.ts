import { AdEvent } from './ad-event.entity';
export declare enum AdType {
    INTERSTITIAL = "INTERSTITIAL",
    BANNER = "BANNER",
    MINICARD = "MINICARD"
}
export declare class Ad {
    id: string;
    type: string;
    assetUrl: string;
    durationS: number;
    active: boolean;
    createdAt: Date;
    updatedAt: Date;
    events: AdEvent[];
}
