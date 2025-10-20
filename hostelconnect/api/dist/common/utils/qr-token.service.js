"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.QRTokenService = void 0;
const common_1 = require("@nestjs/common");
const crypto = require("crypto");
let QRTokenService = class QRTokenService {
    constructor() {
        this.secretKey = process.env.JWT_SECRET || 'hostelconnect-secret-key';
        this.tokenTTL = 30;
    }
    generateToken(payload) {
        const timestamp = Math.floor(Date.now() / 1000);
        const rotationWindow = Math.floor(timestamp / this.tokenTTL);
        const tokenData = {
            ...payload,
            rotationWindow,
            timestamp,
        };
        const tokenString = JSON.stringify(tokenData);
        const hash = crypto
            .createHmac('sha256', this.secretKey)
            .update(tokenString)
            .digest('hex');
        return Buffer.from(`${tokenString}:${hash}`).toString('base64');
    }
    validateToken(token) {
        try {
            const decoded = Buffer.from(token, 'base64').toString('utf-8');
            const [tokenString, hash] = decoded.split(':');
            if (!tokenString || !hash) {
                return null;
            }
            const expectedHash = crypto
                .createHmac('sha256', this.secretKey)
                .update(tokenString)
                .digest('hex');
            if (hash !== expectedHash) {
                return null;
            }
            const tokenData = JSON.parse(tokenString);
            const currentTimestamp = Math.floor(Date.now() / 1000);
            const currentRotationWindow = Math.floor(currentTimestamp / this.tokenTTL);
            if (tokenData.rotationWindow < currentRotationWindow) {
                return null;
            }
            return {
                type: tokenData.type,
                entityId: tokenData.entityId,
                studentId: tokenData.studentId,
                sessionId: tokenData.sessionId,
                nonce: tokenData.nonce,
            };
        }
        catch (error) {
            return null;
        }
    }
    generateAttendanceToken(sessionId, nonce) {
        return this.generateToken({
            type: 'ATTENDANCE',
            entityId: sessionId,
            sessionId,
            nonce,
        });
    }
    generateGatePassToken(passId, studentId) {
        return this.generateToken({
            type: 'GATE_PASS',
            entityId: passId,
            studentId,
        });
    }
    isTokenExpired(token) {
        const payload = this.validateToken(token);
        return payload === null;
    }
};
exports.QRTokenService = QRTokenService;
exports.QRTokenService = QRTokenService = __decorate([
    (0, common_1.Injectable)()
], QRTokenService);
//# sourceMappingURL=qr-token.service.js.map