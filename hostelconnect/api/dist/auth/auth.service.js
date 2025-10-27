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
const bcrypt = require("bcrypt");
let AuthService = class AuthService {
    constructor(studentRepository, wardenRepository, chefRepository, adminRepository, jwtService) {
        this.studentRepository = studentRepository;
        this.wardenRepository = wardenRepository;
        this.chefRepository = chefRepository;
        this.adminRepository = adminRepository;
        this.jwtService = jwtService;
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
        const hashedPassword = await bcrypt.hash(registerDto.password, 12);
        let savedUser;
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
                throw new common_1.BadRequestException('Invalid role');
        }
        const tokens = await this.generateTokens(savedUser);
        return {
            user: this.formatUserResponse(savedUser),
            ...tokens,
            message: 'Registration successful',
        };
    }
    async login(loginDto) {
        const user = await this.findUserByEmail(loginDto.email);
        if (!user) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        if (!user.isActive) {
            throw new common_1.UnauthorizedException('Account is deactivated');
        }
        const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);
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
        return {
            message: 'Password reset instructions have been sent to your email.',
        };
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
            const hashedPassword = await bcrypt.hash(newPassword, 12);
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
        jwt_1.JwtService])
], AuthService);
//# sourceMappingURL=auth.service.js.map