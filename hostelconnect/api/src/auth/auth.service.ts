import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { Student } from '../students/entities/student.entity';
import { Warden } from '../wardens/entities/warden.entity';
import { Chef } from '../chefs/entities/chef.entity';
import { Admin } from '../admins/entities/admin.entity';
import * as bcrypt from 'bcrypt';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
    @InjectRepository(Warden)
    private readonly wardenRepository: Repository<Warden>,
    @InjectRepository(Chef)
    private readonly chefRepository: Repository<Chef>,
    @InjectRepository(Admin)
    private readonly adminRepository: Repository<Admin>,
    private readonly jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto): Promise<any> {
    // Check if email already exists across all user types
    const existingUser = await this.findUserByEmail(registerDto.email);
    if (existingUser) {
      throw new BadRequestException('Email already registered');
    }

    // Check if student ID already exists (for students)
    if (registerDto.role === 'STUDENT') {
      const existingStudentId = await this.studentRepository.findOne({
        where: { studentId: registerDto.studentId },
      });
      if (existingStudentId) {
        throw new BadRequestException('Student ID already registered');
      }
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(registerDto.password, 12);

    // Create user based on role
    let savedUser: any;
    const userData = {
      ...registerDto,
      password: hashedPassword,
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    switch (registerDto.role) {
      case 'STUDENT':
        savedUser = await this.studentRepository.save(userData);
        break;
      case 'WARDEN':
        savedUser = await this.wardenRepository.save(userData);
        break;
      case 'CHEF':
        savedUser = await this.chefRepository.save(userData);
        break;
      case 'ADMIN':
        savedUser = await this.adminRepository.save(userData);
        break;
      default:
        throw new BadRequestException('Invalid role');
    }

    // Generate tokens
    const tokens = await this.generateTokens(savedUser);

    return {
      user: this.formatUserResponse(savedUser),
      ...tokens,
      message: 'Registration successful',
    };
  }

  async login(loginDto: LoginDto): Promise<any> {
    // Find user by email across all user types
    const user = await this.findUserByEmail(loginDto.email);
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Check if user is active
    if (!user.isActive) {
      throw new UnauthorizedException('Account is deactivated');
    }

    // Verify password
    const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Update last login
    await this.updateLastLogin(user.id, user.role);

    // Generate tokens
    const tokens = await this.generateTokens(user);

    return {
      user: this.formatUserResponse(user),
      ...tokens,
      message: 'Login successful',
    };
  }

  async refreshToken(refreshToken: string): Promise<{ accessToken: string }> {
    try {
      const payload = this.jwtService.verify(refreshToken);
      const user = await this.findUserById(payload.sub, payload.role);

      if (!user || !user.isActive) {
        throw new UnauthorizedException('Invalid refresh token');
      }

      const accessToken = this.jwtService.sign(
        { sub: user.id, email: user.email, role: user.role },
        { expiresIn: '15m' },
      );

      return { accessToken };
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  async forgotPassword(email: string): Promise<{ message: string }> {
    const user = await this.findUserByEmail(email);
    
    if (!user) {
      // Don't reveal if email exists or not for security
      return { message: 'If the email exists, password reset instructions have been sent.' };
    }

    // Generate reset token
    const resetToken = this.jwtService.sign(
      { sub: user.id, email: user.email, type: 'password_reset' },
      { expiresIn: '1h' }
    );

    // In production, you would:
    // 1. Store reset token in database with expiration
    // 2. Send email with reset link
    // 3. Log the reset attempt
    
    return { 
      message: 'Password reset instructions have been sent to your email.',
      // resetToken: resetToken // Only for development/testing
    };
  }

  async resetPassword(token: string, newPassword: string): Promise<{ message: string }> {
    try {
      const payload = this.jwtService.verify(token);
      
      if (payload.type !== 'password_reset') {
        throw new UnauthorizedException('Invalid reset token');
      }

      const user = await this.findUserById(payload.sub, payload.role);
      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      // Hash new password
      const hashedPassword = await bcrypt.hash(newPassword, 12);
      
      // Update password
      await this.updatePassword(user.id, user.role, hashedPassword);

      return { message: 'Password has been reset successfully.' };
    } catch (error) {
      throw new UnauthorizedException('Invalid or expired reset token');
    }
  }

  async validateUser(userId: string, role: string): Promise<any> {
    return this.findUserById(userId, role);
  }

  async getProfile(userId: string, role: string): Promise<any> {
    const user = await this.findUserById(userId, role);
    if (!user) {
      throw new UnauthorizedException('User not found');
    }
    return { user: this.formatUserResponse(user) };
  }

  // Helper methods
  private async findUserByEmail(email: string): Promise<any> {
    const repositories = [
      { repo: this.studentRepository, role: 'STUDENT' },
      { repo: this.wardenRepository, role: 'WARDEN' },
      { repo: this.chefRepository, role: 'CHEF' },
      { repo: this.adminRepository, role: 'ADMIN' },
    ];

    for (const { repo, role } of repositories) {
      const user = await repo.findOne({ where: { email } });
      if (user) {
        return { ...user, role };
      }
    }
    return null;
  }

  private async findUserById(id: string, role: string): Promise<any> {
    switch (role) {
      case 'STUDENT':
        return this.studentRepository.findOne({ where: { id } });
      case 'WARDEN':
        return this.wardenRepository.findOne({ where: { id } });
      case 'CHEF':
        return this.chefRepository.findOne({ where: { id } });
      case 'ADMIN':
        return this.adminRepository.findOne({ where: { id } });
      default:
        return null;
    }
  }

  private async updateLastLogin(id: string, role: string): Promise<void> {
    const updateData = { lastLogin: new Date(), updatedAt: new Date() };
    
    switch (role) {
      case 'STUDENT':
        await this.studentRepository.update(id, updateData);
        break;
      case 'WARDEN':
        await this.wardenRepository.update(id, updateData);
        break;
      case 'CHEF':
        await this.chefRepository.update(id, updateData);
        break;
      case 'ADMIN':
        await this.adminRepository.update(id, updateData);
        break;
    }
  }

  private async updatePassword(id: string, role: string, hashedPassword: string): Promise<void> {
    const updateData = { password: hashedPassword, updatedAt: new Date() };
    
    switch (role) {
      case 'STUDENT':
        await this.studentRepository.update(id, updateData);
        break;
      case 'WARDEN':
        await this.wardenRepository.update(id, updateData);
        break;
      case 'CHEF':
        await this.chefRepository.update(id, updateData);
        break;
      case 'ADMIN':
        await this.adminRepository.update(id, updateData);
        break;
    }
  }

  private formatUserResponse(user: any): any {
    return {
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      role: user.role,
      hostelId: user.hostelId,
      roomId: user.roomId,
      studentId: user.studentId,
      phone: user.phone,
      isActive: user.isActive,
      lastLogin: user.lastLogin,
      createdAt: user.createdAt,
    };
  }

  private async generateTokens(user: any): Promise<{ accessToken: string; refreshToken: string; expiresIn: number }> {
    const payload = { 
      sub: user.id, 
      email: user.email, 
      role: user.role,
      hostelId: user.hostelId 
    };

    const accessToken = this.jwtService.sign(payload, { expiresIn: '15m' });
    const refreshToken = this.jwtService.sign(payload, { expiresIn: '7d' });

    return { 
      accessToken, 
      refreshToken, 
      expiresIn: 900 // 15 minutes in seconds
    };
  }
}