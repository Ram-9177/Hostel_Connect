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
exports.AttendanceSession = void 0;
const typeorm_1 = require("typeorm");
const hostel_entity_1 = require("../../hostels/entities/hostel.entity");
let AttendanceSession = class AttendanceSession {
};
exports.AttendanceSession = AttendanceSession;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], AttendanceSession.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceSession.prototype, "hostelId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { array: true }),
    __metadata("design:type", Array)
], AttendanceSession.prototype, "wingIds", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'date' }),
    __metadata("design:type", Date)
], AttendanceSession.prototype, "date", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], AttendanceSession.prototype, "slot", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], AttendanceSession.prototype, "startTime", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], AttendanceSession.prototype, "endTime", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], AttendanceSession.prototype, "mode", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], AttendanceSession.prototype, "nonce", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
        default: 'ACTIVE',
    }),
    __metadata("design:type", String)
], AttendanceSession.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], AttendanceSession.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], AttendanceSession.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => hostel_entity_1.Hostel),
    (0, typeorm_1.JoinColumn)({ name: 'hostelId' }),
    __metadata("design:type", hostel_entity_1.Hostel)
], AttendanceSession.prototype, "hostel", void 0);
exports.AttendanceSession = AttendanceSession = __decorate([
    (0, typeorm_1.Entity)('attendance_sessions')
], AttendanceSession);
//# sourceMappingURL=attendance-session.entity.js.map