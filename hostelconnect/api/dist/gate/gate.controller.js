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
exports.GateController = void 0;
const common_1 = require("@nestjs/common");
const gate_service_1 = require("./gate.service");
const jwt_auth_guard_1 = require("../auth/jwt-auth.guard");
const scan_gate_pass_dto_1 = require("./dto/scan-gate-pass.dto");
const manual_gate_dto_1 = require("./dto/manual-gate.dto");
let GateController = class GateController {
    constructor(gateService) {
        this.gateService = gateService;
    }
    async scanGatePass(scanDto) {
        return this.gateService.scanGatePass(scanDto);
    }
    async manualGate(dto) {
        return this.gateService.manualGateEvent(dto);
    }
    async getGateEvents() {
        return this.gateService.getGateEvents();
    }
    async getTodaySummary() {
        return this.gateService.getTodaySummary();
    }
    async getTodayEvents() {
        return this.gateService.getTodayEvents();
    }
    async getStudentEvents(studentId) {
        return this.gateService.getStudentEvents(studentId);
    }
    async getGateStats() {
        return this.gateService.getGateStats();
    }
    async validateGatePass(body) {
        return this.gateService.validateGatePass(body.qrCode);
    }
};
exports.GateController = GateController;
__decorate([
    (0, common_1.Post)('scan'),
    (0, common_1.HttpCode)(common_1.HttpStatus.OK),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [scan_gate_pass_dto_1.ScanGatePassDto]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "scanGatePass", null);
__decorate([
    (0, common_1.Post)('manual'),
    (0, common_1.HttpCode)(common_1.HttpStatus.OK),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [manual_gate_dto_1.ManualGateDto]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "manualGate", null);
__decorate([
    (0, common_1.Get)('events'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getGateEvents", null);
__decorate([
    (0, common_1.Get)('stats/today'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getTodaySummary", null);
__decorate([
    (0, common_1.Get)('events/today'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getTodayEvents", null);
__decorate([
    (0, common_1.Get)('events/student/:studentId'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('studentId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getStudentEvents", null);
__decorate([
    (0, common_1.Get)('stats'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getGateStats", null);
__decorate([
    (0, common_1.Post)('validate'),
    (0, common_1.HttpCode)(common_1.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "validateGatePass", null);
exports.GateController = GateController = __decorate([
    (0, common_1.Controller)('gate'),
    __metadata("design:paramtypes", [gate_service_1.GateService])
], GateController);
//# sourceMappingURL=gate.controller.js.map