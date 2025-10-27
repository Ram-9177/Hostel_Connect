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
let GateEvent = class GateEvent {
};
exports.GateEvent = GateEvent;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], GateEvent.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "gatePassId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GateEvent.prototype, "studentId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], GateEvent.prototype, "studentName", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: ['IN', 'OUT', 'UNKNOWN'],
        default: 'UNKNOWN'
    }),
    __metadata("design:type", String)
], GateEvent.prototype, "eventType", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], GateEvent.prototype, "timestamp", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 'Main Gate' }),
    __metadata("design:type", String)
], GateEvent.prototype, "location", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: ['SUCCESS', 'FAILED'],
        default: 'SUCCESS'
    }),
    __metadata("design:type", String)
], GateEvent.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "qrCode", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "reason", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "securityGuardId", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], GateEvent.prototype, "securityGuardName", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], GateEvent.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], GateEvent.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => gate_pass_entity_1.GatePass, { nullable: true }),
    (0, typeorm_1.JoinColumn)({ name: 'gatePassId' }),
    __metadata("design:type", gate_pass_entity_1.GatePass)
], GateEvent.prototype, "gatePass", void 0);
exports.GateEvent = GateEvent = __decorate([
    (0, typeorm_1.Entity)('gate_events')
], GateEvent);
//# sourceMappingURL=gate-event.entity.js.map