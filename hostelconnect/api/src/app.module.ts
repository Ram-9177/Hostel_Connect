import { Module, MiddlewareConsumer, NestModule } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BullModule } from '@nestjs/bull';
import { ThrottlerModule } from '@nestjs/throttler';
import { ScheduleModule } from '@nestjs/schedule';
import { SocketModule } from './socket/socket.module';
import { AuthBypassMiddleware } from './common/middleware/auth-bypass.middleware';

import { AppController } from './app.controller';
import { AppService } from './app.service';

// Core modules (simplified for demo)
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { AdsModule } from './ads/ads.module';
import { NoticesModule } from './notices/notices.module';
import { RoomsModule } from './rooms/rooms.module';
import { HostelsModule } from './hostels/hostels.module';
import { StudentsModule } from './students/students.module';
import { GatePassModule } from './gatepass/gatepass.module';
import { WardensModule } from './wardens/wardens.module';
import { ChefsModule } from './chefs/chefs.module';
import { AdminsModule } from './admins/admins.module';
import { GateModule } from './gate/gate.module';
import { NotificationsModule } from './notifications/notifications.module';
import { FilesModule } from './files/files.module';
import { AnalyticsModule } from './analytics/analytics.module';

// Database configuration
import { dataSourceOptions } from './database/data-source';

@Module({
  imports: [
    // Configuration
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),

    // Database
    TypeOrmModule.forRoot(dataSourceOptions),

    // Redis/Bull Queue (optional for development)
    ...(process.env.REDIS_URL ? [BullModule.forRoot({
      redis: {
        host: process.env.REDIS_HOST || 'localhost',
        port: parseInt(process.env.REDIS_PORT) || 6379,
        password: process.env.REDIS_PASSWORD,
      },
    })] : []),

    // Rate limiting
    ThrottlerModule.forRoot([
      {
        ttl: 60000, // 1 minute
        limit: 100, // 100 requests per minute
      },
    ]),

    // Task scheduling
    ScheduleModule.forRoot(),

    // Real-time features
    SocketModule,
    NotificationsModule,
    FilesModule,
    AnalyticsModule,

    // Feature modules (simplified for demo)
    AuthModule,
    UsersModule,
    AdsModule,
    NoticesModule,
    RoomsModule,
    HostelsModule,
    StudentsModule,
    GatePassModule,
    WardensModule,
    ChefsModule,
    AdminsModule,
    GateModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(AuthBypassMiddleware)
      .forRoutes('*');
  }
}