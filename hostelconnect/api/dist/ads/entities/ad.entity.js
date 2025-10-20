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
Object.defineProperty(exports, "__esModule", { value: true });
exports.Ad = exports.AdType = void 0;
const typeorm_1 = require("typeorm");
const ad_event_entity_1 = require("./ad-event.entity");
var AdType;
(function (AdType) {
    AdType["INTERSTITIAL"] = "INTERSTITIAL";
    AdType["BANNER"] = "BANNER";
    AdType["MINICARD"] = "MINICARD";
})(AdType || (exports.AdType = AdType = {}));
let Ad = class Ad {
};
exports.Ad = Ad;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], Ad.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], Ad.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Ad.prototype, "assetUrl", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Ad.prototype, "durationS", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], Ad.prototype, "active", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], Ad.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], Ad.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => ad_event_entity_1.AdEvent, adEvent => adEvent.ad),
    __metadata("design:type", Array)
], Ad.prototype, "events", void 0);
exports.Ad = Ad = __decorate([
    (0, typeorm_1.Entity)('ads')
], Ad);
//# sourceMappingURL=ad.entity.js.map