import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { TransformInterceptor } from './common/interceptors/transform.interceptor';
import helmet from 'helmet';
import * as compression from 'compression';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Security middleware
  app.use(helmet());
  app.use(compression());

  // Global pipes
  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
    }),
  );

  // Global filters and interceptors
  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalInterceptors(new TransformInterceptor());
  
  // Remove any global authentication guards
  // app.useGlobalGuards() - commented out to allow auth endpoints

  // Global prefix
  app.setGlobalPrefix('api/v1');

  // CORS configuration for mobile app
  app.enableCors({
    origin: [
      'http://localhost:3000',
      'http://localhost:3001', 
      'http://localhost:3002',
      'http://localhost:3003',
      'http://localhost:3004',
      'http://10.0.2.2:3000', // Android emulator
      'http://10.0.2.2:3001',
      'http://10.0.2.2:3002', 
      'http://10.0.2.2:3003',
      'http://10.0.2.2:3004',
      /^http:\/\/192\.168\.\d+\.\d+:\d+$/, // Local network for real devices
      /^http:\/\/10\.\d+\.\d+\.\d+:\d+$/, // Local network
    ],
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept'],
  });

  // Enhanced Swagger documentation
  const config = new DocumentBuilder()
    .setTitle('HostelConnect API')
    .setDescription(`
# HostelConnect - Production-Ready Hostel Management System API

## Overview
HostelConnect is a comprehensive hostel management system providing complete solutions for:
- **Student Management**: Registration, profiles, room allocation
- **Room Management**: Allocation, transfers, occupancy tracking
- **Gate Pass System**: Request → Approve → Track workflow
- **Attendance System**: QR code scanning and analytics
- **Meal Management**: Intent submission and forecasting
- **Real-Time Notifications**: Socket.IO live updates
- **File Management**: Profile pictures and document uploads
- **Analytics**: ML-powered insights and predictions

## Authentication
All endpoints require JWT authentication except for login and registration.
Include the JWT token in the Authorization header: \`Bearer <token>\`

## Rate Limiting
API requests are limited to 100 requests per minute per IP address.

## Real-Time Features
WebSocket connections are available at \`/notifications\` namespace for real-time updates.

## File Uploads
File uploads support images and documents with automatic validation and processing.

## Analytics
Advanced analytics with machine learning predictions for occupancy, attendance, meals, and gate passes.
    `)
    .setVersion('1.0.0')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'JWT',
        description: 'Enter JWT token',
        in: 'header',
      },
      'JWT-auth',
    )
    .addTag('Authentication', 'User authentication and authorization')
    .addTag('Users', 'User management operations')
    .addTag('Students', 'Student-specific operations')
    .addTag('Hostels', 'Hostel management operations')
    .addTag('Rooms', 'Room management and allocation')
    .addTag('Gate Passes', 'Gate pass request and approval system')
    .addTag('Attendance', 'Attendance tracking and analytics')
    .addTag('Meals', 'Meal management and forecasting')
    .addTag('Notices', 'Notice board and announcements')
    .addTag('Notifications', 'Real-time notifications and push notifications')
    .addTag('Files', 'File upload and management')
    .addTag('Analytics', 'Advanced analytics and ML predictions')
    .addTag('Health', 'System health and monitoring')
    .addServer('http://localhost:3000', 'Development server')
    .addServer('https://api.hostelconnect.com', 'Production server')
    .build();
  
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document, {
    swaggerOptions: {
      persistAuthorization: true,
      displayRequestDuration: true,
      docExpansion: 'none',
      filter: true,
      showRequestHeaders: true,
      showCommonExtensions: true,
      tryItOutEnabled: true,
    },
    customSiteTitle: 'HostelConnect API Documentation',
    customfavIcon: '/favicon.ico',
    customCss: `
      .swagger-ui .topbar { display: none }
      .swagger-ui .info .title { color: #2563eb; }
      .swagger-ui .scheme-container { background: #f8fafc; padding: 20px; border-radius: 8px; }
    `,
  });

  const port = process.env.PORT || 3000;
  const host = process.env.HOST || '0.0.0.0';
  await app.listen(port, host);
  
  console.log(`🚀 HostelConnect API running on ${host}:${port}`);
  console.log(`📚 API Documentation: http://localhost:${port}/api`);
  console.log(`🔗 WebSocket Endpoint: ws://localhost:${port}/notifications`);
}