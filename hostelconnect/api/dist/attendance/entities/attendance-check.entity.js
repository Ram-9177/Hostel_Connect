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
exports.AttendanceCheck = exports.AttendanceCheckMethod = void 0;
const typeorm_1 = require("typeorm");
const attendance_session_entity_1 = require("./attendance-session.entity");
const student_entity_1 = require("../../students/entities/student.entity");
const user_entity_1 = require("../../users/entities/user.entity");
const device_entity_1 = require("../../devices/entities/device.entity");
var AttendanceCheckMethod;
(function (AttendanceCheckMethod) {
    AttendanceCheckMethod["STUDENT_QR"] = "STUDENT_QR";
    AttendanceCheckMethod["MANUAL"] = "MANUAL";
    AttendanceCheckMethod["GATE"] = "GATE";
})(AttendanceCheckMethod || (exports.AttendanceCheckMethod = AttendanceCheckMethod = {}));
let AttendanceCheck = class AttendanceCheck {
};
exports.AttendanceCheck = AttendanceCheck;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "sessionId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "method", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], AttendanceCheck.prototype, "timestamp", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { nullable: true }),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "wardenId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { nullable: true }),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "deviceId", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "reason", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], AttendanceCheck.prototype, "photoUrl", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], AttendanceCheck.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => attendance_session_entity_1.AttendanceSession),
    (0, typeorm_1.JoinColumn)({ name: 'sessionId' }),
    __metadata("design:type", attendance_session_entity_1.AttendanceSession)
], AttendanceCheck.prototype, "session", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => student_entity_1.Student),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", student_entity_1.Student)
], AttendanceCheck.prototype, "student", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User),
    (0, typeorm_1.JoinColumn)({ name: 'wardenId' }),
    __metadata("design:type", user_entity_1.User)
], AttendanceCheck.prototype, "warden", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => device_entity_1.Device),
    (0, typeorm_1.JoinColumn)({ name: 'deviceId' }),
    __metadata("design:type", device_entity_1.Device)
], AttendanceCheck.prototype, "device", void 0);
exports.AttendanceCheck = AttendanceCheck = __decorate([
    (0, typeorm_1.Entity)('attendance_checks')
], AttendanceCheck);
//# sourceMappingURL=attendance-check.entity.js.map