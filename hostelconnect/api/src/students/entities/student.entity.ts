import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToMany } from 'typeorm';

@Entity('students')
export class Student {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  studentId: string;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  phoneNumber: string;

  @Column()
  phone: string; // Alternative phone field

  @Column()
  hostelId: string;

  @Column({ nullable: true })
  roomNumber: string;

  @Column({ nullable: true })
  roomId: string;

  @Column({ nullable: true })
  bedNumber: number;

  @Column({ nullable: true })
  course: string;

  @Column({ nullable: true })
  year: string;

  @Column({ nullable: true })
  emergencyContact: string;

  @Column({ nullable: true })
  emergencyPhone: string;

  @Column({ default: true })
  isActive: boolean;

  @Column({ default: false })
  isEmailVerified: boolean;

  @Column({ nullable: true })
  emailVerificationToken: string;

  @Column({ nullable: true, type: 'datetime' })
  emailVerificationExpires: Date;

  @Column({ nullable: true, type: 'datetime' })
  lastLogin: Date;

  @Column()
  password: string;

  @Column({ default: 'STUDENT' })
  role: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}