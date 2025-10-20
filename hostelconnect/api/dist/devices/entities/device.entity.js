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
exports.Device = exports.DeviceType = void 0;
const typeorm_1 = require("typeorm");
const hostel_entity_1 = require("../../hostels/entities/hostel.entity");
var DeviceType;
(function (DeviceType) {
    DeviceType["KIOSK_SCANNER"] = "KIOSK_SCANNER";
    DeviceType["WARDEN_SCANNER"] = "WARDEN_SCANNER";
    DeviceType["GATE"] = "GATE";
})(DeviceType || (exports.DeviceType = DeviceType = {}));
let Device = class Device {
};
exports.Device = Device;
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)('uuid'),
    __metadata("design:type", String)
], Device.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], Device.prototype, "deviceId", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Device.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'varchar',
    }),
    __metadata("design:type", String)
], Device.prototype, "type", void 0);
__decorate([
    (0, typeorm_1.Column)('uuid'),
    __metadata("design:type", String)
], Device.prototype, "hostelId", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], Device.prototype, "location", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: true }),
    __metadata("design:type", Boolean)
], Device.prototype, "isActive", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Date)
], Device.prototype, "lastSeen", void 0);
__decorate([
    (0, typeorm_1.CreateDateColumn)(),
    __metadata("design:type", Date)
], Device.prototype, "createdAt", void 0);
__decorate([
    (0, typeorm_1.UpdateDateColumn)(),
    __metadata("design:type", Date)
], Device.prototype, "updatedAt", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => hostel_entity_1.Hostel),
    (0, typeorm_1.JoinColumn)({ name: 'hostelId' }),
    __metadata("design:type", hostel_entity_1.Hostel)
], Device.prototype, "hostel", void 0);
exports.Device = Device = __decorate([
    (0, typeorm_1.Entity)('devices')
], Device);
//# sourceMappingURL=device.entity.js.map