import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Student } from './entities/student.entity';
import { Hostel } from '../hostels/entities/hostel.entity';
import { User } from '../users/entities/user.entity';
import * as bcrypt from 'bcrypt';
import { BulkStudentDto, UpdateStudentDto, ResetPasswordDto } from './dto/bulk-student.dto';

@Injectable()
export class StudentsService {
  constructor(
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @InjectRepository(Hostel)
    private readonly hostelRepository: Repository<Hostel>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
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

  /**
   * Bulk create students from CSV data
   * CSV format: Name, Hall Ticket, College Code, Number, Hostel Name
   */
  async bulkCreateStudents(bulkData: BulkStudentDto[], createdBy: string): Promise<{ created: number, errors: any[] }> {
    const created = [];
    const errors = [];

    for (const studentData of bulkData) {
      try {
        // Parse name into first and last name
        const nameParts = studentData.name.trim().split(' ');
        const firstName = nameParts[0];
        const lastName = nameParts.slice(1).join(' ') || nameParts[0];

        // Find hostel by name
        const hostel = await this.hostelRepository.findOne({
          where: { name: studentData.hostelName },
        });

        if (!hostel) {
          errors.push({
            hallTicket: studentData.hallTicket,
            error: `Hostel not found: ${studentData.hostelName}`,
          });
          continue;
        }

        // Generate email if not provided
        const email = studentData.email || `${studentData.hallTicket.toLowerCase()}@student.college.edu`;

        // Check if student already exists
        const existingStudent = await this.studentRepository.findOne({
          where: [
            { studentId: studentData.hallTicket },
            { email },
          ],
        });

        if (existingStudent) {
          errors.push({
            hallTicket: studentData.hallTicket,
            error: 'Student already exists',
          });
          continue;
        }

        // Generate default password (hall ticket number)
        const defaultPassword = studentData.hallTicket;
        const hashedPassword = bcrypt.hashSync(defaultPassword, 10);

        // Create user account first
        const user = this.userRepository.create({
          email,
          passwordHash: hashedPassword,
          role: 'STUDENT',
          isActive: true,
        });
        const savedUser = await this.userRepository.save(user);

        // Create student record
        const student = this.studentRepository.create({
          id: savedUser.id,
          studentId: studentData.hallTicket,
          firstName,
          lastName,
          email,
          password: hashedPassword,
          phone: studentData.number,
          hostelId: hostel.id,
          role: 'STUDENT',
          isActive: true,
        });

        const savedStudent = await this.studentRepository.save(student);
        created.push(savedStudent);
      } catch (error) {
        errors.push({
          hallTicket: studentData.hallTicket,
          error: error.message,
        });
      }
    }

    return {
      created: created.length,
      errors,
    };
  }

  /**
   * Update student data (Admin/Warden only)
   */
  async updateStudentData(id: string, updateDto: UpdateStudentDto): Promise<Student> {
    const student = await this.getStudentById(id);

    // Update allowed fields
    if (updateDto.firstName) student.firstName = updateDto.firstName;
    if (updateDto.lastName) student.lastName = updateDto.lastName;
    if (updateDto.email) student.email = updateDto.email;
    if (updateDto.phone) student.phone = updateDto.phone;
    if (updateDto.roomId !== undefined) student.roomId = updateDto.roomId;
    if (updateDto.bedNumber !== undefined) student.bedNumber = updateDto.bedNumber;
    if (updateDto.hostelId) student.hostelId = updateDto.hostelId;
    if (updateDto.isActive !== undefined) student.isActive = updateDto.isActive;

    return await this.studentRepository.save(student);
  }

  /**
   * Reset student password (Admin/Warden only)
   */
  async resetStudentPassword(resetDto: ResetPasswordDto): Promise<{ success: boolean, newPassword: string }> {
    const student = await this.getStudentById(resetDto.studentId);

    // Generate new password (use provided or generate from student ID)
    const newPassword = resetDto.newPassword || student.studentId;
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update student password
    student.password = hashedPassword;
    await this.studentRepository.save(student);

    // Update user password
    const user = await this.userRepository.findOne({ where: { id: student.id } });
    if (user) {
      user.passwordHash = hashedPassword;
      await this.userRepository.save(user);
    }

    return {
      success: true,
      newPassword, // Return for admin to share with student
    };
  }

  /**
   * Delete student account (Admin only)
   */
  async deleteStudentAccount(id: string, performedBy: string): Promise<{ message: string }> {
    const student = await this.getStudentById(id);

    // Soft delete - deactivate instead of removing
    student.isActive = false;
    await this.studentRepository.save(student);

    // Also deactivate user account
    const user = await this.userRepository.findOne({ where: { id } });
    if (user) {
      user.isActive = false;
      await this.userRepository.save(user);
    }

    return {
      message: `Student account deactivated successfully`,
    };
  }

  /**
   * Permanently delete student (Super Admin only)
   */
  async permanentlyDeleteStudent(id: string): Promise<{ message: string }> {
    const student = await this.getStudentById(id);

    // Delete from database
    await this.studentRepository.remove(student);

    // Delete user account
    const user = await this.userRepository.findOne({ where: { id } });
    if (user) {
      await this.userRepository.remove(user);
    }

    return {
      message: 'Student permanently deleted',
    };
  }
}
