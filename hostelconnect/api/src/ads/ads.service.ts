import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
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

@Injectable()
export class AdsService {
  constructor(
    @InjectRepository(Ad)
    private readonly adRepository: Repository<Ad>,
    @InjectRepository(AdEvent)
    private readonly adEventRepository: Repository<AdEvent>,
  ) {}

  async getEligibleAd(module: string): Promise<EligibleAdResponse | null> {
    // For gate pass module, return 20s interstitial ad
    if (module === 'gatepass') {
      const ad = await this.adRepository.findOne({
        where: {
          type: 'INTERSTITIAL',
          active: true,
        },
        order: { createdAt: 'DESC' },
      });

      if (!ad) {
        return null;
      }

      return {
        id: ad.id,
        type: ad.type,
        assetUrl: ad.assetUrl,
        durationS: 20, // Fixed 20 seconds for gate pass unlock
      };
    }

    // For other modules, return banner or minicard
    const ad = await this.adRepository.findOne({
      where: {
        type: 'BANNER',
        active: true,
      },
      order: { createdAt: 'DESC' },
    });

    if (!ad) {
      return null;
    }

    return {
      id: ad.id,
      type: ad.type,
      assetUrl: ad.assetUrl,
      durationS: ad.durationS,
    };
  }

  async logAdEvent(eventDto: AdEventDto, userId: string): Promise<AdEvent> {
    const adEvent = this.adEventRepository.create({
      adId: eventDto.adId,
      userId,
      module: eventDto.module,
      result: eventDto.result,
      timestamp: new Date(),
    });

    return this.adEventRepository.save(adEvent);
  }

  async getAdStats(adId: string): Promise<{
    totalViews: number;
    completedViews: number;
    skippedViews: number;
    completionRate: number;
  }> {
    const events = await this.adEventRepository.find({
      where: { adId },
    });

    const totalViews = events.length;
    const completedViews = events.filter(e => e.result === 'COMPLETED').length;
    const skippedViews = events.filter(e => e.result === 'SKIPPED').length;
    const completionRate = totalViews > 0 ? (completedViews / totalViews) * 100 : 0;

    return {
      totalViews,
      completedViews,
      skippedViews,
      completionRate,
    };
  }

  async createAd(adData: Partial<Ad>): Promise<Ad> {
    const ad = this.adRepository.create(adData);
    return this.adRepository.save(ad);
  }

  async findAll(): Promise<Ad[]> {
    return this.adRepository.find({
      order: { createdAt: 'DESC' },
    });
  }
}
