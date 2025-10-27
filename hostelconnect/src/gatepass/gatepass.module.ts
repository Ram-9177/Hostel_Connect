import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GatePassController } from './gatepass.controller';
import { GatePassService } from './gatepass.service';
import { GatePass } from './entities/gate-pass.entity';
import { AdEvent } from '../ads/entities/ad-event.entity';
import { QRTokenService } from '../common/utils/qr-token.service';
import { UsersModule } from '../users/users.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([GatePass, AdEvent]),
    UsersModule,
  ],
  controllers: [GatePassController],
  providers: [GatePassService, QRTokenService],
  exports: [GatePassService],
})
export class GatePassModule {}
