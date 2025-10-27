import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Chef } from './entities/chef.entity';

@Injectable()
export class ChefsService {
  constructor(
    @InjectRepository(Chef)
    private readonly chefRepository: Repository<Chef>,
  ) {}

  async findAll(): Promise<Chef[]> {
    return this.chefRepository.find();
  }

  async findOne(id: string): Promise<Chef> {
    return this.chefRepository.findOne({ where: { id } });
  }

  async findByEmail(email: string): Promise<Chef> {
    return this.chefRepository.findOne({ where: { email } });
  }

  async create(chefData: Partial<Chef>): Promise<Chef> {
    const chef = this.chefRepository.create(chefData);
    return this.chefRepository.save(chef);
  }

  async update(id: string, chefData: Partial<Chef>): Promise<Chef> {
    await this.chefRepository.update(id, chefData);
    return this.findOne(id);
  }

  async remove(id: string): Promise<void> {
    await this.chefRepository.delete(id);
  }
}
