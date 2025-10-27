import { Controller, Get, Post, Body, Query, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { AdsService } from './ads.service';
import { AdEventDto } from './dto/ad-event.dto';

@ApiTags('Ads')
@Controller('ads')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class AdsController {
  constructor(private readonly adsService: AdsService) {}

  @Get('eligible')
  @ApiOperation({ summary: 'Get eligible ad for module' })
  @ApiResponse({ status: 200, description: 'Eligible ad retrieved' })
  async getEligibleAd(@Query('module') module: string) {
    return this.adsService.getEligibleAd(module);
  }

  @Post('event')
  @ApiOperation({ summary: 'Log ad event' })
  @ApiResponse({ status: 201, description: 'Ad event logged' })
  async logAdEvent(@Body() eventDto: AdEventDto, @Request() req) {
    return this.adsService.logAdEvent(eventDto, req.user.id);
  }

  @Get('stats/:adId')
  @ApiOperation({ summary: 'Get ad statistics' })
  @ApiResponse({ status: 200, description: 'Ad statistics retrieved' })
  async getAdStats(@Query('adId') adId: string) {
    return this.adsService.getAdStats(adId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all ads (Admin only)' })
  @ApiResponse({ status: 200, description: 'Ads list retrieved' })
  async findAll() {
    return this.adsService.findAll();
  }
}
