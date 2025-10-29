import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, Query, Request, ForbiddenException } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiParam, ApiQuery } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { HostelsService } from './hostels.service';

@ApiTags('Hostels')
@Controller('hostels')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class HostelsController {
  constructor(private readonly hostelsService: HostelsService) {}

  // Hostel Management
  @Post()
  @ApiOperation({ summary: 'Create a new hostel' })
  @ApiResponse({ status: 201, description: 'Hostel created successfully' })
  async createHostel(@Body() createHostelDto: any) {
    return this.hostelsService.createHostel(createHostelDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all hostels' })
  @ApiResponse({ status: 200, description: 'Hostels retrieved successfully' })
  async getAllHostels() {
    return this.hostelsService.getAllHostels();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get hostel by ID' })
  @ApiParam({ name: 'id', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Hostel retrieved successfully' })
  async getHostelById(@Param('id') id: string) {
    return this.hostelsService.getHostelById(id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update hostel' })
  @ApiParam({ name: 'id', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Hostel updated successfully' })
  async updateHostel(@Param('id') id: string, @Body() updateHostelDto: any) {
    return this.hostelsService.updateHostel(id, updateHostelDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete hostel' })
  @ApiParam({ name: 'id', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Hostel deleted successfully' })
  async deleteHostel(@Param('id') id: string) {
    return this.hostelsService.deleteHostel(id);
  }

  // Block Management
  @Post(':hostelId/blocks')
  @ApiOperation({ summary: 'Create a new block in hostel' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 201, description: 'Block created successfully' })
  async createBlock(@Param('hostelId') hostelId: string, @Body() createBlockDto: any) {
    return this.hostelsService.createBlock(hostelId, createBlockDto);
  }

  @Get(':hostelId/blocks')
  @ApiOperation({ summary: 'Get all blocks in hostel' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Blocks retrieved successfully' })
  async getBlocksByHostel(@Param('hostelId') hostelId: string) {
    return this.hostelsService.getBlocksByHostel(hostelId);
  }

  @Put('blocks/:id')
  @ApiOperation({ summary: 'Update block' })
  @ApiParam({ name: 'id', description: 'Block ID' })
  @ApiResponse({ status: 200, description: 'Block updated successfully' })
  async updateBlock(@Param('id') id: string, @Body() updateBlockDto: any) {
    return this.hostelsService.updateBlock(id, updateBlockDto);
  }

  @Delete('blocks/:id')
  @ApiOperation({ summary: 'Delete block' })
  @ApiParam({ name: 'id', description: 'Block ID' })
  @ApiResponse({ status: 200, description: 'Block deleted successfully' })
  async deleteBlock(@Param('id') id: string) {
    return this.hostelsService.deleteBlock(id);
  }

  // Room Management
  @Post('blocks/:blockId/rooms')
  @ApiOperation({ summary: 'Create a new room in block' })
  @ApiParam({ name: 'blockId', description: 'Block ID' })
  @ApiResponse({ status: 201, description: 'Room created successfully' })
  async createRoom(@Request() req, @Param('blockId') blockId: string, @Body() createRoomDto: any) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot create rooms');
    }
    return this.hostelsService.createRoom(blockId, createRoomDto);
  }

  @Get('blocks/:blockId/rooms')
  @ApiOperation({ summary: 'Get all rooms in block' })
  @ApiParam({ name: 'blockId', description: 'Block ID' })
  @ApiResponse({ status: 200, description: 'Rooms retrieved successfully' })
  async getRoomsByBlock(@Param('blockId') blockId: string) {
    return this.hostelsService.getRoomsByBlock(blockId);
  }

  @Get(':hostelId/rooms')
  @ApiOperation({ summary: 'Get all rooms in hostel' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Rooms retrieved successfully' })
  async getRoomsByHostel(@Param('hostelId') hostelId: string) {
    return this.hostelsService.getRoomsByHostel(hostelId);
  }

  @Put('rooms/:id')
  @ApiOperation({ summary: 'Update room' })
  @ApiParam({ name: 'id', description: 'Room ID' })
  @ApiResponse({ status: 200, description: 'Room updated successfully' })
  async updateRoom(@Request() req, @Param('id') id: string, @Body() updateRoomDto: any) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot modify rooms');
    }
    return this.hostelsService.updateRoom(id, updateRoomDto);
  }

  @Delete('rooms/:id')
  @ApiOperation({ summary: 'Delete room' })
  @ApiParam({ name: 'id', description: 'Room ID' })
  @ApiResponse({ status: 200, description: 'Room deleted successfully' })
  async deleteRoom(@Request() req, @Param('id') id: string) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot delete rooms');
    }
    return this.hostelsService.deleteRoom(id);
  }

  // Room Allotment System
  @Post('rooms/:roomId/allocate')
  @ApiOperation({ summary: 'Allocate room to student' })
  @ApiParam({ name: 'roomId', description: 'Room ID' })
  @ApiResponse({ status: 201, description: 'Room allocated successfully' })
  async allocateRoom(@Request() req, @Param('roomId') roomId: string, @Body() allocateDto: any) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot allocate rooms');
    }
    return this.hostelsService.allocateRoom(allocateDto.studentId, roomId, allocateDto.bedNumber);
  }

  @Post('students/:studentId/transfer')
  @ApiOperation({ summary: 'Transfer student to different room' })
  @ApiParam({ name: 'studentId', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student transferred successfully' })
  async transferStudent(@Request() req, @Param('studentId') studentId: string, @Body() transferDto: any) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot transfer rooms');
    }
    return this.hostelsService.transferStudent(studentId, transferDto.newRoomId, transferDto.bedNumber);
  }

  @Post('students/swap')
  @ApiOperation({ summary: 'Swap rooms between students' })
  @ApiResponse({ status: 200, description: 'Students swapped successfully' })
  async swapStudents(@Request() req, @Body() swapDto: any) {
    if (req.user?.role === 'STUDENT') {
      throw new ForbiddenException('Students cannot swap rooms');
    }
    return this.hostelsService.swapStudents(swapDto.student1Id, swapDto.student2Id);
  }

  // Analytics and Reports
  @Get(':hostelId/analytics')
  @ApiOperation({ summary: 'Get hostel analytics' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Analytics retrieved successfully' })
  async getHostelAnalytics(@Param('hostelId') hostelId: string) {
    return this.hostelsService.getHostelAnalytics(hostelId);
  }

  @Get(':hostelId/room-map')
  @ApiOperation({ summary: 'Get room map for hostel' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Room map retrieved successfully' })
  async getRoomMap(@Param('hostelId') hostelId: string) {
    return this.hostelsService.getRoomMap(hostelId);
  }
}
