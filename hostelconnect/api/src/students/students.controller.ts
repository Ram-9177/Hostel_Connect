import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiParam } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { StudentsService } from './students.service';

@ApiTags('Students')
@Controller('students')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  @Get()
  @ApiOperation({ summary: 'Get all students' })
  @ApiResponse({ status: 200, description: 'Students retrieved successfully' })
  async getAllStudents() {
    return this.studentsService.getAllStudents();
  }

  @Get('unassigned')
  @ApiOperation({ summary: 'Get unassigned students' })
  @ApiResponse({ status: 200, description: 'Unassigned students retrieved successfully' })
  async getUnassignedStudents() {
    return this.studentsService.getUnassignedStudents();
  }

  @Get('hostel/:hostelId')
  @ApiOperation({ summary: 'Get students by hostel' })
  @ApiParam({ name: 'hostelId', description: 'Hostel ID' })
  @ApiResponse({ status: 200, description: 'Students retrieved successfully' })
  async getStudentsByHostel(@Param('hostelId') hostelId: string) {
    return this.studentsService.getStudentsByHostel(hostelId);
  }

  @Get('room/:roomId')
  @ApiOperation({ summary: 'Get students by room' })
  @ApiParam({ name: 'roomId', description: 'Room ID' })
  @ApiResponse({ status: 200, description: 'Students retrieved successfully' })
  async getStudentsByRoom(@Param('roomId') roomId: string) {
    return this.studentsService.getStudentsByRoom(roomId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get student by ID' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student retrieved successfully' })
  async getStudentById(@Param('id') id: string) {
    return this.studentsService.getStudentById(id);
  }

  @Put(':id')
  @ApiOperation({ summary: 'Update student' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student updated successfully' })
  async updateStudent(@Param('id') id: string, @Body() updateStudentDto: any) {
    return this.studentsService.updateStudent(id, updateStudentDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete student' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student deleted successfully' })
  async deleteStudent(@Param('id') id: string) {
    return this.studentsService.deleteStudent(id);
  }
}
