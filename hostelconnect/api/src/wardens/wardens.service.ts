import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Warden } from './entities/warden.entity';

@Injectable()
export class WardensService {
  constructor(
    @InjectRepository(Warden)
    private readonly wardenRepository: Repository<Warden>,
  ) {}

  async findAll(): Promise<Warden[]> {
    return this.wardenRepository.find();
  }

  async findOne(id: string): Promise<Warden> {
    return this.wardenRepository.findOne({ where: { id } });
  }

  async findByEmail(email: string): Promise<Warden> {
    return this.wardenRepository.findOne({ where: { email } });
  }

  async create(wardenData: Partial<Warden>): Promise<Warden> {
    const warden = this.wardenRepository.create(wardenData);
    return this.wardenRepository.save(warden);
  }

  async update(id: string, wardenData: Partial<Warden>): Promise<Warden> {
    await this.wardenRepository.update(id, wardenData);
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    await this.wardenRepository.delete(id);
  }
}
