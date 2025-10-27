import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class AuthBypassMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    // Allow auth endpoints to pass through without authentication
    if (req.path.startsWith('/api/v1/auth/register') || 
        req.path.startsWith('/api/v1/auth/login') ||
        req.path.startsWith('/api/v1/auth/forgot-password') ||
        req.path.startsWith('/api/v1/auth/reset-password')) {
      return next();
    }
    
    // Allow health check endpoints
    if (req.path.startsWith('/api/v1/health') || 
        req.path.startsWith('/api/v1/test-notices') ||
        req.path === '/api/v1/' ||
        req.path === '/api/v1') {
      return next();
    }
    
    // For all other endpoints, continue with normal flow
    next();
  }
}
