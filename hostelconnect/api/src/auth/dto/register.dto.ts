import { IsEmail, IsString, MinLength, IsOptional, IsEnum } from 'class-validator';

export class RegisterDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(6)
  password: string;

  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsString()
  studentId: string;

  @IsString()
  phone: string;

  @IsString()
  hostelId: string;

  @IsOptional()
  @IsString()
  roomId?: string;

  @IsOptional()
  @IsEnum(['STUDENT', 'WARDEN', 'CHEF', 'ADMIN'])
  role?: string = 'STUDENT';
}