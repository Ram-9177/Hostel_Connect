import { Injectable } from '@nestjs/common';

@Injectable()
export class TicketsService {
  async findAll() {
    return { message: 'Tickets service - to be implemented' };
  }

  async create(createDto: any) {
    return { message: 'Ticket creation - to be implemented' };
  }
}
