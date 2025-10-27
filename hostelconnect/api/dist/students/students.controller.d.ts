import { StudentsService } from './students.service';
export declare class StudentsController {
    private readonly studentsService;
    constructor(studentsService: StudentsService);
    getAllStudents(): Promise<import("./entities/student.entity").Student[]>;
    getStudent(id: string): Promise<import("./entities/student.entity").Student>;
    getStudentByStudentId(studentId: string): Promise<import("./entities/student.entity").Student>;
}
