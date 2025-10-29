import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { Student } from '../students/entities/student.entity';
import bcrypt from 'bcryptjs';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    private readonly jwtService: JwtService,
  ) {}

  async register(registerDto: any): Promise<any> {
    // Check if email already exists
    const existingStudent = await this.studentRepository.findOne({
      where: { email: registerDto.email },
    });

    if (existingStudent) {
      throw new BadRequestException('Email already registered');
    }

    // Check if student ID already exists
    const existingStudentId = await this.studentRepository.findOne({
      where: { studentId: registerDto.studentId },
    });

    if (existingStudentId) {
      throw new BadRequestException('Student ID already registered');
    }

    // Hash password
    const hashedPassword = bcrypt.hashSync(registerDto.password, 10);

    // Create student
    const student = this.studentRepository.create({
      ...registerDto,
      password: hashedPassword,
      role: 'STUDENT',
      isActive: true,
    });

    const savedStudent = await this.studentRepository.save(student) as any;

    // Generate tokens
    const tokens = await this.generateTokens(savedStudent);

    return {
      user: {
        id: savedStudent.id,
        studentId: savedStudent.studentId,
        firstName: savedStudent.firstName,
        lastName: savedStudent.lastName,
        email: savedStudent.email,
        role: savedStudent.role,
        hostelId: savedStudent.hostelId,
        roomId: savedStudent.roomId,
      },
      ...tokens,
    };
  }

  async login(loginDto: any): Promise<any> {
    // Find student by email
    const student = await this.studentRepository.findOne({
      where: { email: loginDto.email },
    });

    if (!student) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Check if student is active
    if (!student.isActive) {
      throw new UnauthorizedException('Account is deactivated');
    }

    // Verify password
    const isPasswordValid = bcrypt.compareSync(loginDto.password, student.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Generate tokens
    const tokens = await this.generateTokens(student);

    return {
      user: {
        id: student.id,
        studentId: student.studentId,
        firstName: student.firstName,
        lastName: student.lastName,
        email: student.email,
        role: student.role,
        hostelId: student.hostelId,
        roomId: student.roomId,
      },
      ...tokens,
    };
  }

  async refreshToken(refreshToken: string): Promise<{ accessToken: string }> {
    try {
      const payload = this.jwtService.verify(refreshToken);
      const student = await this.studentRepository.findOne({
        where: { id: payload.sub },
      });

      if (!student || !student.isActive) {
        throw new UnauthorizedException('Invalid refresh token');
      }

      const accessToken = this.jwtService.sign(
        { sub: student.id, email: student.email, role: student.role },
        { expiresIn: '15m' },
      );

      return { accessToken };
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  private async generateTokens(student: Student): Promise<{ accessToken: string; refreshToken: string }> {
    const payload = { sub: student.id, email: student.email, role: student.role };

    const accessToken = this.jwtService.sign(payload, { expiresIn: '15m' });
    const refreshToken = this.jwtService.sign(payload, { expiresIn: '7d' });

    return { accessToken, refreshToken };
  }

  async validateUser(userId: string): Promise<Student | null> {
    return this.studentRepository.findOne({
      where: { id: userId, isActive: true },
    });
  }

  async getProfile(userId: string): Promise<any> {
    const student = await this.studentRepository.findOne({
      where: { id: userId },
    });

    if (!student) {
      throw new UnauthorizedException('User not found');
    }

    return {
      user: {
        id: student.id,
        studentId: student.studentId,
        firstName: student.firstName,
        lastName: student.lastName,
        email: student.email,
        role: student.role,
        hostelId: student.hostelId,
        roomId: student.roomId,
      },
    };
  }

  async forgotPassword(email: string): Promise<{ message: string }> {
    const student = await this.studentRepository.findOne({
      where: { email },
    });

    if (!student) {
      // Don't reveal if email exists or not for security
      return { message: 'If the email exists, password reset instructions have been sent.' };
    }

    // In a real application, you would:
    // 1. Generate a secure reset token
    // 2. Store it in the database with expiration
    // 3. Send an email with the reset link
    
    // For demo purposes, we'll just return a success message
    return { message: 'Password reset instructions have been sent to your email.' };
  }

  async resetPassword(token: string, newPassword: string): Promise<{ message: string }> {
    // In a real application, you would:
    // 1. Validate the reset token
    // 2. Check if it's not expired
    // 3. Hash the new password
    // 4. Update the user's password
    // 5. Invalidate the reset token
    
    // For demo purposes, we'll just return a success message
    return { message: 'Password has been reset successfully.' };
  }

  async changePassword(
    userId: string,
    currentPassword: string,
    newPassword: string
  ): Promise<{ message: string }> {
    // Find student
    const student = await this.studentRepository.findOne({
      where: { id: userId },
    });

    if (!student) {
      throw new UnauthorizedException('User not found');
    }

    // Verify current password
    const isPasswordValid = bcrypt.compareSync(currentPassword, student.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Current password is incorrect');
    }

    // Validate new password
    if (newPassword.length < 6) {
      throw new BadRequestException('New password must be at least 6 characters');
    }

    if (newPassword === currentPassword) {
      throw new BadRequestException('New password must be different from current password');
    }

    // Hash new password
    const hashedPassword = bcrypt.hashSync(newPassword, 10);

    // Update password
    student.password = hashedPassword;
    await this.studentRepository.save(student);

    return { message: 'Password changed successfully' };
  }
}