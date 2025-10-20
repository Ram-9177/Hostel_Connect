export declare enum UserRole {
    SUPER_ADMIN = "SUPER_ADMIN",
    WARDEN_HEAD = "WARDEN_HEAD",
    WARDEN = "WARDEN",
    STUDENT = "STUDENT",
    CHEF = "CHEF"
}
export declare class User {
    id: string;
    email: string;
    passwordHash: string;
    role: string;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
}
