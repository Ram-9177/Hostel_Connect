"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AttendanceModule = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const attendance_controller_1 = require("./attendance.controller");
const attendance_service_1 = require("./attendance.service");
const attendance_session_entity_1 = require("./entities/attendance-session.entity");
const attendance_roster_entity_1 = require("./entities/attendance-roster.entity");
const attendance_check_entity_1 = require("./entities/attendance-check.entity");
const student_entity_1 = require("../students/entities/student.entity");
const room_entity_1 = require("../rooms/entities/room.entity");
const qr_token_service_1 = require("../common/utils/qr-token.service");
let AttendanceModule = class AttendanceModule {
};
exports.AttendanceModule = AttendanceModule;
exports.AttendanceModule = AttendanceModule = __decorate([
    (0, common_1.Module)({
        imports: [
            typeorm_1.TypeOrmModule.forFeature([
                attendance_session_entity_1.AttendanceSession,
                attendance_roster_entity_1.AttendanceRoster,
                attendance_check_entity_1.AttendanceCheck,
                student_entity_1.Student,
                room_entity_1.Room,
            ]),
        ],
        controllers: [attendance_controller_1.AttendanceController],
        providers: [attendance_service_1.AttendanceService, qr_token_service_1.QRTokenService],
        exports: [attendance_service_1.AttendanceService],
    })
], AttendanceModule);
//# sourceMappingURL=attendance.module.js.map