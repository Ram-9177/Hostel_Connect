import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AdsController } from './ads.controller';
import { AdsService } from './ads.service';
import { Ad } from './entities/ad.entity';
import { AdEvent } from './entities/ad-event.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Ad, AdEvent])],
  controllers: [AdsController],
  providers: [AdsService],
  exports: [AdsService],
})
export class AdsModule {}
