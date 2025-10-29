import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StudentsController } from './students.controller';
import { StudentsService } from './students.service';
import { AuthModule } from '../auth/auth.module';
import { Student } from './entities/student.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Student]),
    AuthModule,
  ],
  controllers: [StudentsController],
  providers: [StudentsService],
  exports: [StudentsService]
})
export class StudentsModule {}