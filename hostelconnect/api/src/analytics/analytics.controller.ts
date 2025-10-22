import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { AnalyticsService } from './analytics.service';

@ApiTags('Analytics')
@Controller('analytics')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class AnalyticsController {
  constructor(private readonly analyticsService: AnalyticsService) {}

  @Get('comprehensive')
  @ApiOperation({ summary: 'Get comprehensive analytics data' })
  @ApiResponse({ status: 200, description: 'Comprehensive analytics retrieved successfully' })
  async getComprehensiveAnalytics() {
    return this.analyticsService.generateComprehensiveAnalytics();
  }

  @Get('insights')
  @ApiOperation({ summary: 'Get analytics insights and recommendations' })
  @ApiResponse({ status: 200, description: 'Analytics insights retrieved successfully' })
  async getInsights() {
    return this.analyticsService.generateInsights();
  }

  @Get('report')
  @ApiOperation({ summary: 'Generate analytics report' })
  @ApiResponse({ status: 200, description: 'Analytics report generated successfully' })
  async generateReport(@Query('period') period: 'daily' | 'weekly' | 'monthly' = 'weekly') {
    return this.analyticsService.generateReport(period);
  }

  @Get('occupancy')
  @ApiOperation({ summary: 'Get occupancy analytics' })
  @ApiResponse({ status: 200, description: 'Occupancy analytics retrieved successfully' })
  async getOccupancyAnalytics() {
    const analytics = await this.analyticsService.generateComprehensiveAnalytics();
    return analytics.occupancy;
  }

  @Get('attendance')
  @ApiOperation({ summary: 'Get attendance analytics' })
  @ApiResponse({ status: 200, description: 'Attendance analytics retrieved successfully' })
  async getAttendanceAnalytics() {
    const analytics = await this.analyticsService.generateComprehensiveAnalytics();
    return analytics.attendance;
  }

  @Get('meals')
  @ApiOperation({ summary: 'Get meal analytics' })
  @ApiResponse({ status: 200, description: 'Meal analytics retrieved successfully' })
  async getMealAnalytics() {
    const analytics = await this.analyticsService.generateComprehensiveAnalytics();
    return analytics.meals;
  }

  @Get('gatepasses')
  @ApiOperation({ summary: 'Get gate pass analytics' })
  @ApiResponse({ status: 200, description: 'Gate pass analytics retrieved successfully' })
  async getGatePassAnalytics() {
    const analytics = await this.analyticsService.generateComprehensiveAnalytics();
    return analytics.gatePasses;
  }

  @Get('predictions')
  @ApiOperation({ summary: 'Get ML predictions' })
  @ApiResponse({ status: 200, description: 'ML predictions retrieved successfully' })
  async getPredictions() {
    const analytics = await this.analyticsService.generateComprehensiveAnalytics();
    return analytics.predictions;
  }
}
