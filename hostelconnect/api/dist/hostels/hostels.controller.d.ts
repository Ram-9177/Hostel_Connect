import { HostelsService } from './hostels.service';
export declare class HostelsController {
    private readonly hostelsService;
    constructor(hostelsService: HostelsService);
    createHostel(createHostelDto: any): Promise<import("./entities/hostel.entity").Hostel[]>;
    getAllHostels(): Promise<import("./entities/hostel.entity").Hostel[]>;
    getHostelById(id: string): Promise<import("./entities/hostel.entity").Hostel>;
    updateHostel(id: string, updateHostelDto: any): Promise<import("./entities/hostel.entity").Hostel>;
    deleteHostel(id: string): Promise<{
        message: string;
    }>;
    createBlock(hostelId: string, createBlockDto: any): Promise<import("./entities/block.entity").Block[]>;
    getBlocksByHostel(hostelId: string): Promise<import("./entities/block.entity").Block[]>;
    updateBlock(id: string, updateBlockDto: any): Promise<import("./entities/block.entity").Block>;
    deleteBlock(id: string): Promise<{
        message: string;
    }>;
    createRoom(blockId: string, createRoomDto: any): Promise<import("../rooms/entities/room.entity").Room[]>;
    getRoomsByBlock(blockId: string): Promise<import("../rooms/entities/room.entity").Room[]>;
    getRoomsByHostel(hostelId: string): Promise<import("../rooms/entities/room.entity").Room[]>;
    updateRoom(id: string, updateRoomDto: any): Promise<import("../rooms/entities/room.entity").Room>;
    deleteRoom(id: string): Promise<{
        message: string;
    }>;
    allocateRoom(roomId: string, allocateDto: any): Promise<{
        message: string;
        student: import("../students/entities/student.entity").Student;
        room: import("../rooms/entities/room.entity").Room;
    }>;
    transferStudent(studentId: string, transferDto: any): Promise<{
        message: string;
        student: import("../students/entities/student.entity").Student;
        newRoom: import("../rooms/entities/room.entity").Room;
    }>;
    swapStudents(swapDto: any): Promise<{
        message: string;
        student1: import("../students/entities/student.entity").Student;
        student2: import("../students/entities/student.entity").Student;
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
