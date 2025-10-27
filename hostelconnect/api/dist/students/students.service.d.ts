import { Repository } from 'typeorm';
import { Student } from './entities/student.entity';
export declare class StudentsService {
    private readonly studentRepository;
    constructor(studentRepository: Repository<Student>);
    getAllStudents(): Promise<Student[]>;
    getStudent(id: string): Promise<Student>;
    getStudentByStudentId(studentId: string): Promise<Student>;
}
