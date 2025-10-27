import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { StudentsService } from './students.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('students')
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  @Get()
  @UseGuards(JwtAuthGuard)
  async getAllStudents() {
    return this.studentsService.getAllStudents();
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  async getStudent(@Param('id') id: string) {
    return this.studentsService.getStudent(id);
  }

  @Get('by-student-id/:studentId')
  @UseGuards(JwtAuthGuard)
  async getStudentByStudentId(@Param('studentId') studentId: string) {
    return this.studentsService.getStudentByStudentId(studentId);
  }
}