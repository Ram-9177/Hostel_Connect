import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Student } from '../../students/entities/student.entity';

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

  @Column({ type: 'timestamp' })
  startTime: Date;

  @Column({ type: 'timestamp' })
  endTime: Date;

  @Column({
    type: 'enum',
    enum: GatePassStatus,
    default: GatePassStatus.PENDING
  })
  status: GatePassStatus;

  @Column({
    type: 'enum',
    enum: GatePassType,
    default: GatePassType.REGULAR
  })
  type: GatePassType;

  @Column({ nullable: true })
  approvedBy: string;

  @Column({ nullable: true })
  approvedByName: string;

  @Column({ type: 'timestamp', nullable: true })
  approvedAt: Date;

  @Column({ nullable: true })
  rejectedBy: string;

  @Column({ nullable: true })
  rejectedByName: string;

  @Column({ type: 'timestamp', nullable: true })
  rejectedAt: Date;

  @Column({ nullable: true })
  rejectionReason: string;

  @Column({ nullable: true })
  qrCode: string;

  @Column({ nullable: true })
  qrTokenHash: string;

  @Column({ type: 'timestamp', nullable: true })
  qrTokenExpiresAt: Date;

  @Column({ type: 'timestamp', nullable: true })
  lastUsedAt: Date;

  @Column({ type: 'timestamp', nullable: true })
  completedAt: Date;

  @Column({ type: 'timestamp', nullable: true })
  expiredAt: Date;

  @Column({ default: false })
  isEmergency: boolean;

  @Column({ nullable: true })
  decisionBy: string;

  @Column({ type: 'timestamp', nullable: true })
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
}