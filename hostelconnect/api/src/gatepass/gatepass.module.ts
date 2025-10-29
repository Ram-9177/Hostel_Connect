import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GatePassController } from './gatepass.controller';
import { GatePassService } from './gatepass.service';
import { GatePass } from './entities/gate-pass.entity';
import { Student } from '../students/entities/student.entity';
import { SocketModule } from '../socket/socket.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([GatePass, Student]),
    ...(process.env.ENABLE_SOCKETS === 'true' ? [forwardRef(() => SocketModule)] : []),
  ],
  controllers: [GatePassController],
  providers: [GatePassService],
  exports: [GatePassService]
})
export class GatePassModule {}