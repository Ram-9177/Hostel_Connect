import { NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { RedisService } from '../services/redis.service';
export declare class CacheMiddleware implements NestMiddleware {
    private readonly redisService;
    constructor(redisService: RedisService);
    use(req: Request, res: Response, next: NextFunction): Promise<void | Response<any, Record<string, any>>>;
    private generateCacheKey;
}
