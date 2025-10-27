import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Hostel } from '../../hostels/entities/hostel.entity';

export enum DeviceType {
  KIOSK_SCANNER = 'KIOSK_SCANNER',
  WARDEN_SCANNER = 'WARDEN_SCANNER',
  GATE = 'GATE',
}

@Entity('devices')
export class Device {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  deviceId: string;

  @Column()
  name: string;

  @Column({
    type: 'varchar',
  })
  type: string;

  @Column('uuid')
  hostelId: string;

  @Column({ nullable: true })
  location?: string;

  @Column({ default: true })
  isActive: boolean;

  @Column({ nullable: true })
  lastSeen?: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Hostel)
  @JoinColumn({ name: 'hostelId' })
  hostel: Hostel;
}
