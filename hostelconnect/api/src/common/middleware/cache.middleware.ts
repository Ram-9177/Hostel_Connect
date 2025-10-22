import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { RedisService } from '../services/redis.service';

@Injectable()
export class CacheMiddleware implements NestMiddleware {
  constructor(private readonly redisService: RedisService) {}

  async use(req: Request, res: Response, next: NextFunction) {
    // Only cache GET requests
    if (req.method !== 'GET') {
      return next();
    }

    const cacheKey = this.generateCacheKey(req);
    
    try {
      // Try to get from cache
      const cachedData = await this.redisService.get(cacheKey);
      
      if (cachedData) {
        // Set cache headers
        res.set({
          'X-Cache': 'HIT',
          'X-Cache-Key': cacheKey,
        });
        
        return res.json(JSON.parse(cachedData));
      }

      // Cache miss - continue to controller
      res.set('X-Cache', 'MISS');
      
      // Override res.json to cache the response
      const originalJson = res.json.bind(res);
      res.json = (body: any) => {
        // Cache successful responses
        if (res.statusCode >= 200 && res.statusCode < 300) {
          this.redisService.setex(cacheKey, 300, JSON.stringify(body)); // 5 minutes
        }
        return originalJson(body);
      };

      next();
    } catch (error) {
      // If Redis fails, continue without caching
      console.error('Cache middleware error:', error);
      next();
    }
  }

  private generateCacheKey(req: Request): string {
    const { url, query, headers } = req;
    const userId = headers['x-user-id'] || 'anonymous';
    const userRole = headers['x-user-role'] || 'guest';
    
    // Create a unique cache key based on URL, query params, and user context
    const queryString = Object.keys(query).length > 0 ? `?${new URLSearchParams(query as any).toString()}` : '';
    return `cache:${userRole}:${userId}:${url}${queryString}`;
  }
}
