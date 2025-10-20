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
exports.MealsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const meals_service_1 = require("./meals.service");
let MealsController = class MealsController {
    constructor(mealsService) {
        this.mealsService = mealsService;
    }
    async openIntents(openDto) {
        return this.mealsService.openIntents(openDto);
    }
    async setDayIntents(intentsDto, req) {
        return this.mealsService.setDayIntents(intentsDto, req.user.id);
    }
    async updateIntent(updateDto, req) {
        return this.mealsService.updateIntent(updateDto, req.user.id);
    }
    async getForecast(days) {
        return this.mealsService.getForecast(days ? parseInt(days.toString()) : 7);
    }
    async createOverride(overrideDto, req) {
        return this.mealsService.createOverride(overrideDto, req.user.id);
    }
    async getStudentIntents(date, req) {
        return this.mealsService.getStudentIntents(req.user.id, new Date(date));
    }
    async getChefBoard(date) {
        return this.mealsService.getChefBoard(new Date(date));
    }
    async getQuickActions(req) {
        return this.mealsService.getQuickActions(req.user.id);
    }
};
exports.MealsController = MealsController;
__decorate([
    (0, common_1.Post)('intents/open'),
    (0, swagger_1.ApiOperation)({ summary: 'Open meal intents for day' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Meal intents opened' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "openIntents", null);
__decorate([
    (0, common_1.Post)('intent/day'),
    (0, swagger_1.ApiOperation)({ summary: 'Set meal intents for day' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Meal intents set' }),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "setDayIntents", null);
__decorate([
    (0, common_1.Patch)('intent'),
    (0, swagger_1.ApiOperation)({ summary: 'Update single meal intent' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Meal intent updated' }),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "updateIntent", null);
__decorate([
    (0, common_1.Get)('forecast'),
    (0, swagger_1.ApiOperation)({ summary: 'Get meal forecast' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Meal forecast retrieved' }),
    __param(0, (0, common_1.Query)('days')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "getForecast", null);
__decorate([
    (0, common_1.Post)('override'),
    (0, swagger_1.ApiOperation)({ summary: 'Create meal override (Warden Head only)' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Meal override created' }),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "createOverride", null);
__decorate([
    (0, common_1.Get)('intents'),
    (0, swagger_1.ApiOperation)({ summary: 'Get student meal intents for date' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Student intents retrieved' }),
    __param(0, (0, common_1.Query)('date')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "getStudentIntents", null);
__decorate([
    (0, common_1.Get)('chef-board'),
    (0, swagger_1.ApiOperation)({ summary: 'Get chef board for date' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Chef board retrieved' }),
    __param(0, (0, common_1.Query)('date')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "getChefBoard", null);
__decorate([
    (0, common_1.Get)('quick-actions'),
    (0, swagger_1.ApiOperation)({ summary: 'Get quick actions for meal intents' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Quick actions retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], MealsController.prototype, "getQuickActions", null);
exports.MealsController = MealsController = __decorate([
    (0, swagger_1.ApiTags)('Meals'),
    (0, common_1.Controller)('meals'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [meals_service_1.MealsService])
], MealsController);
//# sourceMappingURL=meals.controller.js.map