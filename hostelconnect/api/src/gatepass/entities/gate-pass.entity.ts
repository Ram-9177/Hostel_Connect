import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';

export enum GatePassType {
  OUTING = 'OUTING',
  EMERGENCY = 'EMERGENCY',
}

export enum GatePassStatus {
  PENDING = 'PENDING',
  APPROVED = 'APPROVED',
  REJECTED = 'REJECTED',
  CANCELLED = 'CANCELLED',
  EXPIRED = 'EXPIRED',
}

@Entity('gate_passes')
export class GatePass {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  studentId: string;

  @Column('uuid')
  hostelId: string;

  @Column({
    type: 'varchar',
  })
  type: string;

  @Column()
  startTime: Date;

  @Column()
  endTime: Date;

  @Column({
    type: 'varchar',
    default: 'PENDING',
  })
  status: string;

  @Column()
  reason: string;

  @Column({ nullable: true })
  note?: string;

  @Column('uuid', { nullable: true })
  decisionBy?: string;

  @Column({ nullable: true })
  decisionAt?: Date;

  @Column({ nullable: true })
  qrTokenHash?: string;

  @Column({ nullable: true })
  qrTokenExpiresAt?: Date;

  @Column({ default: false })
  isEmergency: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne('Student', 'gatePasses')
  @JoinColumn({ name: 'studentId' })
  student?: any;

  @ManyToOne('Hostel', 'gatePasses')
  @JoinColumn({ name: 'hostelId' })
  hostel?: any;

  @ManyToOne('User', 'gatePasses')
  @JoinColumn({ name: 'decisionBy' })
  decisionByUser?: any;
}
