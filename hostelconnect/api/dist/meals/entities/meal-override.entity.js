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
exports.MealOverride = void 0;
const typeorm_1 = require("typeorm");
const hostel_entity_1 = require("../../hostels/entities/hostel.entity");
const user_entity_1 = require("../../users/entities/user.entity");
let MealOverride = class MealOverride {
};
exports.MealOverride = MealOverride;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], MealOverride.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'date' }),
    __metadata("design:type", Date)
], MealOverride.prototype, "date", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], MealOverride.prototype, "meal", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], MealOverride.prototype, "hostelId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], MealOverride.prototype, "delta", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], MealOverride.prototype, "reason", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], MealOverride.prototype, "createdBy", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], MealOverride.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => hostel_entity_1.Hostel),
    (0, typeorm_1.JoinColumn)({ name: 'hostelId' }),
    __metadata("design:type", hostel_entity_1.Hostel)
], MealOverride.prototype, "hostel", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User),
    (0, typeorm_1.JoinColumn)({ name: 'createdBy' }),
    __metadata("design:type", user_entity_1.User)
], MealOverride.prototype, "createdByUser", void 0);
exports.MealOverride = MealOverride = __decorate([
    (0, typeorm_1.Entity)('meal_overrides')
], MealOverride);
//# sourceMappingURL=meal-override.entity.js.map