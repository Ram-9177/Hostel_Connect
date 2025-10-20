import { Processor } from '@nestjs/bull';
import { Job } from 'bull';
import { DashboardsService } from './dashboards.service';

@Processor('refresh')
export class RefreshWorker {
  constructor(private readonly dashboardsService: DashboardsService) {}

  async process(job: Job): Promise<void> {
    const { type } = job.data;

    switch (type) {
      case 'live':
        await this.refreshLiveViews();
        break;
      case 'daily':
        await this.refreshDailyViews();
        break;
      case 'monthly':
        await this.refreshMonthlyViews();
        break;
      default:
        console.log(`Unknown refresh type: ${type}`);
    }
  }

  private async refreshLiveViews(): Promise<void> {
    try {
      // Refresh live materialized views every 15-30 seconds
      await this.dashboardsService.refreshMaterializedViews();
      console.log('Live views refreshed at:', new Date().toISOString());
    } catch (error) {
      console.error('Failed to refresh live views:', error);
    }
  }

  private async refreshDailyViews(): Promise<void> {
    try {
      // Refresh daily views every 5 minutes
      await this.dashboardsService.refreshMaterializedViews();
      console.log('Daily views refreshed at:', new Date().toISOString());
    } catch (error) {
      console.error('Failed to refresh daily views:', error);
    }
  }

  private async refreshMonthlyViews(): Promise<void> {
    try {
      // Refresh monthly views every hour
      await this.dashboardsService.refreshMaterializedViews();
      console.log('Monthly views refreshed at:', new Date().toISOString());
    } catch (error) {
      console.error('Failed to refresh monthly views:', error);
    }
  }
}
