import { Injectable } from '@nestjs/common';

@Injectable()
export class DevicesService {
  async findAll() {
    return { message: 'Devices service - to be implemented' };
  }

  async create(createDeviceDto: any) {
    return { message: 'Device creation - to be implemented' };
  }
}
