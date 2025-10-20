"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.dataSourceOptions = void 0;
const typeorm_1 = require("typeorm");
const dotenv_1 = require("dotenv");
const student_entity_1 = require("../students/entities/student.entity");
const user_entity_1 = require("../users/entities/user.entity");
const attendance_session_entity_1 = require("../attendance/entities/attendance-session.entity");
const attendance_check_entity_1 = require("../attendance/entities/attendance-check.entity");
const attendance_roster_entity_1 = require("../attendance/entities/attendance-roster.entity");
const gate_pass_entity_1 = require("../gatepass/entities/gate-pass.entity");
const ad_entity_1 = require("../ads/entities/ad.entity");
const ad_event_entity_1 = require("../ads/entities/ad-event.entity");
const meal_intent_entity_1 = require("../meals/entities/meal-intent.entity");
const meal_override_entity_1 = require("../meals/entities/meal-override.entity");
const hostel_entity_1 = require("../hostels/entities/hostel.entity");
const block_entity_1 = require("../hostels/entities/block.entity");
const room_entity_1 = require("../rooms/entities/room.entity");
const device_entity_1 = require("../devices/entities/device.entity");
(0, dotenv_1.config)();
exports.dataSourceOptions = {
    type: 'sqlite',
    database: process.env.DB_DATABASE || 'hostelconnect.db',
    entities: [
        student_entity_1.Student,
        user_entity_1.User,
        attendance_session_entity_1.AttendanceSession,
        attendance_check_entity_1.AttendanceCheck,
        attendance_roster_entity_1.AttendanceRoster,
        gate_pass_entity_1.GatePass,
        ad_entity_1.Ad,
        ad_event_entity_1.AdEvent,
        meal_intent_entity_1.MealIntent,
        meal_override_entity_1.MealOverride,
        hostel_entity_1.Hostel,
        block_entity_1.Block,
        room_entity_1.Room,
        device_entity_1.Device,
    ],
    synchronize: true,
    logging: process.env.NODE_ENV === 'development',
};
const dataSource = new typeorm_1.DataSource(exports.dataSourceOptions);
exports.default = dataSource;
//# sourceMappingURL=data-source.js.map