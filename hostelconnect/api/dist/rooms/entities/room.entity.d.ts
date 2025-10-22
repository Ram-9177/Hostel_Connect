export declare class Room {
    id: string;
    roomNumber: string;
    blockId: string;
    hostelId: string;
    floor: number;
    capacity: number;
    currentOccupancy: number;
    isActive: boolean;
    createdAt: Date;
    updatedAt: Date;
    block: any;
    students: any[];
}
