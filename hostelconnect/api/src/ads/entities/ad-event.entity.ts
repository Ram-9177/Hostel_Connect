import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Ad } from './ad.entity';
import { User } from '../../users/entities/user.entity';

export enum AdEventResult {
  STARTED = 'STARTED',
  COMPLETED = 'COMPLETED',
  SKIPPED = 'SKIPPED',
}

@Entity('ad_events')
export class AdEvent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('uuid')
  adId: string;

  @Column('uuid')
  userId: string;

  @Column()
  module: string;

  @Column()
  timestamp: Date;

  @Column({
    type: 'varchar',
  })
  result: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => Ad)
  @JoinColumn({ name: 'adId' })
  ad: Ad;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'userId' })
  user: User;
}
