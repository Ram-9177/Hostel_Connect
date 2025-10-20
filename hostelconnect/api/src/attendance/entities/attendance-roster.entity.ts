import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { AttendanceSession } from './attendance-session.entity';
import { Student } from '../../students/entities/student.entity';
import { Room } from '../../rooms/entities/room.entity';

@Entity('attendance_roster')
export class AttendanceRoster {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  sessionId: string;

  @Column('uuid')
  studentId: string;

  @Column('uuid')
  roomId: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => AttendanceSession)
  @JoinColumn({ name: 'sessionId' })
  session: AttendanceSession;

  @ManyToOne(() => Student)
  @JoinColumn({ name: 'studentId' })
  student: Student;

  @ManyToOne(() => Room)
  @JoinColumn({ name: 'roomId' })
  room: Room;
}
