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
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const gate_service_1 = require("./gate.service");
const scan_gate_pass_dto_1 = require("./dto/scan-gate-pass.dto");
let GateController = class GateController {
    constructor(gateService) {
        this.gateService = gateService;
    }
    async scan(scanDto) {
        return this.gateService.scanGatePass(scanDto);
    }
    async getGatePassEvents(passId) {
        return this.gateService.getGatePassEvents(passId);
    }
    async getStudentGateEvents(studentId) {
        return this.gateService.getStudentGateEvents(studentId);
    }
};
exports.GateController = GateController;
__decorate([
    (0, common_1.Post)('scan'),
    (0, swagger_1.ApiOperation)({ summary: 'Scan gate pass QR code' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate scan processed successfully' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid QR token or gate pass' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [scan_gate_pass_dto_1.ScanGatePassDto]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "scan", null);
__decorate([
    (0, common_1.Get)('pass/:passId/events'),
    (0, swagger_1.ApiOperation)({ summary: 'Get gate pass events' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass events retrieved' }),
    __param(0, (0, common_1.Param)('passId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getGatePassEvents", null);
__decorate([
    (0, common_1.Get)('student/:studentId/events'),
    (0, swagger_1.ApiOperation)({ summary: 'Get student gate events' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Student gate events retrieved' }),
    __param(0, (0, common_1.Param)('studentId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], GateController.prototype, "getStudentGateEvents", null);
exports.GateController = GateController = __decorate([
    (0, swagger_1.ApiTags)('Gate'),
    (0, common_1.Controller)('gate'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [gate_service_1.GateService])
], GateController);
//# sourceMappingURL=gate.controller.js.map