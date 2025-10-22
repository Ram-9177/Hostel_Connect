import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Device } from './entities/device.entity';
import { FirebaseService } from './firebase.service';

export interface DeviceRegistrationDto {
  deviceToken: string;
  deviceType: 'ios' | 'android' | 'web';
  deviceName?: string;
  appVersion?: string;
  osVersion?: string;
}

@Injectable()
export class DeviceService {
  constructor(
    @InjectRepository(Device)
    private readonly deviceRepository: Repository<Device>,
    private readonly firebaseService: FirebaseService,
  ) {}

  async registerDevice(userId: string, deviceData: DeviceRegistrationDto): Promise<Device> {
    // Check if device already exists
    let device = await this.deviceRepository.findOne({
      where: { deviceToken: deviceData.deviceToken },
    });

    if (device) {
      // Update existing device
      device.userId = userId;
      device.deviceType = deviceData.deviceType;
      device.deviceName = deviceData.deviceName;
      device.appVersion = deviceData.appVersion;
      device.osVersion = deviceData.osVersion;
      device.lastActiveAt = new Date();
    } else {
      // Create new device
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

    // Subscribe to user-specific topic
    await this.firebaseService.subscribeToTopic(
      deviceData.deviceToken,
      `user_${userId}`,
    );

    // Subscribe to role-based topic (if we have user role info)
    // This would need to be implemented based on your user role system

    return savedDevice;
  }

  async unregisterDevice(deviceToken: string): Promise<void> {
    const device = await this.deviceRepository.findOne({
      where: { deviceToken },
    });

    if (device) {
      // Unsubscribe from topics
      await this.firebaseService.unsubscribeFromTopic(
        deviceToken,
        `user_${device.userId}`,
      );

      // Mark device as inactive
      device.isActive = false;
      await this.deviceRepository.save(device);
    }
  }

  async getDevicesForUser(userId: string): Promise<Device[]> {
    return this.deviceRepository.find({
      where: { userId, isActive: true },
      order: { lastActiveAt: 'DESC' },
    });
  }

  async getDeviceTokensForUser(userId: string): Promise<string[]> {
    const devices = await this.getDevicesForUser(userId);
    return devices.map(device => device.deviceToken);
  }

  async getDevicesForRole(role: string): Promise<Device[]> {
    // This would need to be implemented based on your user role system
    // You might need to join with users table to get devices by role
    return this.deviceRepository
      .createQueryBuilder('device')
      .leftJoin('users', 'user', 'user.id = device.userId')
      .where('user.role = :role', { role })
      .andWhere('device.isActive = :isActive', { isActive: true })
      .getMany();
  }

  async getDeviceTokensForRole(role: string): Promise<string[]> {
    const devices = await this.getDevicesForRole(role);
    return devices.map(device => device.deviceToken);
  }

  async updateDeviceLastActive(deviceToken: string): Promise<void> {
    await this.deviceRepository.update(
      { deviceToken },
      { lastActiveAt: new Date() },
    );
  }

  async deactivateInactiveDevices(daysInactive: number = 30): Promise<number> {
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - daysInactive);

    const result = await this.deviceRepository.update(
      { lastActiveAt: new Date(cutoffDate), isActive: true },
      { isActive: false },
    );

    return result.affected || 0;
  }

  async getDeviceStats(): Promise<{
    totalDevices: number;
    activeDevices: number;
    devicesByType: { [key: string]: number };
    devicesByRole: { [key: string]: number };
  }> {
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
}
