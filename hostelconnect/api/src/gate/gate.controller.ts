import { Controller, Post, Body, Get, Param, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { GateService } from './gate.service';
import { ScanGatePassDto } from './dto/scan-gate-pass.dto';

@ApiTags('Gate')
@Controller('gate')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class GateController {
  constructor(private readonly gateService: GateService) {}

  @Post('scan')
  @ApiOperation({ summary: 'Scan gate pass QR code' })
  @ApiResponse({ status: 200, description: 'Gate scan processed successfully' })
  @ApiResponse({ status: 400, description: 'Invalid QR token or gate pass' })
  async scan(@Body() scanDto: ScanGatePassDto) {
    return this.gateService.scanGatePass(scanDto);
  }

  @Get('pass/:passId/events')
  @ApiOperation({ summary: 'Get gate pass events' })
  @ApiResponse({ status: 200, description: 'Gate pass events retrieved' })
  async getGatePassEvents(@Param('passId') passId: string) {
    return this.gateService.getGatePassEvents(passId);
  }

  @Get('student/:studentId/events')
  @ApiOperation({ summary: 'Get student gate events' })
  @ApiResponse({ status: 200, description: 'Student gate events retrieved' })
  async getStudentGateEvents(@Param('studentId') studentId: string) {
    return this.gateService.getStudentGateEvents(studentId);
  }
}
