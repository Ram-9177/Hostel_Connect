import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { RoomsService } from './rooms.service';

@ApiTags('Rooms')
@Controller('rooms')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class RoomsController {
  constructor(private readonly roomsService: RoomsService) {}

  @Get('map')
  @ApiOperation({ summary: 'Get room occupancy map' })
  @ApiResponse({ status: 200, description: 'Room map retrieved' })
  async getMap() {
    return this.roomsService.getMap();
  }

  @Post('allocate')
  @ApiOperation({ summary: 'Allocate room to student' })
  @ApiResponse({ status: 201, description: 'Room allocated' })
  async allocate(@Body() allocateDto: any) {
    return this.roomsService.allocate(allocateDto);
  }

  @Post('transfer')
  @ApiOperation({ summary: 'Transfer student to different room' })
  @ApiResponse({ status: 200, description: 'Transfer processed' })
  async transfer(@Body() transferDto: any) {
    return this.roomsService.transfer(transferDto);
  }

  @Post('swap')
  @ApiOperation({ summary: 'Swap rooms between students' })
  @ApiResponse({ status: 200, description: 'Swap processed' })
  async swap(@Body() swapDto: any) {
    return this.roomsService.swap(swapDto);
  }
}
