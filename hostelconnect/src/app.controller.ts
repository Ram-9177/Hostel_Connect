import { Controller, Get } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AppService } from './app.service';

@ApiTags('Health')
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @ApiOperation({ summary: 'Health check endpoint' })
  @ApiResponse({ status: 200, description: 'API is healthy' })
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  @ApiOperation({ summary: 'Detailed health check' })
  @ApiResponse({ status: 200, description: 'Detailed health status' })
  getHealth() {
    return this.appService.getHealth();
  }

  @Get('test-notices')
  @ApiOperation({ summary: 'Test notices endpoint' })
  @ApiResponse({ status: 200, description: 'Test endpoint working' })
  testNotices() {
    return { message: 'Test notices endpoint working' };
  }
}
