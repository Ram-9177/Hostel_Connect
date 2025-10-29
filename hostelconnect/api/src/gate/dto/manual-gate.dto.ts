import { IsIn, IsOptional, IsString } from 'class-validator';

export class ManualGateDto {
  @IsString()
  studentId: string; // can be hall ticket or internal id depending on lookup in service

  @IsIn(['IN', 'OUT'])
  action: 'IN' | 'OUT';

  @IsOptional()
  @IsString()
  location?: string;

  @IsOptional()
  @IsString()
  reason?: string; // e.g., 'Manual override'
}


