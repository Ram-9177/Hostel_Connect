import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn, Index } from 'typeorm';

@Entity('file_uploads')
@Index(['userId', 'category'])
@Index(['uploadedAt'])
export class FileUpload {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  filename: string;

  @Column()
  originalName: string;

  @Column()
  mimetype: string;

  @Column('bigint')
  size: number;

  @Column()
  userId: string;

  @Column({
    type: 'enum',
    enum: ['profile', 'document', 'notice'],
    default: 'document',
  })
  category: string;

  @Column({ nullable: true })
  noticeId: string;

  @Column({ nullable: true })
  description: string;

  @Column({ nullable: true })
  tags: string;

  @CreateDateColumn()
  uploadedAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
