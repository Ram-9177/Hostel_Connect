import { Controller, Get, Post, Body, UseGuards, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiParam, ApiQuery } from '@nestjs/swagger';
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
  @ApiQuery({ name: 'hostelId', required: false, description: 'Filter by hostel ID' })
  @ApiResponse({ status: 200, description: 'Room map retrieved' })
  async getMap(@Query('hostelId') hostelId?: string) {
    return this.roomsService.getMap(hostelId);
  }

  @Get('available')
  @ApiOperation({ summary: 'Get available rooms' })
  @ApiQuery({ name: 'hostelId', required: false, description: 'Filter by hostel ID' })
  @ApiResponse({ status: 200, description: 'Available rooms retrieved' })
  async getAvailableRooms(@Query('hostelId') hostelId?: string) {
    return this.roomsService.getAvailableRooms(hostelId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get room details' })
  @ApiParam({ name: 'id', description: 'Room ID' })
  @ApiResponse({ status: 200, description: 'Room details retrieved' })
  async getRoomDetails(@Param('id') id: string) {
    return this.roomsService.getRoomDetails(id);
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
