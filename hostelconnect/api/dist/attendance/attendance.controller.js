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
exports.AttendanceController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const attendance_service_1 = require("./attendance.service");
let AttendanceController = class AttendanceController {
    constructor(attendanceService) {
        this.attendanceService = attendanceService;
    }
    async createSession(createSessionDto) {
        return this.attendanceService.createSession(createSessionDto);
    }
    async getRoster(id) {
        return this.attendanceService.getRoster(id);
    }
    async scan(scanDto) {
        return this.attendanceService.scanAttendance(scanDto);
    }
    async manual(manualDto) {
        return this.attendanceService.manualAttendance(manualDto);
    }
    async closeSession(id) {
        return this.attendanceService.closeSession(id);
    }
    async getSummary(id) {
        return this.attendanceService.getSummary(id);
    }
    async generateQR(id) {
        const qrToken = this.attendanceService.generateAttendanceQR(id);
        return { qrToken };
    }
};
exports.AttendanceController = AttendanceController;
__decorate([
    (0, common_1.Post)('sessions'),
    (0, swagger_1.ApiOperation)({ summary: 'Create attendance session' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Attendance session created' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid session data' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "createSession", null);
__decorate([
    (0, common_1.Get)('sessions/:id/roster'),
    (0, swagger_1.ApiOperation)({ summary: 'Get attendance roster' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Attendance roster retrieved' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "getRoster", null);
__decorate([
    (0, common_1.Post)('scan'),
    (0, swagger_1.ApiOperation)({ summary: 'Scan attendance QR' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Attendance scanned successfully' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid QR token or duplicate scan' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "scan", null);
__decorate([
    (0, common_1.Post)('manual'),
    (0, swagger_1.ApiOperation)({ summary: 'Manual attendance entry' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Manual attendance recorded' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Invalid manual attendance data' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "manual", null);
__decorate([
    (0, common_1.Post)('sessions/:id/close'),
    (0, swagger_1.ApiOperation)({ summary: 'Close attendance session' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Session closed' }),
    (0, swagger_1.ApiResponse)({ status: 400, description: 'Cannot close session' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "closeSession", null);
__decorate([
    (0, common_1.Get)('sessions/:id/summary'),
    (0, swagger_1.ApiOperation)({ summary: 'Get session summary' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Session summary retrieved' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "getSummary", null);
__decorate([
    (0, common_1.Get)('sessions/:id/qr'),
    (0, swagger_1.ApiOperation)({ summary: 'Generate attendance QR for session' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'QR token generated' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "generateQR", null);
exports.AttendanceController = AttendanceController = __decorate([
    (0, swagger_1.ApiTags)('Attendance'),
    (0, common_1.Controller)('attendance'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [attendance_service_1.AttendanceService])
], AttendanceController);
//# sourceMappingURL=attendance.controller.js.map