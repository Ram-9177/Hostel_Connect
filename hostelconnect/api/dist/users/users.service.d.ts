import { Repository } from 'typeorm';
import { User, UserRole } from './entities/user.entity';
export declare class UsersService {
    private readonly userRepository;
    constructor(userRepository: Repository<User>);
    findById(id: string): Promise<User | null>;
    findByEmail(email: string): Promise<User | null>;
    create(userData: Partial<User>): Promise<User>;
    update(id: string, updateData: Partial<User>): Promise<User>;
    findAll(): Promise<User[]>;
    findByRole(role: UserRole): Promise<User[]>;
}
