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
exports.ApproveGatePassDto = exports.CreateGatePassDto = void 0;
const class_validator_1 = require("class-validator");
const swagger_1 = require("@nestjs/swagger");
const gate_pass_entity_1 = require("../entities/gate-pass.entity");
class CreateGatePassDto {
}
exports.CreateGatePassDto = CreateGatePassDto;
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'student-uuid' }),
    (0, class_validator_1.IsUUID)(),
    __metadata("design:type", String)
], CreateGatePassDto.prototype, "studentId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'hostel-uuid' }),
    (0, class_validator_1.IsUUID)(),
    __metadata("design:type", String)
], CreateGatePassDto.prototype, "hostelId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ enum: gate_pass_entity_1.GatePassType, example: gate_pass_entity_1.GatePassType.OUTING }),
    (0, class_validator_1.IsEnum)(gate_pass_entity_1.GatePassType),
    __metadata("design:type", String)
], CreateGatePassDto.prototype, "type", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: '2024-01-15T10:00:00Z' }),
    (0, class_validator_1.IsDateString)(),
    __metadata("design:type", Date)
], CreateGatePassDto.prototype, "startTime", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: '2024-01-15T18:00:00Z' }),
    (0, class_validator_1.IsDateString)(),
    __metadata("design:type", Date)
], CreateGatePassDto.prototype, "endTime", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Going to library for study' }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.MinLength)(10),
    __metadata("design:type", String)
], CreateGatePassDto.prototype, "reason", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Will return by 6 PM', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], CreateGatePassDto.prototype, "note", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: false, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsBoolean)(),
    __metadata("design:type", Boolean)
], CreateGatePassDto.prototype, "isEmergency", void 0);
class ApproveGatePassDto {
}
exports.ApproveGatePassDto = ApproveGatePassDto;
__decorate([
    (0, swagger_1.ApiProperty)({ example: true }),
    (0, class_validator_1.IsBoolean)(),
    __metadata("design:type", Boolean)
], ApproveGatePassDto.prototype, "approved", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Approved for library visit', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], ApproveGatePassDto.prototype, "reason", void 0);
//# sourceMappingURL=create-gate-pass.dto.js.map