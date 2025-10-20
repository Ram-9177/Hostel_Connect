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
exports.MealIntent = exports.MealIntentValue = exports.MealType = void 0;
const typeorm_1 = require("typeorm");
const student_entity_1 = require("../../students/entities/student.entity");
var MealType;
(function (MealType) {
    MealType["BREAKFAST"] = "BREAKFAST";
    MealType["LUNCH"] = "LUNCH";
    MealType["SNACKS"] = "SNACKS";
    MealType["DINNER"] = "DINNER";
})(MealType || (exports.MealType = MealType = {}));
var MealIntentValue;
(function (MealIntentValue) {
    MealIntentValue["YES"] = "YES";
    MealIntentValue["NO"] = "NO";
})(MealIntentValue || (exports.MealIntentValue = MealIntentValue = {}));
let MealIntent = class MealIntent {
};
exports.MealIntent = MealIntent;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], MealIntent.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'date' }),
    __metadata("design:type", Date)
], MealIntent.prototype, "date", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], MealIntent.prototype, "meal", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], MealIntent.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], MealIntent.prototype, "value", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], MealIntent.prototype, "decidedAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], MealIntent.prototype, "diet", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], MealIntent.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], MealIntent.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => student_entity_1.Student),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", student_entity_1.Student)
], MealIntent.prototype, "student", void 0);
exports.MealIntent = MealIntent = __decorate([
    (0, typeorm_1.Entity)('meal_intents'),
    (0, typeorm_1.Unique)(['studentId', 'date', 'meal'])
], MealIntent);
//# sourceMappingURL=meal-intent.entity.js.map