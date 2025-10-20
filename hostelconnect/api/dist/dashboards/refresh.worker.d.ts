import { Job } from 'bull';
import { DashboardsService } from './dashboards.service';
export declare class RefreshWorker {
    private readonly dashboardsService;
    constructor(dashboardsService: DashboardsService);
    process(job: Job): Promise<void>;
    private refreshLiveViews;
    private refreshDailyViews;
    private refreshMonthlyViews;
}
