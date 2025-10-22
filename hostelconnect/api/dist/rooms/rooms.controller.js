"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RoomsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const rooms_service_1 = require("./rooms.service");
let RoomsController = class RoomsController {
    constructor(roomsService) {
        this.roomsService = roomsService;
    }
    async getMap(hostelId) {
        return this.roomsService.getMap(hostelId);
    }
    async getAvailableRooms(hostelId) {
        return this.roomsService.getAvailableRooms(hostelId);
    }
    async getRoomDetails(id) {
        return this.roomsService.getRoomDetails(id);
    }
    async allocate(allocateDto) {
        return this.roomsService.allocate(allocateDto);
    }
    async transfer(transferDto) {
        return this.roomsService.transfer(transferDto);
    }
    async swap(swapDto) {
        return this.roomsService.swap(swapDto);
    }
};
exports.RoomsController = RoomsController;
__decorate([
    (0, common_1.Get)('map'),
    (0, swagger_1.ApiOperation)({ summary: 'Get room occupancy map' }),
    (0, swagger_1.ApiQuery)({ name: 'hostelId', required: false, description: 'Filter by hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room map retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "getMap", null);
__decorate([
    (0, common_1.Get)('available'),
    (0, swagger_1.ApiOperation)({ summary: 'Get available rooms' }),
    (0, swagger_1.ApiQuery)({ name: 'hostelId', required: false, description: 'Filter by hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Available rooms retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "getAvailableRooms", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get room details' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Room ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room details retrieved' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "getRoomDetails", null);
__decorate([
    (0, common_1.Post)('allocate'),
    (0, swagger_1.ApiOperation)({ summary: 'Allocate room to student' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Room allocated' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "allocate", null);
__decorate([
    (0, common_1.Post)('transfer'),
    (0, swagger_1.ApiOperation)({ summary: 'Transfer student to different room' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Transfer processed' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "transfer", null);
__decorate([
    (0, common_1.Post)('swap'),
    (0, swagger_1.ApiOperation)({ summary: 'Swap rooms between students' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Swap processed' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], RoomsController.prototype, "swap", null);
exports.RoomsController = RoomsController = __decorate([
    (0, swagger_1.ApiTags)('Rooms'),
    (0, common_1.Controller)('rooms'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [rooms_service_1.RoomsService])
], RoomsController);
//# sourceMappingURL=rooms.controller.js.map