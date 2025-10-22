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
exports.AppLoggerService = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const winston = require("winston");
const DailyRotateFile = require("winston-daily-rotate-file");
let AppLoggerService = class AppLoggerService {
    constructor(configService) {
        this.configService = configService;
        this.logger = this.createLogger();
    }
    createLogger() {
        const logLevel = this.configService.get('LOG_LEVEL', 'info');
        const logDir = this.configService.get('LOG_DIR', './logs');
        const transports = [
            new winston.transports.Console({
                level: logLevel,
                format: winston.format.combine(winston.format.colorize(), winston.format.timestamp(), winston.format.printf(({ timestamp, level, message, context, ...meta }) => {
                    const contextStr = context ? `[${context}] ` : '';
                    const metaStr = Object.keys(meta).length ? ` ${JSON.stringify(meta)}` : '';
                    return `${timestamp} ${level}: ${contextStr}${message}${metaStr}`;
                })),
            }),
        ];
        if (process.env.NODE_ENV === 'production') {
            transports.push(new DailyRotateFile({
                filename: `${logDir}/error-%DATE%.log`,
                datePattern: 'YYYY-MM-DD',
                level: 'error',
                maxSize: '20m',
                maxFiles: '14d',
                format: winston.format.combine(winston.format.timestamp(), winston.format.json()),
            }));
            transports.push(new DailyRotateFile({
                filename: `${logDir}/combined-%DATE%.log`,
                datePattern: 'YYYY-MM-DD',
                maxSize: '20m',
                maxFiles: '30d',
                format: winston.format.combine(winston.format.timestamp(), winston.format.json()),
            }));
            transports.push(new DailyRotateFile({
                filename: `${logDir}/access-%DATE%.log`,
                datePattern: 'YYYY-MM-DD',
                level: 'http',
                maxSize: '20m',
                maxFiles: '7d',
                format: winston.format.combine(winston.format.timestamp(), winston.format.json()),
            }));
        }
        return winston.createLogger({
            level: logLevel,
            format: winston.format.combine(winston.format.timestamp(), winston.format.errors({ stack: true }), winston.format.json()),
            transports,
            exceptionHandlers: [
                new winston.transports.File({ filename: `${logDir}/exceptions.log` }),
            ],
            rejectionHandlers: [
                new winston.transports.File({ filename: `${logDir}/rejections.log` }),
            ],
        });
    }
    log(message, context, meta) {
        this.logger.info(message, { context, ...meta });
    }
    error(message, trace, context, meta) {
        this.logger.error(message, { context, trace, ...meta });
    }
    warn(message, context, meta) {
        this.logger.warn(message, { context, ...meta });
    }
    debug(message, context, meta) {
        this.logger.debug(message, { context, ...meta });
    }
    verbose(message, context, meta) {
        this.logger.verbose(message, { context, ...meta });
    }
    logRequest(method, url, statusCode, responseTime, context) {
        this.logger.http('HTTP Request', {
            method,
            url,
            statusCode,
            responseTime,
            ...context,
        });
    }
    logError(error, context, meta) {
        this.logger.error(error.message, {
            context,
            stack: error.stack,
            name: error.name,
            ...meta,
        });
    }
    logSecurity(event, context) {
        this.logger.warn(`Security Event: ${event}`, {
            context: 'SECURITY',
            ...context,
        });
    }
    logPerformance(operation, duration, context) {
        this.logger.info(`Performance: ${operation}`, {
            context: 'PERFORMANCE',
            duration,
            ...context,
        });
    }
    logDatabase(query, duration, context) {
        this.logger.debug(`Database Query: ${query}`, {
            context: 'DATABASE',
            duration,
            ...context,
        });
    }
    logCache(operation, key, hit, context) {
        this.logger.debug(`Cache ${operation}: ${key}`, {
            context: 'CACHE',
            hit,
            ...context,
        });
    }
    logAuth(action, userId, success, context) {
        this.logger.info(`Auth ${action}`, {
            context: 'AUTH',
            userId,
            success,
            ...context,
        });
    }
    logBusiness(event, context) {
        this.logger.info(`Business Event: ${event}`, {
            context: 'BUSINESS',
            ...context,
        });
    }
    logAnalytics(event, properties, context) {
        this.logger.info(`Analytics: ${event}`, {
            context: 'ANALYTICS',
            properties,
            ...context,
        });
    }
    logHealth(service, status, details) {
        this.logger.info(`Health Check: ${service}`, {
            context: 'HEALTH',
            status,
            details,
        });
    }
    logAudit(action, resource, userId, context) {
        this.logger.info(`Audit: ${action} on ${resource}`, {
            context: 'AUDIT',
            action,
            resource,
            userId,
            ...context,
        });
    }
    getLogger() {
        return this.logger;
    }
};
exports.AppLoggerService = AppLoggerService;
exports.AppLoggerService = AppLoggerService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [config_1.ConfigService])
], AppLoggerService);
//# sourceMappingURL=app-logger.service.js.map