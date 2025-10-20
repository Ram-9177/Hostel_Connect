"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GatePassModule = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const gatepass_controller_1 = require("./gatepass.controller");
const gatepass_service_1 = require("./gatepass.service");
const gate_pass_entity_1 = require("./entities/gate-pass.entity");
const ad_event_entity_1 = require("../ads/entities/ad-event.entity");
const qr_token_service_1 = require("../common/utils/qr-token.service");
const users_module_1 = require("../users/users.module");
let GatePassModule = class GatePassModule {
};
exports.GatePassModule = GatePassModule;
exports.GatePassModule = GatePassModule = __decorate([
    (0, common_1.Module)({
        imports: [
            typeorm_1.TypeOrmModule.forFeature([gate_pass_entity_1.GatePass, ad_event_entity_1.AdEvent]),
            users_module_1.UsersModule,
        ],
        controllers: [gatepass_controller_1.GatePassController],
        providers: [gatepass_service_1.GatePassService, qr_token_service_1.QRTokenService],
        exports: [gatepass_service_1.GatePassService],
    })
], GatePassModule);
//# sourceMappingURL=gatepass.module.js.map