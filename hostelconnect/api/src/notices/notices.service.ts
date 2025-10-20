import { Injectable } from '@nestjs/common';

@Injectable()
export class NoticesService {
  async findAll() {
    return { message: 'Notices service - to be implemented' };
  }

  async create(createDto: any) {
    return { message: 'Notice creation - to be implemented' };
  }
}
