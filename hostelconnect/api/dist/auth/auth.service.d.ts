import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { Student } from '../students/entities/student.entity';
import { Warden } from '../wardens/entities/warden.entity';
import { Chef } from '../chefs/entities/chef.entity';
import { Admin } from '../admins/entities/admin.entity';
import { RegisterDto } from './dto/register.dto';
import { EmailService } from '../common/email/email.service';
import { LoginDto } from './dto/login.dto';
export declare class AuthService {
    private readonly studentRepository;
    private readonly wardenRepository;
    private readonly chefRepository;
    private readonly adminRepository;
    private readonly jwtService;
    private readonly emailService;
    constructor(studentRepository: Repository<Student>, wardenRepository: Repository<Warden>, chefRepository: Repository<Chef>, adminRepository: Repository<Admin>, jwtService: JwtService, emailService: EmailService);
    register(registerDto: RegisterDto): Promise<any>;
    login(loginDto: LoginDto): Promise<any>;
    refreshToken(refreshToken: string): Promise<{
        accessToken: string;
    }>;
    forgotPassword(email: string): Promise<{
        message: string;
    }>;
    resetPassword(token: string, newPassword: string): Promise<{
        message: string;
    }>;
    validateUser(userId: string, role: string): Promise<any>;
    getProfile(userId: string, role: string): Promise<any>;
    verifyEmail(token: string): Promise<{
        message: string;
    }>;
    resendVerificationEmail(email: string): Promise<{
        message: string;
    }>;
    changePassword(userId: string, role: string, currentPassword: string, newPassword: string): Promise<{
        message: string;
    }>;
    private findUserByEmail;
    private findUserById;
    private updateLastLogin;
    private updatePassword;
    private updateEmailVerification;
    private updateVerificationToken;
    private formatUserResponse;
    private generateTokens;
}
