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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DeviceService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const device_entity_1 = require("./entities/device.entity");
const firebase_service_1 = require("./firebase.service");
let DeviceService = class DeviceService {
    constructor(deviceRepository, firebaseService) {
        this.deviceRepository = deviceRepository;
        this.firebaseService = firebaseService;
    }
    async registerDevice(userId, deviceData) {
        let device = await this.deviceRepository.findOne({
            where: { deviceToken: deviceData.deviceToken },
        });
        if (device) {
            device.userId = userId;
            device.deviceType = deviceData.deviceType;
            device.deviceName = deviceData.deviceName;
            device.appVersion = deviceData.appVersion;
            device.osVersion = deviceData.osVersion;
            device.lastActiveAt = new Date();
        }
        else {
            device = this.deviceRepository.create({
                userId,
                deviceToken: deviceData.deviceToken,
                deviceType: deviceData.deviceType,
                deviceName: deviceData.deviceName,
                appVersion: deviceData.appVersion,
                osVersion: deviceData.osVersion,
                isActive: true,
                lastActiveAt: new Date(),
            });
        }
        const savedDevice = await this.deviceRepository.save(device);
        await this.firebaseService.subscribeToTopic(deviceData.deviceToken, `user_${userId}`);
        return savedDevice;
    }
    async unregisterDevice(deviceToken) {
        const device = await this.deviceRepository.findOne({
            where: { deviceToken },
        });
        if (device) {
            await this.firebaseService.unsubscribeFromTopic(deviceToken, `user_${device.userId}`);
            device.isActive = false;
            await this.deviceRepository.save(device);
        }
    }
    async getDevicesForUser(userId) {
        return this.deviceRepository.find({
            where: { userId, isActive: true },
            order: { lastActiveAt: 'DESC' },
        });
    }
    async getDeviceTokensForUser(userId) {
        const devices = await this.getDevicesForUser(userId);
        return devices.map(device => device.deviceToken);
    }
    async getDevicesForRole(role) {
        return this.deviceRepository
            .createQueryBuilder('device')
            .leftJoin('users', 'user', 'user.id = device.userId')
            .where('user.role = :role', { role })
            .andWhere('device.isActive = :isActive', { isActive: true })
            .getMany();
    }
    async getDeviceTokensForRole(role) {
        const devices = await this.getDevicesForRole(role);
        return devices.map(device => device.deviceToken);
    }
    async updateDeviceLastActive(deviceToken) {
        await this.deviceRepository.update({ deviceToken }, { lastActiveAt: new Date() });
    }
    async deactivateInactiveDevices(daysInactive = 30) {
        const cutoffDate = new Date();
        cutoffDate.setDate(cutoffDate.getDate() - daysInactive);
        const result = await this.deviceRepository.update({ lastActiveAt: new Date(cutoffDate), isActive: true }, { isActive: false });
        return result.affected || 0;
    }
    async getDeviceStats() {
        const totalDevices = await this.deviceRepository.count();
        const activeDevices = await this.deviceRepository.count({
            where: { isActive: true },
        });
        const devicesByType = await this.deviceRepository
            .createQueryBuilder('device')
            .select('device.deviceType', 'type')
            .addSelect('COUNT(*)', 'count')
            .where('device.isActive = :isActive', { isActive: true })
            .groupBy('device.deviceType')
            .getRawMany();
        const devicesByRole = await this.deviceRepository
            .createQueryBuilder('device')
            .leftJoin('users', 'user', 'user.id = device.userId')
            .select('user.role', 'role')
            .addSelect('COUNT(*)', 'count')
            .where('device.isActive = :isActive', { isActive: true })
            .groupBy('user.role')
            .getRawMany();
        return {
            totalDevices,
            activeDevices,
            devicesByType: devicesByType.reduce((acc, item) => {
                acc[item.type] = parseInt(item.count);
                return acc;
            }, {}),
            devicesByRole: devicesByRole.reduce((acc, item) => {
                acc[item.role] = parseInt(item.count);
                return acc;
            }, {}),
        };
    }
};
exports.DeviceService = DeviceService;
exports.DeviceService = DeviceService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(device_entity_1.Device)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        firebase_service_1.FirebaseService])
], DeviceService);
//# sourceMappingURL=device.service.js.map