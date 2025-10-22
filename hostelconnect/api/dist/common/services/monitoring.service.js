"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MonitoringService = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const app_logger_service_1 = require("./app-logger.service");
const redis_service_1 = require("./redis.service");
let MonitoringService = class MonitoringService {
    constructor(configService, logger, redisService) {
        this.configService = configService;
        this.logger = logger;
        this.redisService = redisService;
        this.requestCount = 0;
        this.errorCount = 0;
        this.responseTimes = [];
        this.startTime = Date.now();
        this.metrics = this.initializeMetrics();
    }
    async onModuleInit() {
        setInterval(() => {
            this.collectMetrics();
        }, 60000);
        this.logger.logHealth('application', 'healthy', {
            version: this.configService.get('APP_VERSION', '1.0.0'),
            environment: this.configService.get('NODE_ENV', 'development'),
        });
    }
    initializeMetrics() {
        return {
            timestamp: new Date().toISOString(),
            system: {
                uptime: 0,
                memory: { used: 0, free: 0, total: 0, percentage: 0 },
                cpu: { usage: 0, loadAverage: [] },
                disk: { used: 0, free: 0, total: 0, percentage: 0 },
            },
            application: {
                requests: { total: 0, perMinute: 0, errors: 0, averageResponseTime: 0 },
                database: { connections: 0, slowQueries: 0, cacheHitRate: 0 },
                redis: { memoryUsage: '0MB', keyCount: 0, hitRate: 0 },
            },
            business: {
                activeUsers: 0,
                gatePassesToday: 0,
                attendanceToday: 0,
                mealsToday: 0,
            },
        };
    }
    async collectMetrics() {
        try {
            this.metrics.system.uptime = process.uptime();
            this.metrics.system.memory = this.getMemoryMetrics();
            this.metrics.system.cpu = this.getCpuMetrics();
            this.metrics.system.disk = await this.getDiskMetrics();
            this.metrics.application.requests = this.getRequestMetrics();
            this.metrics.application.database = await this.getDatabaseMetrics();
            this.metrics.application.redis = await this.getRedisMetrics();
            this.metrics.business = await this.getBusinessMetrics();
            this.metrics.timestamp = new Date().toISOString();
            this.logger.logPerformance('metrics_collection', 0, {
                metrics: this.metrics,
            });
            await this.redisService.setex('metrics:latest', 300, JSON.stringify(this.metrics));
            return this.metrics;
        }
        catch (error) {
            this.logger.logError(error, 'MonitoringService');
            return this.metrics;
        }
    }
    getMemoryMetrics() {
        const memUsage = process.memoryUsage();
        const total = memUsage.heapTotal;
        const used = memUsage.heapUsed;
        const free = total - used;
        const percentage = (used / total) * 100;
        return {
            used: Math.round(used / 1024 / 1024),
            free: Math.round(free / 1024 / 1024),
            total: Math.round(total / 1024 / 1024),
            percentage: Math.round(percentage * 100) / 100,
        };
    }
    getCpuMetrics() {
        const cpus = require('os').cpus();
        const loadAvg = require('os').loadavg();
        let totalIdle = 0;
        let totalTick = 0;
        cpus.forEach((cpu) => {
            for (const type in cpu.times) {
                totalTick += cpu.times[type];
            }
            totalIdle += cpu.times.idle;
        });
        const usage = 100 - Math.round((100 * totalIdle) / totalTick);
        return {
            usage: Math.max(0, Math.min(100, usage)),
            loadAverage: loadAvg,
        };
    }
    async getDiskMetrics() {
        try {
            const fs = require('fs');
            const stats = fs.statSync('.');
            return {
                used: 0,
                free: 0,
                total: 0,
                percentage: 0,
            };
        }
        catch (error) {
            return {
                used: 0,
                free: 0,
                total: 0,
                percentage: 0,
            };
        }
    }
    getRequestMetrics() {
        const averageResponseTime = this.responseTimes.length > 0
            ? this.responseTimes.reduce((a, b) => a + b, 0) / this.responseTimes.length
            : 0;
        return {
            total: this.requestCount,
            perMinute: this.requestCount / (this.getUptimeMinutes() || 1),
            errors: this.errorCount,
            averageResponseTime: Math.round(averageResponseTime),
        };
    }
    async getDatabaseMetrics() {
        try {
            return {
                connections: 0,
                slowQueries: 0,
                cacheHitRate: 0.95,
            };
        }
        catch (error) {
            return {
                connections: 0,
                slowQueries: 0,
                cacheHitRate: 0,
            };
        }
    }
    async getRedisMetrics() {
        try {
            const info = await this.redisService.info();
            const keys = await this.redisService.keys('*');
            const memoryMatch = info.match(/used_memory_human:([^\r\n]+)/);
            const memoryUsage = memoryMatch ? memoryMatch[1].trim() : '0B';
            return {
                memoryUsage,
                keyCount: keys.length,
                hitRate: 0.95,
            };
        }
        catch (error) {
            return {
                memoryUsage: '0B',
                keyCount: 0,
                hitRate: 0,
            };
        }
    }
    async getBusinessMetrics() {
        try {
            return {
                activeUsers: 0,
                gatePassesToday: 0,
                attendanceToday: 0,
                mealsToday: 0,
            };
        }
        catch (error) {
            return {
                activeUsers: 0,
                gatePassesToday: 0,
                attendanceToday: 0,
                mealsToday: 0,
            };
        }
    }
    getUptimeMinutes() {
        return (Date.now() - this.startTime) / (1000 * 60);
    }
    trackRequest(responseTime) {
        this.requestCount++;
        this.responseTimes.push(responseTime);
        if (this.responseTimes.length > 100) {
            this.responseTimes = this.responseTimes.slice(-100);
        }
    }
    trackError() {
        this.errorCount++;
    }
    async getMetrics() {
        return this.metrics;
    }
    async getHealthStatus() {
        const metrics = await this.collectMetrics();
        const health = {
            status: 'healthy',
            timestamp: metrics.timestamp,
            uptime: metrics.system.uptime,
            version: this.configService.get('APP_VERSION', '1.0.0'),
            environment: this.configService.get('NODE_ENV', 'development'),
            checks: {
                memory: metrics.system.memory.percentage < 90 ? 'healthy' : 'warning',
                cpu: metrics.system.cpu.usage < 80 ? 'healthy' : 'warning',
                database: metrics.application.database.connections > 0 ? 'healthy' : 'unhealthy',
                redis: metrics.application.redis.keyCount >= 0 ? 'healthy' : 'unhealthy',
            },
        };
        const checkValues = Object.values(health.checks);
        if (checkValues.includes('unhealthy')) {
            health.status = 'unhealthy';
        }
        else if (checkValues.includes('warning')) {
            health.status = 'warning';
        }
        return health;
    }
    async getPerformanceReport() {
        const metrics = await this.collectMetrics();
        return {
            summary: {
                uptime: `${Math.floor(metrics.system.uptime / 3600)}h ${Math.floor((metrics.system.uptime % 3600) / 60)}m`,
                totalRequests: metrics.application.requests.total,
                errorRate: metrics.application.requests.errors / Math.max(metrics.application.requests.total, 1),
                averageResponseTime: metrics.application.requests.averageResponseTime,
                memoryUsage: `${metrics.system.memory.percentage}%`,
                cpuUsage: `${metrics.system.cpu.usage}%`,
            },
            details: metrics,
        };
    }
    async checkAlerts() {
        const metrics = await this.collectMetrics();
        if (metrics.system.memory.percentage > 90) {
            this.logger.logSecurity('High memory usage detected', {
                memoryUsage: metrics.system.memory.percentage,
                threshold: 90,
            });
        }
        if (metrics.system.cpu.usage > 80) {
            this.logger.logSecurity('High CPU usage detected', {
                cpuUsage: metrics.system.cpu.usage,
                threshold: 80,
            });
        }
        const errorRate = metrics.application.requests.errors / Math.max(metrics.application.requests.total, 1);
        if (errorRate > 0.05) {
            this.logger.logSecurity('High error rate detected', {
                errorRate: errorRate,
                threshold: 0.05,
            });
        }
        if (metrics.application.requests.averageResponseTime > 1000) {
            this.logger.logSecurity('High response time detected', {
                responseTime: metrics.application.requests.averageResponseTime,
                threshold: 1000,
            });
        }
    }
};
exports.MonitoringService = MonitoringService;
exports.MonitoringService = MonitoringService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [config_1.ConfigService,
        app_logger_service_1.AppLoggerService,
        redis_service_1.RedisService])
], MonitoringService);
//# sourceMappingURL=monitoring.service.js.map