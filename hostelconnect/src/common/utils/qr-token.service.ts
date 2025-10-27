import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';

export interface QRTokenPayload {
  type: 'GATE_PASS' | 'ATTENDANCE';
  entityId: string;
  studentId?: string;
  sessionId?: string;
  nonce?: string;
}

@Injectable()
export class QRTokenService {
  private readonly secretKey = process.env.JWT_SECRET || 'hostelconnect-secret-key';
  private readonly tokenTTL = 30; // 30 seconds

  /**
   * Generate a rotating QR token with 30s TTL
   */
  generateToken(payload: QRTokenPayload): string {
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

  /**
   * Validate and decode QR token
   */
  validateToken(token: string): QRTokenPayload | null {
    try {
      const decoded = Buffer.from(token, 'base64').toString('utf-8');
      const [tokenString, hash] = decoded.split(':');

      if (!tokenString || !hash) {
        return null;
      }

      // Verify hash
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

      // Check if token is within current rotation window
      if (tokenData.rotationWindow < currentRotationWindow) {
        return null; // Token expired
      }

      return {
        type: tokenData.type,
        entityId: tokenData.entityId,
        studentId: tokenData.studentId,
        sessionId: tokenData.sessionId,
        nonce: tokenData.nonce,
      };
    } catch (error) {
      return null;
    }
  }

  /**
   * Generate attendance QR token for a session
   */
  generateAttendanceToken(sessionId: string, nonce: string): string {
    return this.generateToken({
      type: 'ATTENDANCE',
      entityId: sessionId,
      sessionId,
      nonce,
    });
  }

  /**
   * Generate gate pass QR token
   */
  generateGatePassToken(passId: string, studentId: string): string {
    return this.generateToken({
      type: 'GATE_PASS',
      entityId: passId,
      studentId,
    });
  }

  /**
   * Check if token is expired (outside rotation window)
   */
  isTokenExpired(token: string): boolean {
    const payload = this.validateToken(token);
    return payload === null;
  }
}
