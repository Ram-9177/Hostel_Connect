import { Controller, Get, Post, Body, Param, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { AttendanceService, CreateAttendanceSessionDto, ScanAttendanceDto, ManualAttendanceDto } from './attendance.service';

@ApiTags('Attendance')
@Controller('attendance')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class AttendanceController {
  constructor(private readonly attendanceService: AttendanceService) {}

  @Post('sessions')
  @ApiOperation({ summary: 'Create attendance session' })
  @ApiResponse({ status: 201, description: 'Attendance session created' })
  @ApiResponse({ status: 400, description: 'Invalid session data' })
  async createSession(@Body() createSessionDto: CreateAttendanceSessionDto) {
    return this.attendanceService.createSession(createSessionDto);
  }

  @Get('sessions/:id/roster')
  @ApiOperation({ summary: 'Get attendance roster' })
  @ApiResponse({ status: 200, description: 'Attendance roster retrieved' })
  async getRoster(@Param('id') id: string) {
    return this.attendanceService.getRoster(id);
  }

  @Post('scan')
  @ApiOperation({ summary: 'Scan attendance QR' })
  @ApiResponse({ status: 200, description: 'Attendance scanned successfully' })
  @ApiResponse({ status: 400, description: 'Invalid QR token or duplicate scan' })
  async scan(@Body() scanDto: ScanAttendanceDto) {
    return this.attendanceService.scanAttendance(scanDto);
  }

  @Post('manual')
  @ApiOperation({ summary: 'Manual attendance entry' })
  @ApiResponse({ status: 201, description: 'Manual attendance recorded' })
  @ApiResponse({ status: 400, description: 'Invalid manual attendance data' })
  async manual(@Body() manualDto: ManualAttendanceDto) {
    return this.attendanceService.manualAttendance(manualDto);
  }

  @Post('sessions/:id/close')
  @ApiOperation({ summary: 'Close attendance session' })
  @ApiResponse({ status: 200, description: 'Session closed' })
  @ApiResponse({ status: 400, description: 'Cannot close session' })
  async closeSession(@Param('id') id: string) {
    return this.attendanceService.closeSession(id);
  }

  @Get('sessions/:id/summary')
  @ApiOperation({ summary: 'Get session summary' })
  @ApiResponse({ status: 200, description: 'Session summary retrieved' })
  async getSummary(@Param('id') id: string) {
    return this.attendanceService.getSummary(id);
  }

  @Get('sessions/:id/qr')
  @ApiOperation({ summary: 'Generate attendance QR for session' })
  @ApiResponse({ status: 200, description: 'QR token generated' })
  async generateQR(@Param('id') id: string) {
    const qrToken = this.attendanceService.generateAttendanceQR(id);
    return { qrToken };
  }
}
