import { IsEnum, IsString, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { AdEventResult } from '../entities/ad-event.entity';

export class AdEventDto {
  @ApiProperty({ example: 'ad-uuid' })
  @IsUUID()
  adId: string;

  @ApiProperty({ example: 'gatepass' })
  @IsString()
  module: string;

  @ApiProperty({ enum: AdEventResult, example: AdEventResult.COMPLETED })
  @IsEnum(AdEventResult)
  result: AdEventResult;
}
