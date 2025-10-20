import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DashboardsController } from './dashboards.controller';
import { DashboardsService } from './dashboards.service';
import { BullModule } from '@nestjs/bull';
import { RefreshWorker } from './refresh.worker';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT) || 5432,
      username: process.env.DB_USERNAME || 'postgres',
      password: process.env.DB_PASSWORD || 'postgres',
      database: process.env.DB_NAME || 'hostelconnect',
      entities: [__dirname + '/../**/*.entity{.ts,.js}'],
      synchronize: process.env.NODE_ENV === 'development',
    }),
    BullModule.registerQueue({
      name: 'refresh',
    }),
  ],
  controllers: [DashboardsController],
  providers: [DashboardsService, RefreshWorker],
  exports: [DashboardsService],
})
export class DashboardsModule {}
