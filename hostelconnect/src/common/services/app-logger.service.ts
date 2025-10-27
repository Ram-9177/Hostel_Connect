import { Injectable, LoggerService, LogLevel } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as winston from 'winston';
import * as DailyRotateFile from 'winston-daily-rotate-file';

export interface LogContext {
  userId?: string;
  requestId?: string;
  ip?: string;
  userAgent?: string;
  method?: string;
  url?: string;
  statusCode?: number;
  responseTime?: number;
  error?: Error;
  [key: string]: any;
}

@Injectable()
export class AppLoggerService implements LoggerService {
  private readonly logger: winston.Logger;

  constructor(private readonly configService: ConfigService) {
    this.logger = this.createLogger();
  }

  private createLogger(): winston.Logger {
    const logLevel = this.configService.get<string>('LOG_LEVEL', 'info');
    const logDir = this.configService.get<string>('LOG_DIR', './logs');

    const transports: winston.transport[] = [
      // Console transport
      new winston.transports.Console({
        level: logLevel,
        format: winston.format.combine(
          winston.format.colorize(),
          winston.format.timestamp(),
          winston.format.printf(({ timestamp, level, message, context, ...meta }) => {
            const contextStr = context ? `[${context}] ` : '';
            const metaStr = Object.keys(meta).length ? ` ${JSON.stringify(meta)}` : '';
            return `${timestamp} ${level}: ${contextStr}${message}${metaStr}`;
          }),
        ),
      }),
    ];

    // File transports for different log levels
    if (process.env.NODE_ENV === 'production') {
      // Error logs
      transports.push(
        new DailyRotateFile({
          filename: `${logDir}/error-%DATE%.log`,
          datePattern: 'YYYY-MM-DD',
          level: 'error',
          maxSize: '20m',
          maxFiles: '14d',
          format: winston.format.combine(
            winston.format.timestamp(),
            winston.format.json(),
          ),
        }),
      );

      // Combined logs
      transports.push(
        new DailyRotateFile({
          filename: `${logDir}/combined-%DATE%.log`,
          datePattern: 'YYYY-MM-DD',
          maxSize: '20m',
          maxFiles: '30d',
          format: winston.format.combine(
            winston.format.timestamp(),
            winston.format.json(),
          ),
        }),
      );

      // Access logs
      transports.push(
        new DailyRotateFile({
          filename: `${logDir}/access-%DATE%.log`,
          datePattern: 'YYYY-MM-DD',
          level: 'http',
          maxSize: '20m',
          maxFiles: '7d',
          format: winston.format.combine(
            winston.format.timestamp(),
            winston.format.json(),
          ),
        }),
      );
    }

    return winston.createLogger({
      level: logLevel,
      format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.errors({ stack: true }),
        winston.format.json(),
      ),
      transports,
      exceptionHandlers: [
        new winston.transports.File({ filename: `${logDir}/exceptions.log` }),
      ],
      rejectionHandlers: [
        new winston.transports.File({ filename: `${logDir}/rejections.log` }),
      ],
    });
  }

  log(message: string, context?: string, meta?: LogContext) {
    this.logger.info(message, { context, ...meta });
  }

  error(message: string, trace?: string, context?: string, meta?: LogContext) {
    this.logger.error(message, { context, trace, ...meta });
  }

  warn(message: string, context?: string, meta?: LogContext) {
    this.logger.warn(message, { context, ...meta });
  }

  debug(message: string, context?: string, meta?: LogContext) {
    this.logger.debug(message, { context, ...meta });
  }

  verbose(message: string, context?: string, meta?: LogContext) {
    this.logger.verbose(message, { context, ...meta });
  }

  // Custom logging methods
  logRequest(method: string, url: string, statusCode: number, responseTime: number, context?: LogContext) {
    this.logger.http('HTTP Request', {
      method,
      url,
      statusCode,
      responseTime,
      ...context,
    });
  }

  logError(error: Error, context?: string, meta?: LogContext) {
    this.logger.error(error.message, {
      context,
      stack: error.stack,
      name: error.name,
      ...meta,
    });
  }

  logSecurity(event: string, context?: LogContext) {
    this.logger.warn(`Security Event: ${event}`, {
      context: 'SECURITY',
      ...context,
    });
  }

  logPerformance(operation: string, duration: number, context?: LogContext) {
    this.logger.info(`Performance: ${operation}`, {
      context: 'PERFORMANCE',
      duration,
      ...context,
    });
  }

  logDatabase(query: string, duration: number, context?: LogContext) {
    this.logger.debug(`Database Query: ${query}`, {
      context: 'DATABASE',
      duration,
      ...context,
    });
  }

  logCache(operation: string, key: string, hit: boolean, context?: LogContext) {
    this.logger.debug(`Cache ${operation}: ${key}`, {
      context: 'CACHE',
      hit,
      ...context,
    });
  }

  logAuth(action: string, userId: string, success: boolean, context?: LogContext) {
    this.logger.info(`Auth ${action}`, {
      context: 'AUTH',
      userId,
      success,
      ...context,
    });
  }

  logBusiness(event: string, context?: LogContext) {
    this.logger.info(`Business Event: ${event}`, {
      context: 'BUSINESS',
      ...context,
    });
  }

  // Structured logging for analytics
  logAnalytics(event: string, properties: Record<string, any>, context?: LogContext) {
    this.logger.info(`Analytics: ${event}`, {
      context: 'ANALYTICS',
      properties,
      ...context,
    });
  }

  // Health check logging
  logHealth(service: string, status: 'healthy' | 'unhealthy', details?: any) {
    this.logger.info(`Health Check: ${service}`, {
      context: 'HEALTH',
      status,
      details,
    });
  }

  // Audit logging
  logAudit(action: string, resource: string, userId: string, context?: LogContext) {
    this.logger.info(`Audit: ${action} on ${resource}`, {
      context: 'AUDIT',
      action,
      resource,
      userId,
      ...context,
    });
  }

  // Get logger instance for custom usage
  getLogger(): winston.Logger {
    return this.logger;
  }
}
