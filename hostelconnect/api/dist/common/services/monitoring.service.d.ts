import { OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppLoggerService } from './app-logger.service';
import { RedisService } from './redis.service';
export interface SystemMetrics {
    timestamp: string;
    system: {
        uptime: number;
        memory: {
            used: number;
            free: number;
            total: number;
            percentage: number;
        };
        cpu: {
            usage: number;
            loadAverage: number[];
        };
        disk: {
            used: number;
            free: number;
            total: number;
            percentage: number;
        };
    };
    application: {
        requests: {
            total: number;
            perMinute: number;
            errors: number;
            averageResponseTime: number;
        };
        database: {
            connections: number;
            slowQueries: number;
            cacheHitRate: number;
        };
        redis: {
            memoryUsage: string;
            keyCount: number;
            hitRate: number;
        };
    };
    business: {
        activeUsers: number;
        gatePassesToday: number;
        attendanceToday: number;
        mealsToday: number;
    };
}
export declare class MonitoringService implements OnModuleInit {
    private readonly configService;
    private readonly logger;
    private readonly redisService;
    private metrics;
    private requestCount;
    private errorCount;
    private responseTimes;
    private startTime;
    constructor(configService: ConfigService, logger: AppLoggerService, redisService: RedisService);
    onModuleInit(): Promise<void>;
    private initializeMetrics;
    collectMetrics(): Promise<SystemMetrics>;
    private getMemoryMetrics;
    private getCpuMetrics;
    private getDiskMetrics;
    private getRequestMetrics;
    private getDatabaseMetrics;
    private getRedisMetrics;
    private getBusinessMetrics;
    private getUptimeMinutes;
    trackRequest(responseTime: number): void;
    trackError(): void;
    getMetrics(): Promise<SystemMetrics>;
    getHealthStatus(): Promise<any>;
    getPerformanceReport(): Promise<any>;
    checkAlerts(): Promise<void>;
}
