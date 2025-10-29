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
const student_entity_1 = require("../../students/entities/student.entity");
const hostel_entity_1 = require("../../hostels/entities/hostel.entity");
var GatePassType;
(function (GatePassType) {
    GatePassType["REGULAR"] = "REGULAR";
    GatePassType["EMERGENCY"] = "EMERGENCY";
    GatePassType["MEDICAL"] = "MEDICAL";
    GatePassType["FAMILY"] = "FAMILY";
    GatePassType["ACADEMIC"] = "ACADEMIC";
    GatePassType["FOOD"] = "FOOD";
})(GatePassType || (exports.GatePassType = GatePassType = {}));
var GatePassStatus;
(function (GatePassStatus) {
    GatePassStatus["PENDING"] = "PENDING";
    GatePassStatus["APPROVED"] = "APPROVED";
    GatePassStatus["REJECTED"] = "REJECTED";
    GatePassStatus["ACTIVE"] = "ACTIVE";
    GatePassStatus["COMPLETED"] = "COMPLETED";
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
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "firstName", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "lastName", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "hostelId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "roomNumber", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GatePass.prototype, "reason", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text', nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime' }),
    __metadata("design:type", Date)
], GatePass.prototype, "startTime", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime' }),
    __metadata("design:type", Date)
], GatePass.prototype, "endTime", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text', default: GatePassStatus.PENDING }),
    __metadata("design:type", String)
], GatePass.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text', default: GatePassType.REGULAR }),
    __metadata("design:type", String)
], GatePass.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "approvedBy", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "approvedByName", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "approvedAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "rejectedBy", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "rejectedByName", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "rejectedAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "rejectionReason", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "qrCode", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "qrTokenHash", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "qrTokenExpiresAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "lastUsedAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "completedAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "expiredAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], GatePass.prototype, "isEmergency", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "decisionBy", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', nullable: true }),
    __metadata("design:type", Date)
], GatePass.prototype, "decisionAt", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'text', nullable: true }),
    __metadata("design:type", String)
], GatePass.prototype, "note", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], GatePass.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], GatePass.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => student_entity_1.Student),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", student_entity_1.Student)
], GatePass.prototype, "student", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => hostel_entity_1.Hostel, { nullable: true }),
    (0, typeorm_1.JoinColumn)({ name: 'hostelId' }),
    __metadata("design:type", hostel_entity_1.Hostel)
], GatePass.prototype, "hostel", void 0);
exports.GatePass = GatePass = __decorate([
    (0, typeorm_1.Entity)('gate_passes')
], GatePass);
//# sourceMappingURL=gate-pass.entity.js.map