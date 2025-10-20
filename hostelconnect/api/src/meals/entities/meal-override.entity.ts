import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Hostel } from '../../hostels/entities/hostel.entity';
import { User } from '../../users/entities/user.entity';

@Entity('meal_overrides')
export class MealOverride {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'date' })
  date: Date;

  @Column({
    type: 'varchar',
  })
  meal: string;

  @Column('uuid')
  hostelId: string;

  @Column()
  delta: number;

  @Column()
  reason: string;

  @Column('uuid')
  createdBy: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => Hostel)
  @JoinColumn({ name: 'hostelId' })
  hostel: Hostel;

  @ManyToOne(() => User)
  @JoinColumn({ name: 'createdBy' })
  createdByUser: User;
}
