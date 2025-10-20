import { Injectable } from '@nestjs/common';

@Injectable()
export class RoomsService {
  async getMap() {
    return { message: 'Room map - to be implemented' };
  }

  async allocate(allocateDto: any) {
    return { message: 'Room allocation - to be implemented' };
  }

  async transfer(transferDto: any) {
    return { message: 'Room transfer - to be implemented' };
  }

  async swap(swapDto: any) {
    return { message: 'Room swap - to be implemented' };
  }
}
