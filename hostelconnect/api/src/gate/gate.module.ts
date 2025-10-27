import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GateController } from './gate.controller';
import { GateService } from './gate.service';
import { GateEvent } from './entities/gate-event.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([GateEvent, GatePass])
  ],
  controllers: [GateController],
  providers: [GateService],
  exports: [GateService]
})
export class GateModule {}