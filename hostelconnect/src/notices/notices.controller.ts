import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { NoticesService } from './notices.service';

@ApiTags('Notices')
@Controller('notices')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class NoticesController {
  constructor(private readonly noticesService: NoticesService) {}

  @Get()
  @ApiOperation({ summary: 'Get all notices' })
  @ApiResponse({ status: 200, description: 'Notices retrieved' })
  async findAll() {
    return this.noticesService.findAll();
  }

  @Post()
  @ApiOperation({ summary: 'Create notice' })
  @ApiResponse({ status: 201, description: 'Notice created' })
  async create(@Body() createDto: any) {
    return this.noticesService.create(createDto);
  }
}
