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
exports.HostelsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const hostels_service_1 = require("./hostels.service");
let HostelsController = class HostelsController {
    constructor(hostelsService) {
        this.hostelsService = hostelsService;
    }
    async createHostel(createHostelDto) {
        return this.hostelsService.createHostel(createHostelDto);
    }
    async getAllHostels() {
        return this.hostelsService.getAllHostels();
    }
    async getHostelById(id) {
        return this.hostelsService.getHostelById(id);
    }
    async updateHostel(id, updateHostelDto) {
        return this.hostelsService.updateHostel(id, updateHostelDto);
    }
    async deleteHostel(id) {
        return this.hostelsService.deleteHostel(id);
    }
    async createBlock(hostelId, createBlockDto) {
        return this.hostelsService.createBlock(hostelId, createBlockDto);
    }
    async getBlocksByHostel(hostelId) {
        return this.hostelsService.getBlocksByHostel(hostelId);
    }
    async updateBlock(id, updateBlockDto) {
        return this.hostelsService.updateBlock(id, updateBlockDto);
    }
    async deleteBlock(id) {
        return this.hostelsService.deleteBlock(id);
    }
    async createRoom(blockId, createRoomDto) {
        return this.hostelsService.createRoom(blockId, createRoomDto);
    }
    async getRoomsByBlock(blockId) {
        return this.hostelsService.getRoomsByBlock(blockId);
    }
    async getRoomsByHostel(hostelId) {
        return this.hostelsService.getRoomsByHostel(hostelId);
    }
    async updateRoom(id, updateRoomDto) {
        return this.hostelsService.updateRoom(id, updateRoomDto);
    }
    async deleteRoom(id) {
        return this.hostelsService.deleteRoom(id);
    }
    async allocateRoom(roomId, allocateDto) {
        return this.hostelsService.allocateRoom(allocateDto.studentId, roomId, allocateDto.bedNumber);
    }
    async transferStudent(studentId, transferDto) {
        return this.hostelsService.transferStudent(studentId, transferDto.newRoomId, transferDto.bedNumber);
    }
    async swapStudents(swapDto) {
        return this.hostelsService.swapStudents(swapDto.student1Id, swapDto.student2Id);
    }
    async getHostelAnalytics(hostelId) {
        return this.hostelsService.getHostelAnalytics(hostelId);
    }
    async getRoomMap(hostelId) {
        return this.hostelsService.getRoomMap(hostelId);
    }
};
exports.HostelsController = HostelsController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new hostel' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Hostel created successfully' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "createHostel", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get all hostels' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Hostels retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getAllHostels", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get hostel by ID' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Hostel retrieved successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getHostelById", null);
__decorate([
    (0, common_1.Put)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update hostel' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Hostel updated successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "updateHostel", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete hostel' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Hostel deleted successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "deleteHostel", null);
__decorate([
    (0, common_1.Post)(':hostelId/blocks'),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new block in hostel' }),
    (0, swagger_1.ApiParam)({ name: 'hostelId', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Block created successfully' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "createBlock", null);
__decorate([
    (0, common_1.Get)(':hostelId/blocks'),
    (0, swagger_1.ApiOperation)({ summary: 'Get all blocks in hostel' }),
    (0, swagger_1.ApiParam)({ name: 'hostelId', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Blocks retrieved successfully' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getBlocksByHostel", null);
__decorate([
    (0, common_1.Put)('blocks/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update block' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Block ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Block updated successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "updateBlock", null);
__decorate([
    (0, common_1.Delete)('blocks/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete block' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Block ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Block deleted successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "deleteBlock", null);
__decorate([
    (0, common_1.Post)('blocks/:blockId/rooms'),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new room in block' }),
    (0, swagger_1.ApiParam)({ name: 'blockId', description: 'Block ID' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Room created successfully' }),
    __param(0, (0, common_1.Param)('blockId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "createRoom", null);
__decorate([
    (0, common_1.Get)('blocks/:blockId/rooms'),
    (0, swagger_1.ApiOperation)({ summary: 'Get all rooms in block' }),
    (0, swagger_1.ApiParam)({ name: 'blockId', description: 'Block ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Rooms retrieved successfully' }),
    __param(0, (0, common_1.Param)('blockId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getRoomsByBlock", null);
__decorate([
    (0, common_1.Get)(':hostelId/rooms'),
    (0, swagger_1.ApiOperation)({ summary: 'Get all rooms in hostel' }),
    (0, swagger_1.ApiParam)({ name: 'hostelId', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Rooms retrieved successfully' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getRoomsByHostel", null);
__decorate([
    (0, common_1.Put)('rooms/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update room' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Room ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room updated successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "updateRoom", null);
__decorate([
    (0, common_1.Delete)('rooms/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete room' }),
    (0, swagger_1.ApiParam)({ name: 'id', description: 'Room ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room deleted successfully' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "deleteRoom", null);
__decorate([
    (0, common_1.Post)('rooms/:roomId/allocate'),
    (0, swagger_1.ApiOperation)({ summary: 'Allocate room to student' }),
    (0, swagger_1.ApiParam)({ name: 'roomId', description: 'Room ID' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Room allocated successfully' }),
    __param(0, (0, common_1.Param)('roomId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "allocateRoom", null);
__decorate([
    (0, common_1.Post)('students/:studentId/transfer'),
    (0, swagger_1.ApiOperation)({ summary: 'Transfer student to different room' }),
    (0, swagger_1.ApiParam)({ name: 'studentId', description: 'Student ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Student transferred successfully' }),
    __param(0, (0, common_1.Param)('studentId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "transferStudent", null);
__decorate([
    (0, common_1.Post)('students/swap'),
    (0, swagger_1.ApiOperation)({ summary: 'Swap rooms between students' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Students swapped successfully' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "swapStudents", null);
__decorate([
    (0, common_1.Get)(':hostelId/analytics'),
    (0, swagger_1.ApiOperation)({ summary: 'Get hostel analytics' }),
    (0, swagger_1.ApiParam)({ name: 'hostelId', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Analytics retrieved successfully' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getHostelAnalytics", null);
__decorate([
    (0, common_1.Get)(':hostelId/room-map'),
    (0, swagger_1.ApiOperation)({ summary: 'Get room map for hostel' }),
    (0, swagger_1.ApiParam)({ name: 'hostelId', description: 'Hostel ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room map retrieved successfully' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], HostelsController.prototype, "getRoomMap", null);
exports.HostelsController = HostelsController = __decorate([
    (0, swagger_1.ApiTags)('Hostels'),
    (0, common_1.Controller)('hostels'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [hostels_service_1.HostelsService])
], HostelsController);
//# sourceMappingURL=hostels.controller.js.map