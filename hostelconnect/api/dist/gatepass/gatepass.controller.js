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
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const gatepass_service_1 = require("./gatepass.service");
const create_gate_pass_dto_1 = require("./dto/create-gate-pass.dto");
const approve_gate_pass_dto_1 = require("./dto/approve-gate-pass.dto");
let GatePassController = class GatePassController {
    constructor(gatePassService) {
        this.gatePassService = gatePassService;
    }
    async create(createDto, req) {
        return this.gatePassService.create(createDto, req.user.id);
    }
    async findAll(req) {
        const studentId = req.user.role === 'STUDENT' ? req.user.id : undefined;
        return this.gatePassService.findAll(studentId);
    }
    async findOne(id) {
        return this.gatePassService.findById(id);
    }
    async approve(id, approveDto, req) {
        return this.gatePassService.approve(id, approveDto, req.user.id);
    }
    async cancel(id, req) {
        return this.gatePassService.cancel(id, req.user.id);
    }
    async getQRToken(id) {
        return this.gatePassService.getQRToken(id);
    }
    async unlockQRTokenAfterAd(id, req) {
        return this.gatePassService.unlockQRTokenAfterAd(id, req.user.id);
    }
    async markAdWatched(id, body, req) {
        await this.gatePassService.markAdWatched(req.user.id, body.adId, 'gatepass');
        return { message: 'Ad marked as watched' };
    }
    async refreshQRToken(id) {
        return this.gatePassService.refreshQRToken(id);
    }
};
exports.GatePassController = GatePassController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new gate pass request' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Gate pass created successfully' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid gate pass data' }),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_gate_pass_dto_1.CreateGatePassDto, Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get gate pass requests' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass list retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get gate pass by ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass retrieved' }),
    (0, swagger_1.ApiResponse)({ status: 404, description: 'Gate pass not found' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id/approve'),
    (0, swagger_1.ApiOperation)({ summary: 'Approve or reject gate pass (Warden only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass decision updated' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid decision' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, approve_gate_pass_dto_1.ApproveGatePassDto, Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "approve", null);
__decorate([
    (0, common_1.Patch)(':id/cancel'),
    (0, swagger_1.ApiOperation)({ summary: 'Cancel gate pass (Student only)' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass cancelled' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Cannot cancel gate pass' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "cancel", null);
__decorate([
    (0, common_1.Get)(':id/qr'),
    (0, swagger_1.ApiOperation)({ summary: 'Get QR token for approved gate pass' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'QR token retrieved' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'QR token not available or ad required' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "getQRToken", null);
__decorate([
    (0, common_1.Post)(':id/qr/unlock'),
    (0, swagger_1.ApiOperation)({ summary: 'Unlock QR token after watching ad' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'QR token unlocked' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Cannot unlock QR token' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "unlockQRTokenAfterAd", null);
__decorate([
    (0, common_1.Post)(':id/ad/watched'),
    (0, swagger_1.ApiOperation)({ summary: 'Mark ad as watched for gate pass' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Ad marked as watched' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object, Object]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "markAdWatched", null);
__decorate([
    (0, common_1.Post)(':id/qr/refresh'),
    (0, swagger_1.ApiOperation)({ summary: 'Refresh QR token for approved gate pass' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'QR token refreshed' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Cannot refresh QR token' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GatePassController.prototype, "refreshQRToken", null);
exports.GatePassController = GatePassController = __decorate([
    (0, swagger_1.ApiTags)('Gate Pass'),
    (0, common_1.Controller)('gate-pass'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [gatepass_service_1.GatePassService])
], GatePassController);
//# sourceMappingURL=gatepass.controller.js.map