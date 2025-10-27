import { Controller, Get, Post, Body, Param, UseGuards, Request, Patch } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { GatePassService } from './gatepass.service';
import { CreateGatePassDto } from './dto/create-gate-pass.dto';
import { ApproveGatePassDto } from './dto/approve-gate-pass.dto';

@ApiTags('Gate Pass')
@Controller('gate-pass')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class GatePassController {
  constructor(private readonly gatePassService: GatePassService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new gate pass request' })
  @ApiResponse({ status: 201, description: 'Gate pass created successfully' })
  @ApiResponse({ status: 400, description: 'Invalid gate pass data' })
  async create(@Body() createDto: CreateGatePassDto, @Request() req) {
    return this.gatePassService.create(createDto, req.user.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get gate pass requests' })
  @ApiResponse({ status: 200, description: 'Gate pass list retrieved' })
  async findAll(@Request() req) {
    // Filter by student if role is STUDENT
    const studentId = req.user.role === 'STUDENT' ? req.user.id : undefined;
    return this.gatePassService.findAll(studentId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get gate pass by ID' })
  @ApiResponse({ status: 200, description: 'Gate pass retrieved' })
  @ApiResponse({ status: 404, description: 'Gate pass not found' })
  async findOne(@Param('id') id: string) {
    return this.gatePassService.findById(id);
  }

  @Patch(':id/approve')
  @ApiOperation({ summary: 'Approve or reject gate pass (Warden only)' })
  @ApiResponse({ status: 200, description: 'Gate pass decision updated' })
  @ApiResponse({ status: 400, description: 'Invalid decision' })
  async approve(@Param('id') id: string, @Body() approveDto: ApproveGatePassDto, @Request() req) {
    return this.gatePassService.approve(id, approveDto, req.user.id);
  }

  @Patch(':id/cancel')
  @ApiOperation({ summary: 'Cancel gate pass (Student only)' })
  @ApiResponse({ status: 200, description: 'Gate pass cancelled' })
  @ApiResponse({ status: 400, description: 'Cannot cancel gate pass' })
  async cancel(@Param('id') id: string, @Request() req) {
    return this.gatePassService.cancel(id, req.user.id);
  }

  @Get(':id/qr')
  @ApiOperation({ summary: 'Get QR token for approved gate pass' })
  @ApiResponse({ status: 200, description: 'QR token retrieved' })
  @ApiResponse({ status: 400, description: 'QR token not available or ad required' })
  async getQRToken(@Param('id') id: string) {
    return this.gatePassService.getQRToken(id);
  }

  @Post(':id/qr/unlock')
  @ApiOperation({ summary: 'Unlock QR token after watching ad' })
  @ApiResponse({ status: 200, description: 'QR token unlocked' })
  @ApiResponse({ status: 400, description: 'Cannot unlock QR token' })
  async unlockQRTokenAfterAd(@Param('id') id: string, @Request() req) {
    return this.gatePassService.unlockQRTokenAfterAd(id, req.user.id);
  }

  @Post(':id/ad/watched')
  @ApiOperation({ summary: 'Mark ad as watched for gate pass' })
  @ApiResponse({ status: 200, description: 'Ad marked as watched' })
  async markAdWatched(@Param('id') id: string, @Body() body: { adId: string }, @Request() req) {
    await this.gatePassService.markAdWatched(req.user.id, body.adId, 'gatepass');
    return { message: 'Ad marked as watched' };
  }

  @Post(':id/qr/refresh')
  @ApiOperation({ summary: 'Refresh QR token for approved gate pass' })
  @ApiResponse({ status: 200, description: 'QR token refreshed' })
  @ApiResponse({ status: 400, description: 'Cannot refresh QR token' })
  async refreshQRToken(@Param('id') id: string) {
    return this.gatePassService.refreshQRToken(id);
  }
}
