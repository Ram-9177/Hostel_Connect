import { Repository } from 'typeorm';
import { Room } from './entities/room.entity';
import { Student } from '../students/entities/student.entity';
import { Block } from '../hostels/entities/block.entity';
export declare class RoomsService {
    private readonly roomRepository;
    private readonly studentRepository;
    private readonly blockRepository;
    constructor(roomRepository: Repository<Room>, studentRepository: Repository<Student>, blockRepository: Repository<Block>);
    getMap(hostelId?: string): Promise<{
        rooms: {
            id: string;
            roomNumber: string;
            blockName: any;
            hostelName: any;
            capacity: number;
            currentOccupancy: number;
            availableBeds: number;
            occupancyRate: number;
            students: {
                id: any;
                name: string;
                studentId: any;
                bedNumber: any;
                email: any;
            }[];
        }[];
        summary: {
            totalRooms: number;
            occupiedRooms: number;
            vacantRooms: number;
            totalCapacity: number;
            totalOccupancy: number;
            overallOccupancyRate: number;
        };
    }>;
    allocate(allocateDto: any): Promise<{
        message: string;
        student: {
            id: string;
            name: string;
            studentId: string;
            roomId: string;
            bedNumber: number;
        };
        room: {
            id: string;
            roomNumber: string;
            capacity: number;
            currentOccupancy: number;
            availableBeds: number;
        };
    }>;
    transfer(transferDto: any): Promise<{
        message: string;
        student: {
            id: string;
            name: string;
            studentId: string;
            oldRoomId: string;
            newRoomId: string;
            bedNumber: number;
        };
        newRoom: {
            id: string;
            roomNumber: string;
            capacity: number;
            currentOccupancy: number;
            availableBeds: number;
        };
    }>;
    swap(swapDto: any): Promise<{
        message: string;
        student1: {
            id: string;
            name: string;
            studentId: string;
            roomId: string;
            bedNumber: number;
        };
        student2: {
            id: string;
            name: string;
            studentId: string;
            roomId: string;
            bedNumber: number;
        };
    }>;
    getRoomDetails(roomId: string): Promise<{
        id: string;
        roomNumber: string;
        block: {
            id: any;
            name: any;
        };
        hostel: {
            id: any;
            name: any;
        };
        capacity: number;
        currentOccupancy: number;
        availableBeds: number;
        occupancyRate: number;
        students: {
            id: any;
            name: string;
            studentId: any;
            bedNumber: any;
            email: any;
            phone: any;
        }[];
    }>;
    getAvailableRooms(hostelId?: string): Promise<{
        id: string;
        roomNumber: string;
        blockName: any;
        hostelName: any;
        capacity: number;
        currentOccupancy: number;
        availableBeds: number;
        occupancyRate: number;
    }[]>;
}
