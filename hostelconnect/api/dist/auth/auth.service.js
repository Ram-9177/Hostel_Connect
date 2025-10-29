"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const jwt_1 = require("@nestjs/jwt");
const student_entity_1 = require("../students/entities/student.entity");
const warden_entity_1 = require("../wardens/entities/warden.entity");
const chef_entity_1 = require("../chefs/entities/chef.entity");
const admin_entity_1 = require("../admins/entities/admin.entity");
const bcrypt = require("bcryptjs");
const email_service_1 = require("../common/email/email.service");
let AuthService = class AuthService {
    constructor(studentRepository, wardenRepository, chefRepository, adminRepository, jwtService, emailService) {
        this.studentRepository = studentRepository;
        this.wardenRepository = wardenRepository;
        this.chefRepository = chefRepository;
        this.adminRepository = adminRepository;
        this.jwtService = jwtService;
        this.emailService = emailService;
    }
    async register(registerDto) {
        const existingUser = await this.findUserByEmail(registerDto.email);
        if (existingUser) {
            throw new common_1.BadRequestException('Email already registered');
        }
        if (registerDto.role === 'STUDENT') {
            const existingStudentId = await this.studentRepository.findOne({
                where: { studentId: registerDto.studentId },
            });
            if (existingStudentId) {
                throw new common_1.BadRequestException('Student ID already registered');
            }
        }
        const hashedPassword = bcrypt.hashSync(registerDto.password, 12);
        const verificationToken = this.jwtService.sign({ email: registerDto.email, type: 'email_verification' }, { expiresIn: '24h' });
        const verificationExpires = new Date();
        verificationExpires.setHours(verificationExpires.getHours() + 24);
        let savedUser;
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
                throw new common_1.BadRequestException('Invalid role');
        }
        const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
        const verificationLink = `${appUrl}/verify-email?token=${verificationToken}`;
        try {
            await this.emailService.sendEmail(savedUser.email, 'Verify your HostelConnect account', `<p>Hi ${savedUser.firstName},</p>
         <p>Welcome to HostelConnect! Please verify your email address to complete your registration.</p>
         <p><a href="${verificationLink}">Click here to verify your email</a></p>
         <p>This link expires in 24 hours.</p>
         <p>If you didn't create this account, you can ignore this email.</p>`);
        }
        catch (e) { }
        return {
            user: this.formatUserResponse(savedUser),
            message: 'Registration successful. Please check your email to verify your account.',
        };
    }
    async login(loginDto) {
        let user = await this.findUserByEmail(loginDto.email);
        if (!user) {
            const studentById = await this.studentRepository.findOne({ where: { studentId: loginDto.email } });
            if (studentById) {
                user = { ...studentById, role: 'STUDENT' };
            }
        }
        if (!user) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        if (!user.isActive) {
            throw new common_1.UnauthorizedException('Account is deactivated');
        }
        const allowUnverifiedLogin = process.env.ALLOW_UNVERIFIED_LOGIN === 'true' && process.env.NODE_ENV !== 'production';
        if (user.isEmailVerified === false && !allowUnverifiedLogin) {
            throw new common_1.UnauthorizedException('Please verify your email before logging in. Check your inbox for the verification link.');
        }
        const isPasswordValid = bcrypt.compareSync(loginDto.password, user.password);
        if (!isPasswordValid) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        await this.updateLastLogin(user.id, user.role);
        const tokens = await this.generateTokens(user);
        return {
            user: this.formatUserResponse(user),
            ...tokens,
            message: 'Login successful',
        };
    }
    async refreshToken(refreshToken) {
        try {
            const payload = this.jwtService.verify(refreshToken);
            const user = await this.findUserById(payload.sub, payload.role);
            if (!user || !user.isActive) {
                throw new common_1.UnauthorizedException('Invalid refresh token');
            }
            const accessToken = this.jwtService.sign({ sub: user.id, email: user.email, role: user.role }, { expiresIn: '15m' });
            return { accessToken };
        }
        catch (error) {
            throw new common_1.UnauthorizedException('Invalid refresh token');
        }
    }
    async forgotPassword(email) {
        const user = await this.findUserByEmail(email);
        if (!user) {
            return { message: 'If the email exists, password reset instructions have been sent.' };
        }
        const resetToken = this.jwtService.sign({ sub: user.id, email: user.email, type: 'password_reset' }, { expiresIn: '1h' });
        const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
        const resetLink = `${appUrl}/reset-password?token=${resetToken}`;
        try {
            await this.emailService.sendEmail(user.email, 'Reset your HostelConnect password', `<p>We received a request to reset your password.</p>
         <p><a href="${resetLink}">Click here to reset your password</a>. This link expires in 1 hour.</p>
         <p>If you did not request this, you can ignore this email.</p>`);
        }
        catch (e) { }
        return { message: 'Password reset instructions have been sent to your email.' };
    }
    async resetPassword(token, newPassword) {
        try {
            const payload = this.jwtService.verify(token);
            if (payload.type !== 'password_reset') {
                throw new common_1.UnauthorizedException('Invalid reset token');
            }
            const user = await this.findUserById(payload.sub, payload.role);
            if (!user) {
                throw new common_1.UnauthorizedException('User not found');
            }
            const hashedPassword = bcrypt.hashSync(newPassword, 12);
            await this.updatePassword(user.id, user.role, hashedPassword);
            return { message: 'Password has been reset successfully.' };
        }
        catch (error) {
            throw new common_1.UnauthorizedException('Invalid or expired reset token');
        }
    }
    async validateUser(userId, role) {
        return this.findUserById(userId, role);
    }
    async getProfile(userId, role) {
        const user = await this.findUserById(userId, role);
        if (!user) {
            throw new common_1.UnauthorizedException('User not found');
        }
        return { user: this.formatUserResponse(user) };
    }
    async verifyEmail(token) {
        try {
            const payload = this.jwtService.verify(token);
            if (payload.type !== 'email_verification') {
                throw new common_1.UnauthorizedException('Invalid verification token');
            }
            const user = await this.findUserByEmail(payload.email);
            if (!user) {
                throw new common_1.UnauthorizedException('User not found');
            }
            if (user.isEmailVerified) {
                return { message: 'Email already verified. You can now log in.' };
            }
            if (user.emailVerificationExpires && new Date() > new Date(user.emailVerificationExpires)) {
                throw new common_1.UnauthorizedException('Verification token has expired. Please request a new one.');
            }
            if (user.emailVerificationToken !== token) {
                throw new common_1.UnauthorizedException('Invalid verification token');
            }
            await this.updateEmailVerification(user.id, user.role, true);
            return { message: 'Email verified successfully. You can now log in.' };
        }
        catch (error) {
            if (error.name === 'TokenExpiredError' || error.name === 'JsonWebTokenError') {
                throw new common_1.UnauthorizedException('Invalid or expired verification token');
            }
            throw error;
        }
    }
    async resendVerificationEmail(email) {
        const user = await this.findUserByEmail(email);
        if (!user) {
            return { message: 'If the email exists, verification instructions have been sent.' };
        }
        if (user.isEmailVerified) {
            return { message: 'Email is already verified. You can log in.' };
        }
        const verificationToken = this.jwtService.sign({ email: user.email, type: 'email_verification' }, { expiresIn: '24h' });
        const verificationExpires = new Date();
        verificationExpires.setHours(verificationExpires.getHours() + 24);
        await this.updateVerificationToken(user.id, user.role, verificationToken, verificationExpires);
        const appUrl = process.env.APP_URL || 'https://app.hostelconnect.com';
        const verificationLink = `${appUrl}/verify-email?token=${verificationToken}`;
        try {
            await this.emailService.sendEmail(user.email, 'Verify your HostelConnect account', `<p>Hi ${user.firstName},</p>
         <p>Please verify your email address to complete your registration.</p>
         <p><a href="${verificationLink}">Click here to verify your email</a></p>
         <p>This link expires in 24 hours.</p>`);
        }
        catch (e) { }
        return { message: 'Verification email has been sent. Please check your inbox.' };
    }
    async changePassword(userId, role, currentPassword, newPassword) {
        const user = await this.findUserById(userId, role);
        if (!user) {
            throw new common_1.UnauthorizedException('User not found');
        }
        const isPasswordValid = bcrypt.compareSync(currentPassword, user.password);
        if (!isPasswordValid) {
            throw new common_1.BadRequestException('Current password is incorrect');
        }
        const hashedPassword = bcrypt.hashSync(newPassword, 12);
        await this.updatePassword(userId, role, hashedPassword);
        return { message: 'Password changed successfully' };
    }
    async findUserByEmail(email) {
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
    async findUserById(id, role) {
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
    async updateLastLogin(id, role) {
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
    async updatePassword(id, role, hashedPassword) {
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
    async updateEmailVerification(id, role, verified) {
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
    async updateVerificationToken(id, role, token, expires) {
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
    formatUserResponse(user) {
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
    async generateTokens(user) {
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
            expiresIn: 900
        };
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __param(1, (0, typeorm_1.InjectRepository)(warden_entity_1.Warden)),
    __param(2, (0, typeorm_1.InjectRepository)(chef_entity_1.Chef)),
    __param(3, (0, typeorm_1.InjectRepository)(admin_entity_1.Admin)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        jwt_1.JwtService,
        email_service_1.EmailService])
], AuthService);
//# sourceMappingURL=auth.service.js.map