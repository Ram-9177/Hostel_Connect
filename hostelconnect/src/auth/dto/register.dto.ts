import { IsEmail, IsString, MinLength, IsUUID, IsOptional } from 'class-validator';

export class RegisterDto {
  @IsString()
  studentId: string;

  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsEmail()
  email: string;

  @IsString()
  phone: string;

  @IsString()
  @MinLength(6)
  password: string;

  @IsUUID()
  @IsOptional()
  roomId?: string;

  @IsUUID()
  @IsOptional()
  hostelId?: string;
}
