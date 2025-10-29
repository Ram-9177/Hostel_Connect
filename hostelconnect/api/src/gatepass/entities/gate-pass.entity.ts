import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Student } from '../../students/entities/student.entity';
import { Hostel } from '../../hostels/entities/hostel.entity';

export enum GatePassType {
  REGULAR = 'REGULAR',
  EMERGENCY = 'EMERGENCY',
  MEDICAL = 'MEDICAL',
  FAMILY = 'FAMILY',
  ACADEMIC = 'ACADEMIC',
  FOOD = 'FOOD',
}

export enum GatePassStatus {
  PENDING = 'PENDING',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  ACTIVE = 'ACTIVE',
  COMPLETED = 'COMPLETED',
  EXPIRED = 'EXPIRED',
}

@Entity('gate_passes')
export class GatePass {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  studentId: string;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column()
  hostelId: string;

  @Column()
  roomNumber: string;

  @Column()
  reason: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  // Use 'datetime' for SQLite compatibility in local dev
  @Column({ type: 'datetime' })
  startTime: Date;

  @Column({ type: 'datetime' })
  endTime: Date;

  // SQLite does not support enum, store as text and enforce values at application level
  @Column({ type: 'text', default: GatePassStatus.PENDING })
  status: GatePassStatus;

  @Column({ type: 'text', default: GatePassType.REGULAR })
  type: GatePassType;

  @Column({ nullable: true })
  approvedBy: string;

  @Column({ nullable: true })
  approvedByName: string;

  @Column({ type: 'datetime', nullable: true })
  approvedAt: Date;

  @Column({ nullable: true })
  rejectedBy: string;

  @Column({ nullable: true })
  rejectedByName: string;

  @Column({ type: 'datetime', nullable: true })
  rejectedAt: Date;

  @Column({ nullable: true })
  rejectionReason: string;

  @Column({ nullable: true })
  qrCode: string;

  @Column({ nullable: true })
  qrTokenHash: string;

  @Column({ type: 'datetime', nullable: true })
  qrTokenExpiresAt: Date;

  @Column({ type: 'datetime', nullable: true })
  lastUsedAt: Date;

  @Column({ type: 'datetime', nullable: true })
  completedAt: Date;

  @Column({ type: 'datetime', nullable: true })
  expiredAt: Date;

  @Column({ default: false })
  isEmergency: boolean;

  @Column({ nullable: true })
  decisionBy: string;

  @Column({ type: 'datetime', nullable: true })
  decisionAt: Date;

  @Column({ type: 'text', nullable: true })
  note: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Student)
  @JoinColumn({ name: 'studentId' })
  student: Student;

  // Establish relation to Hostel for inverse side mapping from Hostel.gatePasses
  @ManyToOne(() => Hostel, { nullable: true })
  @JoinColumn({ name: 'hostelId' })
  hostel?: Hostel;
}