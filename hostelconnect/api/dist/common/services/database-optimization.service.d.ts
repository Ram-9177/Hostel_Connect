import { RedisService } from './redis.service';
export declare class DatabaseOptimizationService {
    private readonly redisService;
    constructor(redisService: RedisService);
    optimizeSlowQueries(): Promise<void>;
    addMissingIndexes(): Promise<void>;
    updateTableStatistics(): Promise<void>;
    vacuumAndAnalyze(): Promise<void>;
    optimizeConnectionPool(): Promise<void>;
    cacheQueryResult(queryKey: string, result: any, ttl?: number): Promise<void>;
    getCachedQueryResult(queryKey: string): Promise<any | null>;
    refreshMaterializedViews(): Promise<void>;
    performMaintenance(): Promise<void>;
    cleanupOldData(): Promise<void>;
    getPerformanceMetrics(): Promise<any>;
    private getConnectionCount;
    private getSlowQueryCount;
    private getCacheHitRate;
    private getRedisMemoryUsage;
    private getRedisKeyCount;
    analyzeQueryPerformance(query: string): Promise<any>;
    private estimateQueryCost;
}
