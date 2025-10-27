import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Warden } from './entities/warden.entity';
import { WardensController } from './wardens.controller';
import { WardensService } from './wardens.service';

@Module({
  imports: [TypeOrmModule.forFeature([Warden])],
  controllers: [WardensController],
  providers: [WardensService],
  exports: [WardensService],
})
export class WardensModule {}
