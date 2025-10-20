import { IsBoolean, IsString, IsOptional } from 'class-validator';

export class ApproveGatePassDto {
  @IsBoolean()
  approved: boolean;

  @IsString()
  @IsOptional()
  reason?: string;
}
