import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { Student } from '../students/entities/student.entity';
export declare class AuthService {
    private readonly studentRepository;
    private readonly jwtService;
    constructor(studentRepository: Repository<Student>, jwtService: JwtService);
    register(registerDto: any): Promise<any>;
    login(loginDto: any): Promise<any>;
    refreshToken(refreshToken: string): Promise<{
        accessToken: string;
    }>;
    private generateTokens;
    validateUser(userId: string): Promise<Student | null>;
    getProfile(userId: string): Promise<any>;
    forgotPassword(email: string): Promise<{
        message: string;
    }>;
    resetPassword(token: string, newPassword: string): Promise<{
        message: string;
    }>;
}
