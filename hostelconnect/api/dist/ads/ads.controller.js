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
exports.AdsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const ads_service_1 = require("./ads.service");
const ad_event_dto_1 = require("./dto/ad-event.dto");
let AdsController = class AdsController {
    constructor(adsService) {
        this.adsService = adsService;
    }
    async getEligibleAd(module) {
        return this.adsService.getEligibleAd(module);
    }
    async logAdEvent(eventDto, req) {
        return this.adsService.logAdEvent(eventDto, req.user.id);
    }
    async getAdStats(adId) {
        return this.adsService.getAdStats(adId);
    }
    async findAll() {
        return this.adsService.findAll();
    }
};
exports.AdsController = AdsController;
__decorate([
    (0, common_1.Get)('eligible'),
    (0, swagger_1.ApiOperation)({ summary: 'Get eligible ad for module' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Eligible ad retrieved' }),
    __param(0, (0, common_1.Query)('module')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AdsController.prototype, "getEligibleAd", null);
__decorate([
    (0, common_1.Post)('event'),
    (0, swagger_1.ApiOperation)({ summary: 'Log ad event' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Ad event logged' }),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [ad_event_dto_1.AdEventDto, Object]),
    __metadata("design:returntype", Promise)
], AdsController.prototype, "logAdEvent", null);
__decorate([
    (0, common_1.Get)('stats/:adId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get ad statistics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Ad statistics retrieved' }),
    __param(0, (0, common_1.Query)('adId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AdsController.prototype, "getAdStats", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get all ads (Admin only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Ads list retrieved' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AdsController.prototype, "findAll", null);
exports.AdsController = AdsController = __decorate([
    (0, swagger_1.ApiTags)('Ads'),
    (0, common_1.Controller)('ads'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [ads_service_1.AdsService])
], AdsController);
//# sourceMappingURL=ads.controller.js.map