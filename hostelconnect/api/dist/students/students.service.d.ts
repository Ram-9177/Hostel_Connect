import { Repository } from 'typeorm';
import { Student } from './entities/student.entity';
export declare class StudentsService {
    private readonly studentRepository;
    constructor(studentRepository: Repository<Student>);
    getAllStudents(): Promise<Student[]>;
    getStudentById(id: string): Promise<Student>;
    getStudentsByHostel(hostelId: string): Promise<Student[]>;
    getStudentsByRoom(roomId: string): Promise<Student[]>;
    updateStudent(id: string, updateStudentDto: any): Promise<Student>;
    deleteStudent(id: string): Promise<{
        message: string;
    }>;
    getUnassignedStudents(): Promise<Student[]>;
}
