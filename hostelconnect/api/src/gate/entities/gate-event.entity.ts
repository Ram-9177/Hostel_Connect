import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { GatePass } from '../../gatepass/entities/gate-pass.entity';

@Entity('gate_events')
export class GateEvent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ nullable: true })
  gatePassId: string;

  @Column()
  studentId: string;

  @Column()
  studentName: string;

  @Column({
    type: 'enum',
    enum: ['IN', 'OUT', 'UNKNOWN'],
    default: 'UNKNOWN'
  })
  eventType: 'IN' | 'OUT' | 'UNKNOWN';

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  timestamp: Date;

  @Column({ default: 'Main Gate' })
  location: string;

  @Column({
    type: 'enum',
    enum: ['SUCCESS', 'FAILED'],
    default: 'SUCCESS'
  })
  status: 'SUCCESS' | 'FAILED';

  @Column({ nullable: true })
  qrCode: string;

  @Column({ nullable: true })
  reason: string;

  @Column({ nullable: true })
  securityGuardId: string;

  @Column({ nullable: true })
  securityGuardName: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => GatePass, { nullable: true })
  @JoinColumn({ name: 'gatePassId' })
  gatePass: GatePass;
}