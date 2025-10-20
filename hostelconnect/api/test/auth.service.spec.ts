import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from '../src/auth/auth.service';
import { UsersService } from '../src/users/users.service';
import { JwtService } from '@nestjs/jwt';

describe('AuthService', () => {
  let service: AuthService;
  let usersService: UsersService;
  let jwtService: JwtService;

  const mockUser = {
    id: 'test-user-id',
    email: 'test@example.com',
    passwordHash: '$2b$10$test.hash',
    role: 'STUDENT',
    isActive: true,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        {
          provide: UsersService,
          useValue: {
            findByEmail: jest.fn(),
            findById: jest.fn(),
          },
        },
        {
          provide: JwtService,
          useValue: {
            sign: jest.fn(),
            verify: jest.fn(),
          },
        },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    usersService = module.get<UsersService>(UsersService);
    jwtService = module.get<JwtService>(JwtService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should validate user with correct credentials', async () => {
    jest.spyOn(usersService, 'findByEmail').mockResolvedValue(mockUser);
    jest.spyOn(service, 'validateUser').mockResolvedValue(mockUser);

    const result = await service.validateUser('test@example.com', 'password');
    expect(result).toBeDefined();
    expect(result.email).toBe('test@example.com');
  });

  it('should return null for invalid credentials', async () => {
    jest.spyOn(usersService, 'findByEmail').mockResolvedValue(null);

    const result = await service.validateUser('test@example.com', 'wrongpassword');
    expect(result).toBeNull();
  });

  it('should generate tokens on login', async () => {
    jest.spyOn(usersService, 'findByEmail').mockResolvedValue(mockUser);
    jest.spyOn(jwtService, 'sign').mockReturnValue('mock-token');

    const loginDto = {
      email: 'test@example.com',
      password: 'password',
    };

    const result = await service.login(loginDto);
    expect(result).toBeDefined();
    expect(result.accessToken).toBe('mock-token');
    expect(result.refreshToken).toBe('mock-token');
    expect(result.user.email).toBe('test@example.com');
  });
});
