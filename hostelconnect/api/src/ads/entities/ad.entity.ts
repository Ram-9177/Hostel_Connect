import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, OneToMany } from 'typeorm';
import { AdEvent } from './ad-event.entity';

export enum AdType {
  INTERSTITIAL = 'INTERSTITIAL',
  BANNER = 'BANNER',
  MINICARD = 'MINICARD',
}

@Entity('ads')
export class Ad {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({
    type: 'varchar',
  })
  type: string;

  @Column()
  assetUrl: string;

  @Column()
  durationS: number;

  @Column({ default: true })
  active: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @OneToMany(() => AdEvent, adEvent => adEvent.ad)
  events: AdEvent[];
}
