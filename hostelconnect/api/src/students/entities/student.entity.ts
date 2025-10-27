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

  @Column()
  phoneNumber: string;

  @Column()
  phone: string; // Alternative phone field

  @Column()
  hostelId: string;

  @Column()
  roomNumber: string;

  @Column({ nullable: true })
  roomId: string;

  @Column({ nullable: true })
  bedNumber: number;

  @Column()
  course: string;

  @Column()
  year: string;

  @Column()
  emergencyContact: string;

  @Column()
  emergencyPhone: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}