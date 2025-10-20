import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { AttendanceSession } from './attendance-session.entity';
import { Student } from '../../students/entities/student.entity';
import { User } from '../../users/entities/user.entity';
import { Device } from '../../devices/entities/device.entity';

export enum AttendanceCheckMethod {
  STUDENT_QR = 'STUDENT_QR',
  MANUAL = 'MANUAL',
  GATE = 'GATE',
}

@Entity('attendance_checks')
export class AttendanceCheck {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  sessionId: string;

  @Column('uuid')
  studentId: string;

  @Column({
    type: 'varchar',
  })
  method: string;

  @Column()
  timestamp: Date;

  @Column('uuid', { nullable: true })
  wardenId?: string;

  @Column('uuid', { nullable: true })
  deviceId?: string;

  @Column({ nullable: true })
  reason?: string;

  @Column({ nullable: true })
  photoUrl?: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => AttendanceSession)
  @JoinColumn({ name: 'sessionId' })
  session: AttendanceSession;

  @ManyToOne(() => Student)
  @JoinColumn({ name: 'studentId' })
  student: Student;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'wardenId' })
  warden?: User;

  @ManyToOne(() => Device)
  @JoinColumn({ name: 'deviceId' })
  device?: Device;
}
