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
exports.MealsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const meal_intent_entity_1 = require("./entities/meal-intent.entity");
const meal_override_entity_1 = require("./entities/meal-override.entity");
const student_entity_1 = require("../students/entities/student.entity");
const hostel_entity_1 = require("../hostels/entities/hostel.entity");
let MealsService = class MealsService {
    constructor(mealIntentRepository, mealOverrideRepository, studentRepository, hostelRepository) {
        this.mealIntentRepository = mealIntentRepository;
        this.mealOverrideRepository = mealOverrideRepository;
        this.studentRepository = studentRepository;
        this.hostelRepository = hostelRepository;
    }
    async openIntents(openDto) {
        const cutoffTime = new Date(openDto.date);
        cutoffTime.setHours(20, 0, 0, 0);
        const existingIntents = await this.mealIntentRepository.findOne({
            where: { date: openDto.date },
        });
        const isOpen = !existingIntents || new Date() < cutoffTime;
        return {
            date: openDto.date,
            isOpen,
            cutoffTime,
        };
    }
    async setDayIntents(intentsDto, studentId) {
        const cutoffTime = new Date(intentsDto.date);
        cutoffTime.setHours(20, 0, 0, 0);
        if (new Date() > cutoffTime) {
            throw new common_1.BadRequestException('Meal intent cutoff has passed');
        }
        const intents = [];
        for (const [meal, value] of Object.entries(intentsDto.intents)) {
            const existingIntent = await this.mealIntentRepository.findOne({
                where: {
                    studentId,
                    date: intentsDto.date,
                    meal: meal,
                },
            });
            if (existingIntent) {
                existingIntent.value = value;
                existingIntent.decidedAt = new Date();
                intents.push(await this.mealIntentRepository.save(existingIntent));
            }
            else {
                const intent = this.mealIntentRepository.create({
                    studentId,
                    date: intentsDto.date,
                    meal: meal,
                    value,
                    decidedAt: new Date(),
                });
                intents.push(await this.mealIntentRepository.save(intent));
            }
        }
        return intents;
    }
    async updateIntent(updateDto, studentId) {
        const cutoffTime = new Date(updateDto.date);
        cutoffTime.setHours(20, 0, 0, 0);
        if (new Date() > cutoffTime) {
            throw new common_1.BadRequestException('Meal intent cutoff has passed');
        }
        const existingIntent = await this.mealIntentRepository.findOne({
            where: {
                studentId,
                date: updateDto.date,
                meal: updateDto.meal,
            },
        });
        if (existingIntent) {
            existingIntent.value = updateDto.value;
            existingIntent.diet = updateDto.diet;
            existingIntent.decidedAt = new Date();
            return this.mealIntentRepository.save(existingIntent);
        }
        else {
            const intent = this.mealIntentRepository.create({
                studentId,
                date: updateDto.date,
                meal: updateDto.meal,
                value: updateDto.value,
                diet: updateDto.diet,
                decidedAt: new Date(),
            });
            return this.mealIntentRepository.save(intent);
        }
    }
    async getForecast(days = 7) {
        const forecasts = [];
        const today = new Date();
        for (let i = 0; i < days; i++) {
            const date = new Date(today);
            date.setDate(today.getDate() + i);
            const dayForecast = {
                date,
                meals: {},
            };
            for (const meal of Object.values(meal_intent_entity_1.MealType)) {
                const intents = await this.mealIntentRepository.find({
                    where: {
                        date,
                        meal,
                    },
                });
                const yesCount = intents.filter(i => i.value === meal_intent_entity_1.MealIntentValue.YES).length;
                const noCount = intents.filter(i => i.value === meal_intent_entity_1.MealIntentValue.NO).length;
                const totalIntents = intents.length;
                const override = await this.mealOverrideRepository.findOne({
                    where: {
                        date,
                        meal,
                    },
                });
                const overrideDelta = override ? override.delta : 0;
                const forecastCount = Math.round(yesCount + (yesCount * 0.05) + overrideDelta);
                dayForecast.meals[meal] = {
                    yesCount,
                    noCount,
                    totalIntents,
                    forecastCount,
                    overrideDelta,
                };
            }
            forecasts.push(dayForecast);
        }
        return { forecasts };
    }
    async createOverride(overrideDto, createdBy) {
        const existingOverride = await this.mealOverrideRepository.findOne({
            where: {
                date: overrideDto.date,
                meal: overrideDto.meal,
                hostelId: overrideDto.hostelId,
            },
        });
        if (existingOverride) {
            throw new common_1.BadRequestException('Override already exists for this meal');
        }
        const override = this.mealOverrideRepository.create({
            ...overrideDto,
            createdBy,
        });
        return this.mealOverrideRepository.save(override);
    }
    async getStudentIntents(studentId, date) {
        return this.mealIntentRepository.find({
            where: {
                studentId,
                date,
            },
            order: { meal: 'ASC' },
        });
    }
    async getChefBoard(date) {
        const meals = Object.values(meal_intent_entity_1.MealType);
        const chefBoard = {
            date,
            meals: {},
        };
        for (const meal of meals) {
            const intents = await this.mealIntentRepository.find({
                where: {
                    date,
                    meal,
                },
            });
            const yesCount = intents.filter(i => i.value === meal_intent_entity_1.MealIntentValue.YES).length;
            const noCount = intents.filter(i => i.value === meal_intent_entity_1.MealIntentValue.NO).length;
            const totalIntents = intents.length;
            const override = await this.mealOverrideRepository.findOne({
                where: {
                    date,
                    meal,
                },
            });
            const overrideDelta = override ? override.delta : 0;
            const forecastCount = Math.round(yesCount + (yesCount * 0.05) + overrideDelta);
            chefBoard.meals[meal] = {
                yesCount,
                noCount,
                totalIntents,
                forecastCount,
                overrideDelta,
                overrideReason: override?.reason,
            };
        }
        return chefBoard;
    }
    async getQuickActions(studentId) {
        const today = new Date();
        const yesterday = new Date(today);
        yesterday.setDate(today.getDate() - 1);
        const yesterdayIntents = await this.mealIntentRepository.find({
            where: {
                studentId,
                date: yesterday,
            },
        });
        const yesterdayMap = yesterdayIntents.reduce((acc, intent) => {
            acc[intent.meal] = intent.value;
            return acc;
        }, {});
        return {
            allYes: Object.values(meal_intent_entity_1.MealType).reduce((acc, meal) => {
                acc[meal] = meal_intent_entity_1.MealIntentValue.YES;
                return acc;
            }, {}),
            allNo: Object.values(meal_intent_entity_1.MealType).reduce((acc, meal) => {
                acc[meal] = meal_intent_entity_1.MealIntentValue.NO;
                return acc;
            }, {}),
            sameAsYesterday: yesterdayMap,
        };
    }
};
exports.MealsService = MealsService;
exports.MealsService = MealsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(meal_intent_entity_1.MealIntent)),
    __param(1, (0, typeorm_1.InjectRepository)(meal_override_entity_1.MealOverride)),
    __param(2, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __param(3, (0, typeorm_1.InjectRepository)(hostel_entity_1.Hostel)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], MealsService);
//# sourceMappingURL=meals.service.js.map