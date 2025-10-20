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
exports.AdEvent = exports.AdEventResult = void 0;
const typeorm_1 = require("typeorm");
const ad_entity_1 = require("./ad.entity");
const user_entity_1 = require("../../users/entities/user.entity");
var AdEventResult;
(function (AdEventResult) {
    AdEventResult["STARTED"] = "STARTED";
    AdEventResult["COMPLETED"] = "COMPLETED";
    AdEventResult["SKIPPED"] = "SKIPPED";
})(AdEventResult || (exports.AdEventResult = AdEventResult = {}));
let AdEvent = class AdEvent {
};
exports.AdEvent = AdEvent;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], AdEvent.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AdEvent.prototype, "adId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AdEvent.prototype, "userId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], AdEvent.prototype, "module", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], AdEvent.prototype, "timestamp", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], AdEvent.prototype, "result", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], AdEvent.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => ad_entity_1.Ad),
    (0, typeorm_1.JoinColumn)({ name: 'adId' }),
    __metadata("design:type", ad_entity_1.Ad)
], AdEvent.prototype, "ad", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User),
    (0, typeorm_1.JoinColumn)({ name: 'userId' }),
    __metadata("design:type", user_entity_1.User)
], AdEvent.prototype, "user", void 0);
exports.AdEvent = AdEvent = __decorate([
    (0, typeorm_1.Entity)('ad_events')
], AdEvent);
//# sourceMappingURL=ad-event.entity.js.map