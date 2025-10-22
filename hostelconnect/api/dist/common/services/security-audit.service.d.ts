import { ConfigService } from '@nestjs/config';
import { AppLoggerService } from './app-logger.service';
export interface SecurityAuditResult {
    timestamp: string;
    overallScore: number;
    status: 'SECURE' | 'WARNING' | 'CRITICAL';
    checks: SecurityCheck[];
    recommendations: string[];
}
export interface SecurityCheck {
    name: string;
    status: 'PASS' | 'WARN' | 'FAIL';
    score: number;
    description: string;
    recommendation?: string;
}
export declare class SecurityAuditService {
    private readonly configService;
    private readonly logger;
    constructor(configService: ConfigService, logger: AppLoggerService);
    performSecurityAudit(): Promise<SecurityAuditResult>;
    private checkAuthentication;
    private checkAuthorization;
    private checkInputValidation;
    private checkDataProtection;
    private checkNetworkSecurity;
    private checkInfrastructureSecurity;
    private generateRecommendations;
    simulatePenetrationTest(): Promise<any>;
    private testSQLInjection;
    private testXSS;
    private testCSRF;
    private testAuthenticationBypass;
    private testAuthorizationBypass;
    private testFileUploadBypass;
    private testRateLimitBypass;
    monitorSecurityEvents(): Promise<void>;
    generateSecurityReport(): Promise<any>;
}
