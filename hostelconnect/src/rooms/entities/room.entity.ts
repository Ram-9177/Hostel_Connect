import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, OneToMany, JoinColumn } from 'typeorm';

@Entity('rooms')
export class Room {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  roomNumber: string;

  @Column()
  blockId: string;

  @Column()
  hostelId: string;

  @Column({ default: 1 })
  floor: number;

  @Column({ default: 2 })
  capacity: number;

  @Column({ default: 0 })
  currentOccupancy: number;

  @Column({ default: true })
  isActive: boolean;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne('Block', 'rooms')
  @JoinColumn({ name: 'blockId' })
  block: any;

  @OneToMany('Student', 'room')
  students: any[];
}