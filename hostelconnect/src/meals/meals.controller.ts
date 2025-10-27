import { Controller, Get, Post, Body, Patch, UseGuards, Request, Query, ForbiddenException } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { MealsService, OpenMealIntentsDto, SetDayIntentsDto, UpdateIntentDto, CreateOverrideDto } from './meals.service';
import { MealSchedulerService } from './meal-scheduler.service';

@ApiTags('Meals')
@Controller('meals')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class MealsController {
  constructor(
    private readonly mealsService: MealsService,
    private readonly mealSchedulerService: MealSchedulerService,
  ) {}

  @Post('intents/open')
  @ApiOperation({ summary: 'Open meal intents for day' })
  @ApiResponse({ status: 200, description: 'Meal intents opened' })
  async openIntents(@Body() openDto: OpenMealIntentsDto) {
    return this.mealsService.openIntents(openDto);
  }

  @Post('intent/day')
  @ApiOperation({ summary: 'Set meal intents for day' })
  @ApiResponse({ status: 201, description: 'Meal intents set' })
  async setDayIntents(@Body() intentsDto: SetDayIntentsDto, @Request() req) {
    return this.mealsService.setDayIntents(intentsDto, req.user.id);
  }

  @Patch('intent')
  @ApiOperation({ summary: 'Update single meal intent' })
  @ApiResponse({ status: 200, description: 'Meal intent updated' })
  async updateIntent(@Body() updateDto: UpdateIntentDto, @Request() req) {
    return this.mealsService.updateIntent(updateDto, req.user.id);
  }

  @Get('forecast')
  @ApiOperation({ summary: 'Get meal forecast' })
  @ApiResponse({ status: 200, description: 'Meal forecast retrieved' })
  async getForecast(@Query('days') days?: number) {
    return this.mealsService.getForecast(days ? parseInt(days.toString()) : 7);
  }

  @Post('override')
  @ApiOperation({ summary: 'Create meal override (Warden Head only)' })
  @ApiResponse({ status: 201, description: 'Meal override created' })
  async createOverride(@Body() overrideDto: CreateOverrideDto, @Request() req) {
    return this.mealsService.createOverride(overrideDto, req.user.id);
  }

  @Get('intents')
  @ApiOperation({ summary: 'Get student meal intents for date' })
  @ApiResponse({ status: 200, description: 'Student intents retrieved' })
  async getStudentIntents(@Query('date') date: string, @Request() req) {
    return this.mealsService.getStudentIntents(req.user.id, new Date(date));
  }

  @Get('chef-board')
  @ApiOperation({ summary: 'Get chef board for date' })
  @ApiResponse({ status: 200, description: 'Chef board retrieved' })
  async getChefBoard(@Query('date') date: string) {
    return this.mealsService.getChefBoard(new Date(date));
  }

  @Get('quick-actions')
  @ApiOperation({ summary: 'Get quick actions for meal intents' })
  @ApiResponse({ status: 200, description: 'Quick actions retrieved' })
  async getQuickActions(@Request() req) {
    return this.mealsService.getQuickActions(req.user.id);
  }

  @Post('notifications/trigger')
  @ApiOperation({ summary: 'Manually trigger meal notifications (Admin only)' })
  @ApiResponse({ status: 200, description: 'Meal notifications triggered' })
  async triggerMealNotification(
    @Request() req,
    @Body() body: { type: 'morning' | 'evening' | 'menu' },
  ) {
    // Check if user is admin
    if (!['SUPER_ADMIN', 'WARDEN_HEAD', 'WARDEN'].includes(req.user.role)) {
      throw new ForbiddenException('Only admins can trigger meal notifications');
    }

    return this.mealSchedulerService.triggerMealReminder(body.type);
  }
}
