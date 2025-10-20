export interface QRTokenPayload {
    type: 'GATE_PASS' | 'ATTENDANCE';
    entityId: string;
    studentId?: string;
    sessionId?: string;
    nonce?: string;
}
export declare class QRTokenService {
    private readonly secretKey;
    private readonly tokenTTL;
    generateToken(payload: QRTokenPayload): string;
    validateToken(token: string): QRTokenPayload | null;
    generateAttendanceToken(sessionId: string, nonce: string): string;
    generateGatePassToken(passId: string, studentId: string): string;
    isTokenExpired(token: string): boolean;
}
