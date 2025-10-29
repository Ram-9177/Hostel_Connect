import { Controller, Post, Body, Get, Param, HttpCode, HttpStatus, UseGuards } from '@nestjs/common';
import { GateService } from './gate.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';
import { ManualGateDto } from './dto/manual-gate.dto';

@Controller('gate')
export class GateController {
  constructor(private readonly gateService: GateService) {}

  @Post('scan')
  @HttpCode(HttpStatus.OK)
  @UseGuards(JwtAuthGuard)
  async scanGatePass(@Body() scanDto: ScanGatePassDto) {
    return this.gateService.scanGatePass(scanDto);
  }

  @Post('manual')
  @HttpCode(HttpStatus.OK)
  @UseGuards(JwtAuthGuard)
  async manualGate(@Body() dto: ManualGateDto) {
    return this.gateService.manualGateEvent(dto);
  }

  @Get('events')
  @UseGuards(JwtAuthGuard)
  async getGateEvents() {
    return this.gateService.getGateEvents();
  }

  @Get('stats/today')
  @UseGuards(JwtAuthGuard)
  async getTodaySummary() {
    return this.gateService.getTodaySummary();
  }

  @Get('events/today')
  @UseGuards(JwtAuthGuard)
  async getTodayEvents() {
    return this.gateService.getTodayEvents();
  }

  @Get('events/student/:studentId')
  @UseGuards(JwtAuthGuard)
  async getStudentEvents(@Param('studentId') studentId: string) {
    return this.gateService.getStudentEvents(studentId);
  }

  @Get('stats')
  @UseGuards(JwtAuthGuard)
  async getGateStats() {
    return this.gateService.getGateStats();
  }

  @Post('validate')
  @HttpCode(HttpStatus.OK)
  async validateGatePass(@Body() body: { qrCode: string }) {
    return this.gateService.validateGatePass(body.qrCode);
  }
}