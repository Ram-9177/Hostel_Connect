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
exports.AttendanceRoster = void 0;
const typeorm_1 = require("typeorm");
const attendance_session_entity_1 = require("./attendance-session.entity");
const student_entity_1 = require("../../students/entities/student.entity");
const room_entity_1 = require("../../rooms/entities/room.entity");
let AttendanceRoster = class AttendanceRoster {
};
exports.AttendanceRoster = AttendanceRoster;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], AttendanceRoster.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceRoster.prototype, "sessionId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceRoster.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], AttendanceRoster.prototype, "roomId", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], AttendanceRoster.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => attendance_session_entity_1.AttendanceSession),
    (0, typeorm_1.JoinColumn)({ name: 'sessionId' }),
    __metadata("design:type", attendance_session_entity_1.AttendanceSession)
], AttendanceRoster.prototype, "session", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => student_entity_1.Student),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", student_entity_1.Student)
], AttendanceRoster.prototype, "student", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => room_entity_1.Room),
    (0, typeorm_1.JoinColumn)({ name: 'roomId' }),
    __metadata("design:type", room_entity_1.Room)
], AttendanceRoster.prototype, "room", void 0);
exports.AttendanceRoster = AttendanceRoster = __decorate([
    (0, typeorm_1.Entity)('attendance_roster')
], AttendanceRoster);
//# sourceMappingURL=attendance-roster.entity.js.map