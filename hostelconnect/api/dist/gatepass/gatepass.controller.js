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
exports.GatePassController = void 0;
const common_1 = require("@nestjs/common");
const gatepass_service_1 = require("./gatepass.service");
const jwt_auth_guard_1 = require("../auth/jwt-auth.guard");
const create_gate_pass_dto_1 = require("./dto/create-gate-pass.dto");
let GatePassController = class GatePassController {
    constructor(gatePassService) {
        this.gatePassService = gatePassService;
    }
    async createGatePass(createGatePassDto) {
        return this.gatePassService.createGatePass(createGatePassDto);
    }
    async getAllGatePasses() {
        return this.gatePassService.getAllGatePasses();
    }
    async getPendingGatePasses() {
        return this.gatePassService.getPendingGatePasses();
    }
    async getStudentGatePasses(studentId) {
        return this.gatePassService.getStudentGatePasses(studentId);
    }
    async approveGatePass(id, approveDto) {
        return this.gatePassService.approveGatePass(id, approveDto);
    }
    async rejectGatePass(id, rejectDto) {
        return this.gatePassService.rejectGatePass(id, rejectDto);
    }
    async getQRCode(id) {
        return this.gatePassService.generateQRCode(id);
    }
    async useGatePass(id) {
        return this.gatePassService.useGatePass(id);
    }
};
exports.GatePassController = GatePassController;
__decorate([
    (0, common_1.Post)(),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_gate_pass_dto_1.CreateGatePassDto]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "createGatePass", null);
__decorate([
    (0, common_1.Get)(),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "getAllGatePasses", null);
__decorate([
    (0, common_1.Get)('pending'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "getPendingGatePasses", null);
__decorate([
    (0, common_1.Get)('student/:studentId'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('studentId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "getStudentGatePasses", null);
__decorate([
    (0, common_1.Patch)(':id/approve'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_gate_pass_dto_1.ApproveGatePassDto]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "approveGatePass", null);
__decorate([
    (0, common_1.Patch)(':id/reject'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_gate_pass_dto_1.RejectGatePassDto]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "rejectGatePass", null);
__decorate([
    (0, common_1.Get)(':id/qr-code'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "getQRCode", null);
__decorate([
    (0, common_1.Post)(':id/use'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "useGatePass", null);
exports.GatePassController = GatePassController = __decorate([
    (0, common_1.Controller)('gate-pass-applications'),
    __metadata("design:paramtypes", [gatepass_service_1.GatePassService])
], GatePassController);
//# sourceMappingURL=gatepass.controller.js.map