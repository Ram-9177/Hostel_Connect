import { Controller, Post, Body, Get, Param, Patch, UseGuards } from '@nestjs/common';
import { GatePassService } from './gatepass.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { CreateGatePassDto, ApproveGatePassDto, RejectGatePassDto } from './dto/create-gate-pass.dto';

@Controller('gate-pass-applications')
export class GatePassController {
  constructor(private readonly gatePassService: GatePassService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  async createGatePass(@Body() createGatePassDto: CreateGatePassDto) {
    return this.gatePassService.createGatePass(createGatePassDto);
  }

  @Get()
  @UseGuards(JwtAuthGuard)
  async getAllGatePasses() {
    return this.gatePassService.getAllGatePasses();
  }

  @Get('pending')
  @UseGuards(JwtAuthGuard)
  async getPendingGatePasses() {
    return this.gatePassService.getPendingGatePasses();
  }

  @Get('student/:studentId')
  @UseGuards(JwtAuthGuard)
  async getStudentGatePasses(@Param('studentId') studentId: string) {
    return this.gatePassService.getStudentGatePasses(studentId);
  }

  @Patch(':id/approve')
  @UseGuards(JwtAuthGuard)
  async approveGatePass(
    @Param('id') id: string,
    @Body() approveDto: ApproveGatePassDto
  ) {
    return this.gatePassService.approveGatePass(id, approveDto);
  }

  @Patch(':id/reject')
  @UseGuards(JwtAuthGuard)
  async rejectGatePass(
    @Param('id') id: string,
    @Body() rejectDto: RejectGatePassDto
  ) {
    return this.gatePassService.rejectGatePass(id, rejectDto);
  }

  @Get(':id/qr-code')
  @UseGuards(JwtAuthGuard)
  async getQRCode(@Param('id') id: string) {
    return this.gatePassService.generateQRCode(id);
  }

  @Post(':id/use')
  @UseGuards(JwtAuthGuard)
  async useGatePass(@Param('id') id: string) {
    return this.gatePassService.useGatePass(id);
  }
}