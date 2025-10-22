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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RedisService = void 0;
const common_1 = require("@nestjs/common");
const ioredis_1 = require("@nestjs-modules/ioredis");
const ioredis_2 = require("ioredis");
let RedisService = class RedisService {
    constructor(redis) {
        this.redis = redis;
    }
    async get(key) {
        try {
            return await this.redis.get(key);
        }
        catch (error) {
            console.error('Redis GET error:', error);
            return null;
        }
    }
    async set(key, value, ttl) {
        try {
            if (ttl) {
                await this.redis.setex(key, ttl, value);
            }
            else {
                await this.redis.set(key, value);
            }
            return true;
        }
        catch (error) {
            console.error('Redis SET error:', error);
            return false;
        }
    }
    async setex(key, seconds, value) {
        try {
            await this.redis.setex(key, seconds, value);
            return true;
        }
        catch (error) {
            console.error('Redis SETEX error:', error);
            return false;
        }
    }
    async del(key) {
        try {
            await this.redis.del(key);
            return true;
        }
        catch (error) {
            console.error('Redis DEL error:', error);
            return false;
        }
    }
    async exists(key) {
        try {
            const result = await this.redis.exists(key);
            return result === 1;
        }
        catch (error) {
            console.error('Redis EXISTS error:', error);
            return false;
        }
    }
    async expire(key, seconds) {
        try {
            await this.redis.expire(key, seconds);
            return true;
        }
        catch (error) {
            console.error('Redis EXPIRE error:', error);
            return false;
        }
    }
    async keys(pattern) {
        try {
            return await this.redis.keys(pattern);
        }
        catch (error) {
            console.error('Redis KEYS error:', error);
            return [];
        }
    }
    async flushdb() {
        try {
            await this.redis.flushdb();
            return true;
        }
        catch (error) {
            console.error('Redis FLUSHDB error:', error);
            return false;
        }
    }
    async info() {
        try {
            return await this.redis.info();
        }
        catch (error) {
            console.error('Redis INFO error:', error);
            return '';
        }
    }
    async hget(key, field) {
        try {
            return await this.redis.hget(key, field);
        }
        catch (error) {
            console.error('Redis HGET error:', error);
            return null;
        }
    }
    async hset(key, field, value) {
        try {
            await this.redis.hset(key, field, value);
            return true;
        }
        catch (error) {
            console.error('Redis HSET error:', error);
            return false;
        }
    }
    async hgetall(key) {
        try {
            return await this.redis.hgetall(key);
        }
        catch (error) {
            console.error('Redis HGETALL error:', error);
            return {};
        }
    }
    async hdel(key, field) {
        try {
            await this.redis.hdel(key, field);
            return true;
        }
        catch (error) {
            console.error('Redis HDEL error:', error);
            return false;
        }
    }
    async lpush(key, ...values) {
        try {
            return await this.redis.lpush(key, ...values);
        }
        catch (error) {
            console.error('Redis LPUSH error:', error);
            return 0;
        }
    }
    async rpush(key, ...values) {
        try {
            return await this.redis.rpush(key, ...values);
        }
        catch (error) {
            console.error('Redis RPUSH error:', error);
            return 0;
        }
    }
    async lpop(key) {
        try {
            return await this.redis.lpop(key);
        }
        catch (error) {
            console.error('Redis LPOP error:', error);
            return null;
        }
    }
    async rpop(key) {
        try {
            return await this.redis.rpop(key);
        }
        catch (error) {
            console.error('Redis RPOP error:', error);
            return null;
        }
    }
    async lrange(key, start, stop) {
        try {
            return await this.redis.lrange(key, start, stop);
        }
        catch (error) {
            console.error('Redis LRANGE error:', error);
            return [];
        }
    }
    async sadd(key, ...members) {
        try {
            return await this.redis.sadd(key, ...members);
        }
        catch (error) {
            console.error('Redis SADD error:', error);
            return 0;
        }
    }
    async srem(key, ...members) {
        try {
            return await this.redis.srem(key, ...members);
        }
        catch (error) {
            console.error('Redis SREM error:', error);
            return 0;
        }
    }
    async smembers(key) {
        try {
            return await this.redis.smembers(key);
        }
        catch (error) {
            console.error('Redis SMEMBERS error:', error);
            return [];
        }
    }
    async sismember(key, member) {
        try {
            const result = await this.redis.sismember(key, member);
            return result === 1;
        }
        catch (error) {
            console.error('Redis SISMEMBER error:', error);
            return false;
        }
    }
    async zadd(key, score, member) {
        try {
            return await this.redis.zadd(key, score, member);
        }
        catch (error) {
            console.error('Redis ZADD error:', error);
            return 0;
        }
    }
    async zrem(key, member) {
        try {
            return await this.redis.zrem(key, member);
        }
        catch (error) {
            console.error('Redis ZREM error:', error);
            return 0;
        }
    }
    async zrange(key, start, stop) {
        try {
            return await this.redis.zrange(key, start, stop);
        }
        catch (error) {
            console.error('Redis ZRANGE error:', error);
            return [];
        }
    }
    async zrevrange(key, start, stop) {
        try {
            return await this.redis.zrevrange(key, start, stop);
        }
        catch (error) {
            console.error('Redis ZREVRANGE error:', error);
            return [];
        }
    }
    async cacheUserSession(userId, sessionData, ttl = 3600) {
        const key = `session:${userId}`;
        return this.setex(key, ttl, JSON.stringify(sessionData));
    }
    async getUserSession(userId) {
        const key = `session:${userId}`;
        const data = await this.get(key);
        return data ? JSON.parse(data) : null;
    }
    async invalidateUserCache(userId) {
        const patterns = [
            `cache:*:${userId}:*`,
            `session:${userId}`,
            `user:${userId}:*`,
        ];
        for (const pattern of patterns) {
            const keys = await this.keys(pattern);
            if (keys.length > 0) {
                await this.redis.del(...keys);
            }
        }
    }
    async cacheQueryResult(queryKey, result, ttl = 300) {
        const key = `query:${queryKey}`;
        return this.setex(key, ttl, JSON.stringify(result));
    }
    async getCachedQueryResult(queryKey) {
        const key = `query:${queryKey}`;
        const data = await this.get(key);
        return data ? JSON.parse(data) : null;
    }
    async invalidatePattern(pattern) {
        const keys = await this.keys(pattern);
        if (keys.length > 0) {
            await this.redis.del(...keys);
        }
    }
};
exports.RedisService = RedisService;
exports.RedisService = RedisService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, ioredis_1.InjectRedis)()),
    __metadata("design:paramtypes", [ioredis_2.default])
], RedisService);
//# sourceMappingURL=redis.service.js.map