import { Injectable, OnModuleInit } from '@nestjs/common';
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

@Injectable()
export class MonitoringService implements OnModuleInit {
  private metrics: SystemMetrics;
  private requestCount = 0;
  private errorCount = 0;
  private responseTimes: number[] = [];
  private startTime = Date.now();

  constructor(
    private readonly configService: ConfigService,
    private readonly logger: AppLoggerService,
    private readonly redisService: RedisService,
  ) {
    this.metrics = this.initializeMetrics();
  }

  async onModuleInit() {
    // Start monitoring loop
    setInterval(() => {
      this.collectMetrics();
    }, 60000); // Collect metrics every minute

    // Log startup
    this.logger.logHealth('application', 'healthy', {
      version: this.configService.get('APP_VERSION', '1.0.0'),
      environment: this.configService.get('NODE_ENV', 'development'),
    });
  }

  private initializeMetrics(): SystemMetrics {
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

  async collectMetrics(): Promise<SystemMetrics> {
    try {
      // System metrics
      this.metrics.system.uptime = process.uptime();
      this.metrics.system.memory = this.getMemoryMetrics();
      this.metrics.system.cpu = this.getCpuMetrics();
      this.metrics.system.disk = await this.getDiskMetrics();

      // Application metrics
      this.metrics.application.requests = this.getRequestMetrics();
      this.metrics.application.database = await this.getDatabaseMetrics();
      this.metrics.application.redis = await this.getRedisMetrics();

      // Business metrics
      this.metrics.business = await this.getBusinessMetrics();

      this.metrics.timestamp = new Date().toISOString();

      // Log metrics
      this.logger.logPerformance('metrics_collection', 0, {
        metrics: this.metrics,
      });

      // Store metrics in Redis for real-time monitoring
      await this.redisService.setex(
        'metrics:latest',
        300, // 5 minutes
        JSON.stringify(this.metrics),
      );

      return this.metrics;
    } catch (error) {
      this.logger.logError(error, 'MonitoringService');
      return this.metrics;
    }
  }

  private getMemoryMetrics() {
    const memUsage = process.memoryUsage();
    const total = memUsage.heapTotal;
    const used = memUsage.heapUsed;
    const free = total - used;
    const percentage = (used / total) * 100;

    return {
      used: Math.round(used / 1024 / 1024), // MB
      free: Math.round(free / 1024 / 1024), // MB
      total: Math.round(total / 1024 / 1024), // MB
      percentage: Math.round(percentage * 100) / 100,
    };
  }

  private getCpuMetrics() {
    const cpus = require('os').cpus();
    const loadAvg = require('os').loadavg();

    // Simple CPU usage calculation
    let totalIdle = 0;
    let totalTick = 0;

    cpus.forEach((cpu: any) => {
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

  private async getDiskMetrics() {
    try {
      const fs = require('fs');
      const stats = fs.statSync('.');
      
      // This is a simplified implementation
      // In production, you'd use a proper disk usage library
      return {
        used: 0,
        free: 0,
        total: 0,
        percentage: 0,
      };
    } catch (error) {
      return {
        used: 0,
        free: 0,
        total: 0,
        percentage: 0,
      };
    }
  }

  private getRequestMetrics() {
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

  private async getDatabaseMetrics() {
    try {
      // This would typically query the database for connection info
      return {
        connections: 0, // Placeholder
        slowQueries: 0, // Placeholder
        cacheHitRate: 0.95, // Placeholder
      };
    } catch (error) {
      return {
        connections: 0,
        slowQueries: 0,
        cacheHitRate: 0,
      };
    }
  }

  private async getRedisMetrics() {
    try {
      const info = await this.redisService.info();
      const keys = await this.redisService.keys('*');
      
      // Parse Redis info for memory usage
      const memoryMatch = info.match(/used_memory_human:([^\r\n]+)/);
      const memoryUsage = memoryMatch ? memoryMatch[1].trim() : '0B';

      return {
        memoryUsage,
        keyCount: keys.length,
        hitRate: 0.95, // Placeholder
      };
    } catch (error) {
      return {
        memoryUsage: '0B',
        keyCount: 0,
        hitRate: 0,
      };
    }
  }

  private async getBusinessMetrics() {
    try {
      // This would typically query the database for business metrics
      return {
        activeUsers: 0, // Placeholder
        gatePassesToday: 0, // Placeholder
        attendanceToday: 0, // Placeholder
        mealsToday: 0, // Placeholder
      };
    } catch (error) {
      return {
        activeUsers: 0,
        gatePassesToday: 0,
        attendanceToday: 0,
        mealsToday: 0,
      };
    }
  }

  private getUptimeMinutes(): number {
    return (Date.now() - this.startTime) / (1000 * 60);
  }

  // Public methods for tracking
  trackRequest(responseTime: number) {
    this.requestCount++;
    this.responseTimes.push(responseTime);
    
    // Keep only last 100 response times
    if (this.responseTimes.length > 100) {
      this.responseTimes = this.responseTimes.slice(-100);
    }
  }

  trackError() {
    this.errorCount++;
  }

  async getMetrics(): Promise<SystemMetrics> {
    return this.metrics;
  }

  async getHealthStatus(): Promise<any> {
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

    // Determine overall health status
    const checkValues = Object.values(health.checks);
    if (checkValues.includes('unhealthy')) {
      health.status = 'unhealthy';
    } else if (checkValues.includes('warning')) {
      health.status = 'warning';
    }

    return health;
  }

  async getPerformanceReport(): Promise<any> {
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

  // Alerting
  async checkAlerts(): Promise<void> {
    const metrics = await this.collectMetrics();
    
    // Memory alert
    if (metrics.system.memory.percentage > 90) {
      this.logger.logSecurity('High memory usage detected', {
        memoryUsage: metrics.system.memory.percentage,
        threshold: 90,
      });
    }

    // CPU alert
    if (metrics.system.cpu.usage > 80) {
      this.logger.logSecurity('High CPU usage detected', {
        cpuUsage: metrics.system.cpu.usage,
        threshold: 80,
      });
    }

    // Error rate alert
    const errorRate = metrics.application.requests.errors / Math.max(metrics.application.requests.total, 1);
    if (errorRate > 0.05) { // 5% error rate
      this.logger.logSecurity('High error rate detected', {
        errorRate: errorRate,
        threshold: 0.05,
      });
    }

    // Response time alert
    if (metrics.application.requests.averageResponseTime > 1000) { // 1 second
      this.logger.logSecurity('High response time detected', {
        responseTime: metrics.application.requests.averageResponseTime,
        threshold: 1000,
      });
    }
  }
}
