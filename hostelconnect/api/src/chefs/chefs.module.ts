import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Chef } from './entities/chef.entity';
import { ChefsController } from './chefs.controller';
import { ChefsService } from './chefs.service';

@Module({
  imports: [TypeOrmModule.forFeature([Chef])],
  controllers: [ChefsController],
  providers: [ChefsService],
  exports: [ChefsService],
})
export class ChefsModule {}
