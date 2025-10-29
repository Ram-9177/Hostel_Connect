import { Injectable, UnauthorizedException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { Student } from '../students/entities/student.entity';
import { Warden } from '../wardens/entities/warden.entity';
import { Chef } from '../chefs/entities/chef.entity';
import { Admin } from '../admins/entities/admin.entity';
import * as bcrypt from 'bcryptjs';
import { RegisterDto } from './dto/register.dto';
import { EmailService } from '../common/email/email.service';
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
    private readonly emailService: EmailService,
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
    const hashedPassword = bcrypt.hashSync(registerDto.password, 12);

    // Generate email verification token
    const verificationToken = this.jwtService.sign(
      { email: registerDto.email, type: 'email_verification' },
      { expiresIn: '24h' }
    );
    const verificationExpires = new Date();
    verificationExpires.setHours(verificationExpires.getHours() + 24);

    // Create user based on role
    let savedUser: any;
    const userData = {
      ...registerDto,
      password: hashedPassword,
      isActive: true,
      isEmailVerified: false,
      emailVerificationToken: verificationToken,
      emailVerificationExpires: verificationExpires,
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

    // Send email verification email (best-effort)
    const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
    const verificationLink = `${appUrl}/verify-email?token=${verificationToken}`;
    try {
      await this.emailService.sendEmail(
        savedUser.email,
        'Verify your HostelConnect account',
        `<p>Hi ${savedUser.firstName},</p>
         <p>Welcome to HostelConnect! Please verify your email address to complete your registration.</p>
         <p><a href="${verificationLink}">Click here to verify your email</a></p>
         <p>This link expires in 24 hours.</p>
         <p>If you didn't create this account, you can ignore this email.</p>`
      );
    } catch (e) {}

    return {
      user: this.formatUserResponse(savedUser),
      message: 'Registration successful. Please check your email to verify your account.',
    };
  }

  async login(loginDto: LoginDto): Promise<any> {
    // Find user by email across all user types; if not found, allow student login via hall ticket (studentId)
    let user = await this.findUserByEmail(loginDto.email);
    if (!user) {
      // Treat provided email field as hall ticket for student login fallback
      const studentById = await this.studentRepository.findOne({ where: { studentId: loginDto.email } });
      if (studentById) {
        user = { ...studentById, role: 'STUDENT' } as any;
      }
    }
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Check if user is active
    if (!user.isActive) {
      throw new UnauthorizedException('Account is deactivated');
    }

    // Check email verification (for new registrations)
    // Allow opt-in bypass in non-production via env var to ease local/mobile testing
    const allowUnverifiedLogin =
      process.env.ALLOW_UNVERIFIED_LOGIN === 'true' && process.env.NODE_ENV !== 'production';
    if (user.isEmailVerified === false && !allowUnverifiedLogin) {
      throw new UnauthorizedException(
        'Please verify your email before logging in. Check your inbox for the verification link.'
      );
    }

    // Verify password
    const isPasswordValid = bcrypt.compareSync(loginDto.password, user.password);
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

    // Send reset email (best-effort)
    const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
    const resetLink = `${appUrl}/reset-password?token=${resetToken}`;
    try {
      await this.emailService.sendEmail(
        user.email,
        'Reset your HostelConnect password',
        `<p>We received a request to reset your password.</p>
         <p><a href="${resetLink}">Click here to reset your password</a>. This link expires in 1 hour.</p>
         <p>If you did not request this, you can ignore this email.</p>`
      );
    } catch (e) {}

    return { message: 'Password reset instructions have been sent to your email.' };
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
      const hashedPassword = bcrypt.hashSync(newPassword, 12);
      
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

  async verifyEmail(token: string): Promise<{ message: string }> {
    try {
      const payload = this.jwtService.verify(token);
      
      if (payload.type !== 'email_verification') {
        throw new UnauthorizedException('Invalid verification token');
      }

      const user = await this.findUserByEmail(payload.email);
      if (!user) {
        throw new UnauthorizedException('User not found');
      }

      if (user.isEmailVerified) {
        return { message: 'Email already verified. You can now log in.' };
      }

      // Check token expiration
      if (user.emailVerificationExpires && new Date() > new Date(user.emailVerificationExpires)) {
        throw new UnauthorizedException('Verification token has expired. Please request a new one.');
      }

      if (user.emailVerificationToken !== token) {
        throw new UnauthorizedException('Invalid verification token');
      }

      // Update user to verified
      await this.updateEmailVerification(user.id, user.role, true);

      return { message: 'Email verified successfully. You can now log in.' };
    } catch (error) {
      if (error.name === 'TokenExpiredError' || error.name === 'JsonWebTokenError') {
        throw new UnauthorizedException('Invalid or expired verification token');
      }
      throw error;
    }
  }

  async resendVerificationEmail(email: string): Promise<{ message: string }> {
    const user = await this.findUserByEmail(email);
    
    if (!user) {
      // Don't reveal if email exists or not for security
      return { message: 'If the email exists, verification instructions have been sent.' };
    }

    if (user.isEmailVerified) {
      return { message: 'Email is already verified. You can log in.' };
    }

    // Generate new verification token
    const verificationToken = this.jwtService.sign(
      { email: user.email, type: 'email_verification' },
      { expiresIn: '24h' }
    );
    const verificationExpires = new Date();
    verificationExpires.setHours(verificationExpires.getHours() + 24);

    // Update token
    await this.updateVerificationToken(user.id, user.role, verificationToken, verificationExpires);

    // Send verification email
    const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
    const verificationLink = `${appUrl}/verify-email?token=${verificationToken}`;
    try {
      await this.emailService.sendEmail(
        user.email,
        'Verify your HostelConnect account',
        `<p>Hi ${user.firstName},</p>
         <p>Please verify your email address to complete your registration.</p>
         <p><a href="${verificationLink}">Click here to verify your email</a></p>
         <p>This link expires in 24 hours.</p>`
      );
    } catch (e) {}

    return { message: 'Verification email has been sent. Please check your inbox.' };
  }

  async changePassword(
    userId: string,
    role: string,
    currentPassword: string,
    newPassword: string
  ): Promise<{ message: string }> {
    const user = await this.findUserById(userId, role);
    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    // Verify current password
    const isPasswordValid = bcrypt.compareSync(currentPassword, user.password);
    if (!isPasswordValid) {
      throw new BadRequestException('Current password is incorrect');
    }

    // Hash new password
    const hashedPassword = bcrypt.hashSync(newPassword, 12);
    
    // Update password
    await this.updatePassword(userId, role, hashedPassword);

    return { message: 'Password changed successfully' };
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

  private async updateEmailVerification(id: string, role: string, verified: boolean): Promise<void> {
    const updateData = { 
      isEmailVerified: verified, 
      emailVerificationToken: null,
      emailVerificationExpires: null,
      updatedAt: new Date() 
    };
    
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

  private async updateVerificationToken(id: string, role: string, token: string, expires: Date): Promise<void> {
    const updateData = { 
      emailVerificationToken: token,
      emailVerificationExpires: expires,
      updatedAt: new Date() 
    };
    
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