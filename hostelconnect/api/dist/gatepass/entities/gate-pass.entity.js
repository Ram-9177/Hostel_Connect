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
exports.GatePass = exports.GatePassStatus = exports.GatePassType = void 0;
const typeorm_1 = require("typeorm");
var GatePassType;
(function (GatePassType) {
    GatePassType["OUTING"] = "OUTING";
    GatePassType["EMERGENCY"] = "EMERGENCY";
})(GatePassType || (exports.GatePassType = GatePassType = {}));
var GatePassStatus;
(function (GatePassStatus) {
    GatePassStatus["PENDING"] = "PENDING";
    GatePassStatus["APPROVED"] = "APPROVED";
    GatePassStatus["REJECTED"] = "REJECTED";
    GatePassStatus["CANCELLED"] = "CANCELLED";
    GatePassStatus["EXPIRED"] = "EXPIRED";
})(GatePassStatus || (exports.GatePassStatus = GatePassStatus = {}));
let GatePass = class GatePass {
};
exports.GatePass = GatePass;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], GatePass.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], GatePass.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], GatePass.prototype, "hostelId", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], GatePass.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], GatePass.prototype, "startTime", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], GatePass.prototype, "endTime", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
        default: 'PENDING',
    }),
    __metadata("design:type", String)
], GatePass.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "reason", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "note", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "decisionBy", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "decisionAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "qrTokenHash", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "qrTokenExpiresAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], GatePass.prototype, "isEmergency", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], GatePass.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], GatePass.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)('Student', 'gatePasses'),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", Object)
], GatePass.prototype, "student", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)('Hostel', 'gatePasses'),
    (0, typeorm_1.JoinColumn)({ name: 'hostelId' }),
    __metadata("design:type", Object)
], GatePass.prototype, "hostel", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)('User', 'gatePasses'),
    (0, typeorm_1.JoinColumn)({ name: 'decisionBy' }),
    __metadata("design:type", Object)
], GatePass.prototype, "decisionByUser", void 0);
exports.GatePass = GatePass = __decorate([
    (0, typeorm_1.Entity)('gate_passes')
], GatePass);
//# sourceMappingURL=gate-pass.entity.js.map