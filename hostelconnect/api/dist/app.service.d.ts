export declare class AppService {
    getHello(): string;
    getHealth(): {
        status: string;
        timestamp: string;
        version: string;
        environment: string;
        uptime: number;
    };
}
