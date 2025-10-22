"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const core_1 = require("@nestjs/core");
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const app_module_1 = require("./app.module");
const http_exception_filter_1 = require("./common/filters/http-exception.filter");
const transform_interceptor_1 = require("./common/interceptors/transform.interceptor");
const helmet_1 = require("helmet");
const compression = require("compression");
async function bootstrap() {
    const app = await core_1.NestFactory.create(app_module_1.AppModule);
    app.use((0, helmet_1.default)());
    app.use(compression());
    app.useGlobalPipes(new common_1.ValidationPipe({
        transform: true,
        whitelist: true,
        forbidNonWhitelisted: true,
    }));
    app.useGlobalFilters(new http_exception_filter_1.HttpExceptionFilter());
    app.useGlobalInterceptors(new transform_interceptor_1.TransformInterceptor());
    app.setGlobalPrefix('api/v1');
    app.enableCors({
        origin: true,
        credentials: true,
    });
    const config = new swagger_1.DocumentBuilder()
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
        .addBearerAuth({
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'JWT',
        description: 'Enter JWT token',
        in: 'header',
    }, 'JWT-auth')
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
    const document = swagger_1.SwaggerModule.createDocument(app, config);
    swagger_1.SwaggerModule.setup('api', app, document, {
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
//# sourceMappingURL=main.js.map