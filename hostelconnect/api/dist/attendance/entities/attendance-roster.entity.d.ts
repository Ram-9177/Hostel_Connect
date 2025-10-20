import { AttendanceSession } from './attendance-session.entity';
import { Student } from '../../students/entities/student.entity';
import { Room } from '../../rooms/entities/room.entity';
export declare class AttendanceRoster {
    id: string;
    sessionId: string;
    studentId: string;
    roomId: string;
    createdAt: Date;
    session: AttendanceSession;
    student: Student;
    room: Room;
}
