import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { DevicesService } from './devices.service';

@ApiTags('Devices')
@Controller('devices')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class DevicesController {
  constructor(private readonly devicesService: DevicesService) {}

  @Get()
  @ApiOperation({ summary: 'Get all devices' })
  @ApiResponse({ status: 200, description: 'Devices list retrieved' })
  async findAll() {
    return this.devicesService.findAll();
  }

  @Post()
  @ApiOperation({ summary: 'Register new device' })
  @ApiResponse({ status: 201, description: 'Device registered' })
  async create(@Body() createDeviceDto: any) {
    return this.devicesService.create(createDeviceDto);
  }
}
