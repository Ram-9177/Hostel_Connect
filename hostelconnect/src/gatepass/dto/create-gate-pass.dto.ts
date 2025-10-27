import { IsEnum, IsString, IsDateString, IsOptional, IsBoolean, IsUUID, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { GatePassType } from '../entities/gate-pass.entity';

export class CreateGatePassDto {
  @ApiProperty({ example: 'student-uuid' })
  @IsUUID()
  studentId: string;

  @ApiProperty({ example: 'hostel-uuid' })
  @IsUUID()
  hostelId: string;

  @ApiProperty({ enum: GatePassType, example: GatePassType.OUTING })
  @IsEnum(GatePassType)
  type: GatePassType;

  @ApiProperty({ example: '2024-01-15T10:00:00Z' })
  @IsDateString()
  startTime: Date;

  @ApiProperty({ example: '2024-01-15T18:00:00Z' })
  @IsDateString()
  endTime: Date;

  @ApiProperty({ example: 'Going to library for study' })
  @IsString()
  @MinLength(10)
  reason: string;

  @ApiProperty({ example: 'Will return by 6 PM', required: false })
  @IsOptional()
  @IsString()
  note?: string;

  @ApiProperty({ example: false, required: false })
  @IsOptional()
  @IsBoolean()
  isEmergency?: boolean;
}

export class ApproveGatePassDto {
  @ApiProperty({ example: true })
  @IsBoolean()
  approved: boolean;

  @ApiProperty({ example: 'Approved for library visit', required: false })
  @IsOptional()
  @IsString()
  reason?: string;
}
