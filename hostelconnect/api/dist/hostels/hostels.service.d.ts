import { Repository } from 'typeorm';
import { Hostel } from './entities/hostel.entity';
import { Block } from './entities/block.entity';
import { Room } from '../rooms/entities/room.entity';
import { Student } from '../students/entities/student.entity';
export declare class HostelsService {
    private readonly hostelRepository;
    private readonly blockRepository;
    private readonly roomRepository;
    private readonly studentRepository;
    constructor(hostelRepository: Repository<Hostel>, blockRepository: Repository<Block>, roomRepository: Repository<Room>, studentRepository: Repository<Student>);
    createHostel(createHostelDto: any): Promise<Hostel[]>;
    getAllHostels(): Promise<Hostel[]>;
    getHostelById(id: string): Promise<Hostel>;
    updateHostel(id: string, updateHostelDto: any): Promise<Hostel>;
    deleteHostel(id: string): Promise<{
        message: string;
    }>;
    createBlock(hostelId: string, createBlockDto: any): Promise<Block[]>;
    getBlocksByHostel(hostelId: string): Promise<Block[]>;
    updateBlock(id: string, updateBlockDto: any): Promise<Block>;
    deleteBlock(id: string): Promise<{
        message: string;
    }>;
    createRoom(blockId: string, createRoomDto: any): Promise<Room[]>;
    getRoomsByBlock(blockId: string): Promise<Room[]>;
    getRoomsByHostel(hostelId: string): Promise<Room[]>;
    updateRoom(id: string, updateRoomDto: any): Promise<Room>;
    deleteRoom(id: string): Promise<{
        message: string;
    }>;
    allocateRoom(studentId: string, roomId: string, bedNumber?: number): Promise<{
        message: string;
        student: Student;
        room: Room;
    }>;
    transferStudent(studentId: string, newRoomId: string, bedNumber?: number): Promise<{
        message: string;
        student: Student;
        newRoom: Room;
    }>;
    swapStudents(student1Id: string, student2Id: string): Promise<{
        message: string;
        student1: Student;
        student2: Student;
    }>;
    getHostelAnalytics(hostelId: string): Promise<{
        hostel: {
            id: string;
            name: string;
            address: string;
            capacity: number;
        };
        analytics: {
            totalRooms: number;
            occupiedRooms: number;
            vacantRooms: number;
            totalStudents: number;
            occupancyRate: number;
            capacityUtilization: number;
        };
        blocks: {
            id: string;
            name: string;
            totalRooms: number;
            occupiedRooms: number;
            totalCapacity: any;
            currentOccupancy: any;
        }[];
    }>;
    getRoomMap(hostelId: string): Promise<{
        id: string;
        name: string;
        rooms: {
            id: any;
            roomNumber: any;
            capacity: any;
            currentOccupancy: any;
            availableBeds: number;
            students: any;
        }[];
    }[]>;
}
