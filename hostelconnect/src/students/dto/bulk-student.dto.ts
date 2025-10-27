import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsEmail, IsOptional, IsBoolean } from 'class-validator';

export class BulkStudentDto {
  @ApiProperty({ description: 'Student name' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Hall ticket number / Student ID' })
  @IsString()
  hallTicket: string;

  @ApiProperty({ description: 'College code' })
  @IsString()
  collegeCode: string;

  @ApiProperty({ description: 'Phone number' })
  @IsString()
  number: string;

  @ApiProperty({ description: 'Hostel name' })
  @IsString()
  hostelName: string;

  @ApiPropertyOptional({ description: 'Email address (auto-generated if not provided)' })
  @IsOptional()
  @IsEmail()
  email?: string;
}

export class UpdateStudentDto {
  @ApiPropertyOptional({ description: 'First name' })
  @IsOptional()
  @IsString()
  firstName?: string;

  @ApiPropertyOptional({ description: 'Last name' })
  @IsOptional()
  @IsString()
  lastName?: string;

  @ApiPropertyOptional({ description: 'Email address' })
  @IsOptional()
  @IsEmail()
  email?: string;

  @ApiPropertyOptional({ description: 'Phone number' })
  @IsOptional()
  @IsString()
  phone?: string;

  @ApiPropertyOptional({ description: 'Room ID' })
  @IsOptional()
  @IsString()
  roomId?: string;

  @ApiPropertyOptional({ description: 'Bed number' })
  @IsOptional()
  bedNumber?: number;

  @ApiPropertyOptional({ description: 'Hostel ID' })
  @IsOptional()
  @IsString()
  hostelId?: string;

  @ApiPropertyOptional({ description: 'Active status' })
  @IsOptional()
  isActive?: boolean;
}

export class ResetPasswordDto {
  @ApiProperty({ description: 'Student ID' })
  @IsString()
  studentId: string;

  @ApiPropertyOptional({ description: 'New password (auto-generated if not provided)' })
  @IsOptional()
  @IsString()
  newPassword?: string;
}
