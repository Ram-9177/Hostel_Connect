import { LoggerService } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as winston from 'winston';
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
export declare class AppLoggerService implements LoggerService {
    private readonly configService;
    private readonly logger;
    constructor(configService: ConfigService);
    private createLogger;
    log(message: string, context?: string, meta?: LogContext): void;
    error(message: string, trace?: string, context?: string, meta?: LogContext): void;
    warn(message: string, context?: string, meta?: LogContext): void;
    debug(message: string, context?: string, meta?: LogContext): void;
    verbose(message: string, context?: string, meta?: LogContext): void;
    logRequest(method: string, url: string, statusCode: number, responseTime: number, context?: LogContext): void;
    logError(error: Error, context?: string, meta?: LogContext): void;
    logSecurity(event: string, context?: LogContext): void;
    logPerformance(operation: string, duration: number, context?: LogContext): void;
    logDatabase(query: string, duration: number, context?: LogContext): void;
    logCache(operation: string, key: string, hit: boolean, context?: LogContext): void;
    logAuth(action: string, userId: string, success: boolean, context?: LogContext): void;
    logBusiness(event: string, context?: LogContext): void;
    logAnalytics(event: string, properties: Record<string, any>, context?: LogContext): void;
    logHealth(service: string, status: 'healthy' | 'unhealthy', details?: any): void;
    logAudit(action: string, resource: string, userId: string, context?: LogContext): void;
    getLogger(): winston.Logger;
}
