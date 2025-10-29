"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GateModule = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const gate_controller_1 = require("./gate.controller");
const gate_service_1 = require("./gate.service");
const gate_event_entity_1 = require("./entities/gate-event.entity");
const gate_pass_entity_1 = require("../gatepass/entities/gate-pass.entity");
const auth_module_1 = require("../auth/auth.module");
let GateModule = class GateModule {
};
exports.GateModule = GateModule;
exports.GateModule = GateModule = __decorate([
    (0, common_1.Module)({
        imports: [
            typeorm_1.TypeOrmModule.forFeature([gate_event_entity_1.GateEvent, gate_pass_entity_1.GatePass]),
            auth_module_1.AuthModule,
        ],
        controllers: [gate_controller_1.GateController],
        providers: [gate_service_1.GateService],
        exports: [gate_service_1.GateService]
    })
], GateModule);
//# sourceMappingURL=gate.module.js.map