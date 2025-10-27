"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const typeorm_1 = require("@nestjs/typeorm");
const bull_1 = require("@nestjs/bull");
const throttler_1 = require("@nestjs/throttler");
const schedule_1 = require("@nestjs/schedule");
const socket_module_1 = require("./socket/socket.module");
const auth_bypass_middleware_1 = require("./common/middleware/auth-bypass.middleware");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const auth_module_1 = require("./auth/auth.module");
const users_module_1 = require("./users/users.module");
const ads_module_1 = require("./ads/ads.module");
const notices_module_1 = require("./notices/notices.module");
const rooms_module_1 = require("./rooms/rooms.module");
const hostels_module_1 = require("./hostels/hostels.module");
const students_module_1 = require("./students/students.module");
const gatepass_module_1 = require("./gatepass/gatepass.module");
const wardens_module_1 = require("./wardens/wardens.module");
const chefs_module_1 = require("./chefs/chefs.module");
const admins_module_1 = require("./admins/admins.module");
const gate_module_1 = require("./gate/gate.module");
const notifications_module_1 = require("./notifications/notifications.module");
const files_module_1 = require("./files/files.module");
const analytics_module_1 = require("./analytics/analytics.module");
const data_source_1 = require("./database/data-source");
let AppModule = class AppModule {
    configure(consumer) {
        consumer
            .apply(auth_bypass_middleware_1.AuthBypassMiddleware)
            .forRoutes('*');
    }
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            config_1.ConfigModule.forRoot({
                isGlobal: true,
                envFilePath: '.env',
            }),
            typeorm_1.TypeOrmModule.forRoot(data_source_1.dataSourceOptions),
            ...(process.env.REDIS_URL ? [bull_1.BullModule.forRoot({
                    redis: {
                        host: process.env.REDIS_HOST || 'localhost',
                        port: parseInt(process.env.REDIS_PORT) || 6379,
                        password: process.env.REDIS_PASSWORD,
                    },
                })] : []),
            throttler_1.ThrottlerModule.forRoot([
                {
                    ttl: 60000,
                    limit: 100,
                },
            ]),
            schedule_1.ScheduleModule.forRoot(),
            socket_module_1.SocketModule,
            notifications_module_1.NotificationsModule,
            files_module_1.FilesModule,
            analytics_module_1.AnalyticsModule,
            auth_module_1.AuthModule,
            users_module_1.UsersModule,
            ads_module_1.AdsModule,
            notices_module_1.NoticesModule,
            rooms_module_1.RoomsModule,
            hostels_module_1.HostelsModule,
            students_module_1.StudentsModule,
            gatepass_module_1.GatePassModule,
            wardens_module_1.WardensModule,
            chefs_module_1.ChefsModule,
            admins_module_1.AdminsModule,
            gate_module_1.GateModule,
        ],
        controllers: [app_controller_1.AppController],
        providers: [app_service_1.AppService],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map