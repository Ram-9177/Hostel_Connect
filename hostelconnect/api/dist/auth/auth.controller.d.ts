import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
export declare class AuthController {
    private readonly authService;
    constructor(authService: AuthService);
    register(registerDto: RegisterDto): Promise<any>;
    login(loginDto: LoginDto): Promise<any>;
    refreshToken(body: {
        refreshToken: string;
    }): Promise<{
        accessToken: string;
    }>;
    getProfile(req: any): Promise<{
        user: {
            id: any;
            studentId: any;
            firstName: any;
            lastName: any;
            email: any;
            role: any;
            hostelId: any;
            roomId: any;
        };
    }>;
    forgotPassword(body: {
        email: string;
    }): Promise<{
        message: string;
    }>;
    resetPassword(body: {
        token: string;
        newPassword: string;
    }): Promise<{
        message: string;
    }>;
    logout(req: any): Promise<{
        message: string;
        timestamp: string;
    }>;
    verifyEmail(body: {
        token: string;
    }): Promise<{
        message: string;
    }>;
    resendVerification(body: {
        email: string;
    }): Promise<{
        message: string;
    }>;
    changePassword(req: any, body: {
        currentPassword: string;
        newPassword: string;
    }): Promise<{
        message: string;
    }>;
}
