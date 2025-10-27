import { IsString, IsOptional, IsNumber, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class ScanGatePassDto {
  @ApiProperty({ example: 'base64-encoded-qr-token' })
  @IsString()
  qrToken: string;

  @ApiProperty({ example: 'OUT' })
  @IsString()
  eventType: string;

  @ApiProperty({ example: 'device-uuid', required: false })
  @IsOptional()
  @IsUUID()
  deviceId?: string;

  @ApiProperty({ example: 'guard-user-uuid', required: false })
  @IsOptional()
  @IsUUID()
  guardUserId?: string;

  @ApiProperty({ example: 12.9716, required: false })
  @IsOptional()
  @IsNumber()
  latitude?: number;

  @ApiProperty({ example: 77.5946, required: false })
  @IsOptional()
  @IsNumber()
  longitude?: number;
}
