import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Hostel } from '../../hostels/entities/hostel.entity';

@Entity('attendance_sessions')
export class AttendanceSession {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  hostelId: string;

  @Column('uuid', { array: true })
  wingIds: string[];

  @Column({ type: 'date' })
  date: Date;

  @Column({
    type: 'varchar',
  })
  slot: string;

  @Column()
  startTime: Date;

  @Column()
  endTime: Date;

  @Column({
    type: 'varchar',
  })
  mode: string;

  @Column()
  nonce: string;

  @Column({
    type: 'varchar',
    default: 'ACTIVE',
  })
  status: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Hostel)
  @JoinColumn({ name: 'hostelId' })
  hostel: Hostel;
}
