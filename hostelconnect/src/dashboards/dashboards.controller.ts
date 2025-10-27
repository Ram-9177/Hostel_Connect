import { Controller, Get, Param, UseGuards, Query, Post } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { DashboardsService } from './dashboards.service';

@ApiTags('Dashboards')
@Controller('dash')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class DashboardsController {
  constructor(private readonly dashboardsService: DashboardsService) {}

  @Get('hostel-live')
  @ApiOperation({ summary: 'Get live hostel dashboard data' })
  @ApiResponse({ status: 200, description: 'Live dashboard data retrieved' })
  async getHostelLive() {
    return this.dashboardsService.getHostelLive();
  }

  @Get('hostel-live/:hostelId')
  @ApiOperation({ summary: 'Get live dashboard data for specific hostel' })
  @ApiResponse({ status: 200, description: 'Hostel live data retrieved' })
  async getHostelLiveById(@Param('hostelId') hostelId: string) {
    const result = await this.dashboardsService.getHostelLive(hostelId);
    return result[0] || null;
  }

  @Get('attendance/session/:sessionId')
  @ApiOperation({ summary: 'Get attendance session summary' })
  @ApiResponse({ status: 200, description: 'Attendance session summary retrieved' })
  async getAttendanceSessionSummary(@Param('sessionId') sessionId: string) {
    return this.dashboardsService.getAttendanceSessionSummary(sessionId);
  }

  @Get('gate/funnel')
  @ApiOperation({ summary: 'Get gate pass funnel data' })
  @ApiResponse({ status: 200, description: 'Gate funnel data retrieved' })
  async getGateFunnel(@Query('hostelId') hostelId?: string, @Query('days') days?: number) {
    return this.dashboardsService.getGateFunnel(hostelId, days ? parseInt(days.toString()) : 7);
  }

  @Get('meals/forecast')
  @ApiOperation({ summary: 'Get meal forecast data' })
  @ApiResponse({ status: 200, description: 'Meal forecast data retrieved' })
  async getMealForecast(@Query('hostelId') hostelId?: string, @Query('days') days?: number) {
    return this.dashboardsService.getMealForecast(hostelId, days ? parseInt(days.toString()) : 7);
  }

  @Get('monthly')
  @ApiOperation({ summary: 'Get monthly analytics' })
  @ApiResponse({ status: 200, description: 'Monthly analytics retrieved' })
  async getMonthlyAnalytics(@Query('hostelId') hostelId?: string, @Query('month') month?: string) {
    return this.dashboardsService.getMonthlyAnalytics(hostelId, month);
  }

  @Get('rooms/occupancy')
  @ApiOperation({ summary: 'Get room occupancy data' })
  @ApiResponse({ status: 200, description: 'Room occupancy data retrieved' })
  async getRoomOccupancy(@Query('hostelId') hostelId?: string) {
    return this.dashboardsService.getRoomOccupancy(hostelId);
  }

  @Post('refresh')
  @ApiOperation({ summary: 'Refresh materialized views' })
  @ApiResponse({ status: 200, description: 'Materialized views refreshed' })
  async refreshViews() {
    await this.dashboardsService.refreshMaterializedViews();
    return { message: 'Materialized views refreshed successfully' };
  }
}
