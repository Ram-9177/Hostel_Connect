import { IsString, IsNotEmpty, IsOptional, IsEnum } from 'class-validator';

export class ScanGatePassDto {
  @IsString()
  @IsNotEmpty()
  qrCode: string;

  @IsString()
  @IsOptional()
  location?: string;

  @IsString()
  @IsOptional()
  securityGuardId?: string;

  @IsString()
  @IsOptional()
  securityGuardName?: string;
}