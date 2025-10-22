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

  async getAllStudents() {
    return await this.studentRepository.find({
      order: { createdAt: 'DESC' }
    });
  }

  async getStudentById(id: string) {
    const student = await this.studentRepository.findOne({ where: { id } });
    if (!student) {
      throw new NotFoundException('Student not found');
    }
    return student;
  }

  async getStudentsByHostel(hostelId: string) {
    return await this.studentRepository.find({
      where: { hostelId },
      order: { firstName: 'ASC' }
    });
  }

  async getStudentsByRoom(roomId: string) {
    return await this.studentRepository.find({
      where: { roomId },
      order: { bedNumber: 'ASC' }
    });
  }

  async updateStudent(id: string, updateStudentDto: any) {
    const student = await this.getStudentById(id);
    Object.assign(student, updateStudentDto);
    return await this.studentRepository.save(student);
  }

  async deleteStudent(id: string) {
    const student = await this.getStudentById(id);
    await this.studentRepository.remove(student);
    return { message: 'Student deleted successfully' };
  }

  async getUnassignedStudents() {
    return await this.studentRepository.find({
      where: { roomId: null },
      order: { firstName: 'ASC' }
    });
  }
}
