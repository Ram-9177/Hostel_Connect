import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GateController } from './gate.controller';
import { GateService } from './gate.service';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { QRTokenService } from '../common/utils/qr-token.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([GateEvent, GatePass]),
  ],
  controllers: [GateController],
  providers: [GateService, QRTokenService],
  exports: [GateService],
})
export class GateModule {}
