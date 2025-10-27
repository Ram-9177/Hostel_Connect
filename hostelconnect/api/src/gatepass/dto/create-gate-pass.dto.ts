import { IsString, IsNotEmpty, IsOptional, IsEnum, IsDateString, IsBoolean } from 'class-validator';
import { GatePassType, GatePassStatus } from '../entities/gate-pass.entity';

export class CreateGatePassDto {
  @IsString()
  @IsNotEmpty()
  studentId: string;

  @IsString()
  @IsNotEmpty()
  reason: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsDateString()
  startTime: string;

  @IsDateString()
  endTime: string;

  @IsEnum(GatePassType)
  @IsOptional()
  type?: GatePassType;

  @IsBoolean()
  @IsOptional()
  isEmergency?: boolean;
}

export class ApproveGatePassDto {
  @IsString()
  @IsNotEmpty()
  reason: string;

  @IsString()
  @IsOptional()
  note?: string;
}

export class RejectGatePassDto {
  @IsString()
  @IsNotEmpty()
  reason: string;
}