import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, Request, ForbiddenException, UseInterceptors, UploadedFile, BadRequestException } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiParam, ApiConsumes } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { StudentsService } from './students.service';
import { BulkStudentDto, UpdateStudentDto, ResetPasswordDto } from './dto/bulk-student.dto';
import * as csv from 'csv-parser';
import { Readable } from 'stream';

@ApiTags('Students')
@Controller('students')
@UseGuards(AuthGuard('jwt'))
@ApiBearerAuth()
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  private checkAdminPermission(role: string): boolean {
    return ['SUPER_ADMIN', 'WARDEN_HEAD', 'WARDEN'].includes(role);
  }

  private checkSuperAdminPermission(role: string): boolean {
    return ['SUPER_ADMIN'].includes(role);
  }

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

  @Post('bulk-upload')
  @ApiOperation({ summary: 'Bulk upload students from CSV (Admin/Warden only)' })
  @ApiConsumes('multipart/form-data')
  @ApiResponse({ status: 201, description: 'Bulk upload completed' })
  @UseInterceptors(FileInterceptor('file'))
  async bulkUploadStudents(
    @Request() req,
    @UploadedFile() file: Express.Multer.File,
  ) {
    if (!this.checkAdminPermission(req.user.role)) {
      throw new ForbiddenException('Only admins and wardens can bulk upload students');
    }

    if (!file) {
      throw new BadRequestException('CSV file is required');
    }

    // Parse CSV
    const students: BulkStudentDto[] = [];
    const stream = Readable.from(file.buffer.toString());

    return new Promise((resolve, reject) => {
      stream
        .pipe(csv())
        .on('data', (row) => {
          // Map CSV columns to DTO
          // Expected columns: Name, Hall Ticket, College code, Number, Hostel Name
          students.push({
            name: row['Name'] || row['name'],
            hallTicket: row['Hall Ticket'] || row['Hall ticket'] || row['hall_ticket'],
            collegeCode: row['College code'] || row['College Code'] || row['college_code'],
            number: row['Number'] || row['number'] || row['Phone'],
            hostelName: row['Hostel Name'] || row['Hostel name'] || row['hostel_name'],
          });
        })
        .on('end', async () => {
          try {
            const result = await this.studentsService.bulkCreateStudents(students, req.user.id);
            resolve({
              success: true,
              message: `Bulk upload completed. Created: ${result.created}, Errors: ${result.errors.length}`,
              created: result.created,
              errors: result.errors,
            });
          } catch (error) {
            reject(error);
          }
        })
        .on('error', (error) => {
          reject(new BadRequestException('Failed to parse CSV file'));
        });
    });
  }

  @Put('manage/:id')
  @ApiOperation({ summary: 'Update student data (Admin/Warden only)' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student updated successfully' })
  async updateStudentData(
    @Request() req,
    @Param('id') id: string,
    @Body() updateDto: UpdateStudentDto,
  ) {
    if (!this.checkAdminPermission(req.user.role)) {
      throw new ForbiddenException('Only admins and wardens can update student data');
    }

    return this.studentsService.updateStudentData(id, updateDto);
  }

  @Post('reset-password')
  @ApiOperation({ summary: 'Reset student password (Admin/Warden only)' })
  @ApiResponse({ status: 200, description: 'Password reset successfully' })
  async resetPassword(
    @Request() req,
    @Body() resetDto: ResetPasswordDto,
  ) {
    if (!this.checkAdminPermission(req.user.role)) {
      throw new ForbiddenException('Only admins and wardens can reset passwords');
    }

    return this.studentsService.resetStudentPassword(resetDto);
  }

  @Delete('manage/:id/deactivate')
  @ApiOperation({ summary: 'Deactivate student account (Admin/Warden only)' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student deactivated successfully' })
  async deactivateStudent(
    @Request() req,
    @Param('id') id: string,
  ) {
    if (!this.checkAdminPermission(req.user.role)) {
      throw new ForbiddenException('Only admins and wardens can deactivate students');
    }

    return this.studentsService.deleteStudentAccount(id, req.user.id);
  }

  @Delete('manage/:id/permanent')
  @ApiOperation({ summary: 'Permanently delete student (Super Admin only)' })
  @ApiParam({ name: 'id', description: 'Student ID' })
  @ApiResponse({ status: 200, description: 'Student permanently deleted' })
  async permanentlyDeleteStudent(
    @Request() req,
    @Param('id') id: string,
  ) {
    if (!this.checkSuperAdminPermission(req.user.role)) {
      throw new ForbiddenException('Only super admins can permanently delete students');
    }

    return this.studentsService.permanentlyDeleteStudent(id);
  }
}
