import { StudentsService } from './students.service';
export declare class StudentsController {
    private readonly studentsService;
    constructor(studentsService: StudentsService);
    getAllStudents(): Promise<import("./entities/student.entity").Student[]>;
    getUnassignedStudents(): Promise<import("./entities/student.entity").Student[]>;
    getStudentsByHostel(hostelId: string): Promise<import("./entities/student.entity").Student[]>;
    getStudentsByRoom(roomId: string): Promise<import("./entities/student.entity").Student[]>;
    getStudentById(id: string): Promise<import("./entities/student.entity").Student>;
    updateStudent(id: string, updateStudentDto: any): Promise<import("./entities/student.entity").Student>;
    deleteStudent(id: string): Promise<{
        message: string;
    }>;
}
