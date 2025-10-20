import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToOne, JoinColumn } from 'typeorm';

export enum UserRole {
  SUPER_ADMIN = 'SUPER_ADMIN',
  WARDEN_HEAD = 'WARDEN_HEAD',
  WARDEN = 'WARDEN',
  STUDENT = 'STUDENT',
  CHEF = 'CHEF',
}

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column()
  passwordHash: string;

  @Column({
    type: 'varchar',
    default: 'STUDENT',
  })
  role: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Relations - using forward reference to avoid circular dependency
  // Student relation will be handled by Student entity
}