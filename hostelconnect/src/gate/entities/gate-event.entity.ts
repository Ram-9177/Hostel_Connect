import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { GatePass } from '../../gatepass/entities/gate-pass.entity';
import { Student } from '../../students/entities/student.entity';
import { Device } from '../../devices/entities/device.entity';
import { User } from '../../users/entities/user.entity';

@Entity('gate_events')
export class GateEvent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  passId: string;

  @Column('uuid')
  studentId: string;

  @Column({
    type: 'varchar',
  })
  eventType: string;

  @Column({
    type: 'varchar',
  })
  method: string;

  @Column('uuid', { nullable: true })
  deviceId?: string;

  @Column('uuid', { nullable: true })
  guardUserId?: string;

  @Column()
  timestamp: Date;

  @Column({ nullable: true })
  latitude?: number;

  @Column({ nullable: true })
  longitude?: number;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => GatePass)
  @JoinColumn({ name: 'passId' })
  pass: GatePass;

  @ManyToOne(() => Student)
  @JoinColumn({ name: 'studentId' })
  student: Student;

  @ManyToOne(() => Device)
  @JoinColumn({ name: 'deviceId' })
  device?: Device;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'guardUserId' })
  guardUser?: User;
}
