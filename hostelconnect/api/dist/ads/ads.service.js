"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AdsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const ad_entity_1 = require("./entities/ad.entity");
const ad_event_entity_1 = require("./entities/ad-event.entity");
let AdsService = class AdsService {
    constructor(adRepository, adEventRepository) {
        this.adRepository = adRepository;
        this.adEventRepository = adEventRepository;
    }
    async getEligibleAd(module) {
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
                durationS: 20,
            };
        }
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
    async logAdEvent(eventDto, userId) {
        const adEvent = this.adEventRepository.create({
            adId: eventDto.adId,
            userId,
            module: eventDto.module,
            result: eventDto.result,
            timestamp: new Date(),
        });
        return this.adEventRepository.save(adEvent);
    }
    async getAdStats(adId) {
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
    async createAd(adData) {
        const ad = this.adRepository.create(adData);
        return this.adRepository.save(ad);
    }
    async findAll() {
        return this.adRepository.find({
            order: { createdAt: 'DESC' },
        });
    }
};
exports.AdsService = AdsService;
exports.AdsService = AdsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(ad_entity_1.Ad)),
    __param(1, (0, typeorm_1.InjectRepository)(ad_event_entity_1.AdEvent)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository])
], AdsService);
//# sourceMappingURL=ads.service.js.map