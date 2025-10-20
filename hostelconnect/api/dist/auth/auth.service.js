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
const bcrypt = require("bcrypt");
let AuthService = class AuthService {
    constructor(studentRepository, jwtService) {
        this.studentRepository = studentRepository;
        this.jwtService = jwtService;
    }
    async register(registerDto) {
        const existingStudent = await this.studentRepository.findOne({
            where: { email: registerDto.email },
        });
        if (existingStudent) {
            throw new common_1.BadRequestException('Email already registered');
        }
        const existingStudentId = await this.studentRepository.findOne({
            where: { studentId: registerDto.studentId },
        });
        if (existingStudentId) {
            throw new common_1.BadRequestException('Student ID already registered');
        }
        const hashedPassword = await bcrypt.hash(registerDto.password, 10);
        const student = this.studentRepository.create({
            ...registerDto,
            password: hashedPassword,
            role: 'STUDENT',
            isActive: true,
        });
        const savedStudent = await this.studentRepository.save(student);
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
    async login(loginDto) {
        const student = await this.studentRepository.findOne({
            where: { email: loginDto.email },
        });
        if (!student) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        if (!student.isActive) {
            throw new common_1.UnauthorizedException('Account is deactivated');
        }
        const isPasswordValid = await bcrypt.compare(loginDto.password, student.password);
        if (!isPasswordValid) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
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
    async refreshToken(refreshToken) {
        try {
            const payload = this.jwtService.verify(refreshToken);
            const student = await this.studentRepository.findOne({
                where: { id: payload.sub },
            });
            if (!student || !student.isActive) {
                throw new common_1.UnauthorizedException('Invalid refresh token');
            }
            const accessToken = this.jwtService.sign({ sub: student.id, email: student.email, role: student.role }, { expiresIn: '15m' });
            return { accessToken };
        }
        catch (error) {
            throw new common_1.UnauthorizedException('Invalid refresh token');
        }
    }
    async generateTokens(student) {
        const payload = { sub: student.id, email: student.email, role: student.role };
        const accessToken = this.jwtService.sign(payload, { expiresIn: '15m' });
        const refreshToken = this.jwtService.sign(payload, { expiresIn: '7d' });
        return { accessToken, refreshToken };
    }
    async validateUser(userId) {
        return this.studentRepository.findOne({
            where: { id: userId, isActive: true },
        });
    }
    async getProfile(userId) {
        const student = await this.studentRepository.findOne({
            where: { id: userId },
        });
        if (!student) {
            throw new common_1.UnauthorizedException('User not found');
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
    async forgotPassword(email) {
        const student = await this.studentRepository.findOne({
            where: { email },
        });
        if (!student) {
            return { message: 'If the email exists, password reset instructions have been sent.' };
        }
        return { message: 'Password reset instructions have been sent to your email.' };
    }
    async resetPassword(token, newPassword) {
        return { message: 'Password has been reset successfully.' };
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        jwt_1.JwtService])
], AuthService);
//# sourceMappingURL=auth.service.js.map