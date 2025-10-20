import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, Unique } from 'typeorm';
import { Student } from '../../students/entities/student.entity';

export enum MealType {
  BREAKFAST = 'BREAKFAST',
  LUNCH = 'LUNCH',
  SNACKS = 'SNACKS',
  DINNER = 'DINNER',
}

export enum MealIntentValue {
  YES = 'YES',
  NO = 'NO',
}

@Entity('meal_intents')
@Unique(['studentId', 'date', 'meal'])
export class MealIntent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'date' })
  date: Date;

  @Column({
    type: 'varchar',
  })
  meal: string;

  @Column('uuid')
  studentId: string;

  @Column({
    type: 'varchar',
  })
  value: string;

  @Column()
  decidedAt: Date;

  @Column({ nullable: true })
  diet?: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Student)
  @JoinColumn({ name: 'studentId' })
  student: Student;
}
