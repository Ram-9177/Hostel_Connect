import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, Index } from 'typeorm';

@Entity('devices')
@Index(['userId', 'isActive'])
@Index(['deviceToken'])
@Index(['lastActiveAt'])
export class Device {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  userId: string;

  @Column({ unique: true })
  deviceToken: string;

  @Column({
    type: 'enum',
    enum: ['ios', 'android', 'web'],
    default: 'android',
  })
  deviceType: string;

  @Column({ nullable: true })
  deviceName: string;

  @Column({ nullable: true })
  appVersion: string;

  @Column({ nullable: true })
  osVersion: string;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @Column()
  lastActiveAt: Date;
}
