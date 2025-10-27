import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Student } from './entities/student.entity';

@Injectable()
export class StudentsService {
  constructor(
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
  ) {}

  async getAllStudents(): Promise<Student[]> {
    return this.studentRepository.find({
      order: { createdAt: 'DESC' }
    });
  }

  async getStudent(id: string): Promise<Student> {
    const student = await this.studentRepository.findOne({ where: { id } });
    
    if (!student) {
      throw new NotFoundException('Student not found');
    }
    
    return student;
  }

  async getStudentByStudentId(studentId: string): Promise<Student> {
    const student = await this.studentRepository.findOne({ where: { studentId } });
    
    if (!student) {
      throw new NotFoundException('Student not found');
    }
    
    return student;
  }
}