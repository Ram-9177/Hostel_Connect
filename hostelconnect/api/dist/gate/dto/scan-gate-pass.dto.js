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
exports.ScanGatePassDto = void 0;
const class_validator_1 = require("class-validator");
const swagger_1 = require("@nestjs/swagger");
class ScanGatePassDto {
}
exports.ScanGatePassDto = ScanGatePassDto;
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'base64-encoded-qr-token' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], ScanGatePassDto.prototype, "qrToken", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'OUT' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], ScanGatePassDto.prototype, "eventType", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'device-uuid', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsUUID)(),
    __metadata("design:type", String)
], ScanGatePassDto.prototype, "deviceId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'guard-user-uuid', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsUUID)(),
    __metadata("design:type", String)
], ScanGatePassDto.prototype, "guardUserId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 12.9716, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    __metadata("design:type", Number)
], ScanGatePassDto.prototype, "latitude", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 77.5946, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    __metadata("design:type", Number)
], ScanGatePassDto.prototype, "longitude", void 0);
//# sourceMappingURL=scan-gate-pass.dto.js.map