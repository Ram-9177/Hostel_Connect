import { RoomsService } from './rooms.service';
export declare class RoomsController {
    private readonly roomsService;
    constructor(roomsService: RoomsService);
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
    getRoomDetails(id: string): Promise<{
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
}
