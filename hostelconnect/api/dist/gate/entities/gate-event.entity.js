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
exports.GateEvent = void 0;
const typeorm_1 = require("typeorm");
const gate_pass_entity_1 = require("../../gatepass/entities/gate-pass.entity");
const student_entity_1 = require("../../students/entities/student.entity");
const device_entity_1 = require("../../devices/entities/device.entity");
const user_entity_1 = require("../../users/entities/user.entity");
let GateEvent = class GateEvent {
};
exports.GateEvent = GateEvent;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], GateEvent.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], GateEvent.prototype, "passId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], GateEvent.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], GateEvent.prototype, "eventType", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], GateEvent.prototype, "method", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "deviceId", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid', { nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "guardUserId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], GateEvent.prototype, "timestamp", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Number)
], GateEvent.prototype, "latitude", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Number)
], GateEvent.prototype, "longitude", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], GateEvent.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => gate_pass_entity_1.GatePass),
    (0, typeorm_1.JoinColumn)({ name: 'passId' }),
    __metadata("design:type", gate_pass_entity_1.GatePass)
], GateEvent.prototype, "pass", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => student_entity_1.Student),
    (0, typeorm_1.JoinColumn)({ name: 'studentId' }),
    __metadata("design:type", student_entity_1.Student)
], GateEvent.prototype, "student", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => device_entity_1.Device),
    (0, typeorm_1.JoinColumn)({ name: 'deviceId' }),
    __metadata("design:type", device_entity_1.Device)
], GateEvent.prototype, "device", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User),
    (0, typeorm_1.JoinColumn)({ name: 'guardUserId' }),
    __metadata("design:type", user_entity_1.User)
], GateEvent.prototype, "guardUser", void 0);
exports.GateEvent = GateEvent = __decorate([
    (0, typeorm_1.Entity)('gate_events')
], GateEvent);
//# sourceMappingURL=gate-event.entity.js.map