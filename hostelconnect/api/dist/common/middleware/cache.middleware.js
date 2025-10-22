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
exports.CacheMiddleware = void 0;
const common_1 = require("@nestjs/common");
const redis_service_1 = require("../services/redis.service");
let CacheMiddleware = class CacheMiddleware {
    constructor(redisService) {
        this.redisService = redisService;
    }
    async use(req, res, next) {
        if (req.method !== 'GET') {
            return next();
        }
        const cacheKey = this.generateCacheKey(req);
        try {
            const cachedData = await this.redisService.get(cacheKey);
            if (cachedData) {
                res.set({
                    'X-Cache': 'HIT',
                    'X-Cache-Key': cacheKey,
                });
                return res.json(JSON.parse(cachedData));
            }
            res.set('X-Cache', 'MISS');
            const originalJson = res.json.bind(res);
            res.json = (body) => {
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    this.redisService.setex(cacheKey, 300, JSON.stringify(body));
                }
                return originalJson(body);
            };
            next();
        }
        catch (error) {
            console.error('Cache middleware error:', error);
            next();
        }
    }
    generateCacheKey(req) {
        const { url, query, headers } = req;
        const userId = headers['x-user-id'] || 'anonymous';
        const userRole = headers['x-user-role'] || 'guest';
        const queryString = Object.keys(query).length > 0 ? `?${new URLSearchParams(query).toString()}` : '';
        return `cache:${userRole}:${userId}:${url}${queryString}`;
    }
};
exports.CacheMiddleware = CacheMiddleware;
exports.CacheMiddleware = CacheMiddleware = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [redis_service_1.RedisService])
], CacheMiddleware);
//# sourceMappingURL=cache.middleware.js.map