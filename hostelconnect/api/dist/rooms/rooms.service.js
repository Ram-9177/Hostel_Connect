"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RoomsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const room_entity_1 = require("./entities/room.entity");
const student_entity_1 = require("../students/entities/student.entity");
const block_entity_1 = require("../hostels/entities/block.entity");
let RoomsService = class RoomsService {
    constructor(roomRepository, studentRepository, blockRepository) {
        this.roomRepository = roomRepository;
        this.studentRepository = studentRepository;
        this.blockRepository = blockRepository;
    }
    async getMap(hostelId) {
        const query = this.roomRepository.createQueryBuilder('room')
            .leftJoinAndSelect('room.block', 'block')
            .leftJoinAndSelect('room.students', 'students')
            .leftJoinAndSelect('block.hostel', 'hostel');
        if (hostelId) {
            query.where('room.hostelId = :hostelId', { hostelId });
        }
        const rooms = await query.getMany();
        const roomMap = rooms.map(room => ({
            id: room.id,
            roomNumber: room.roomNumber,
            blockName: room.block?.name,
            hostelName: room.block?.hostel?.name,
            capacity: room.capacity,
            currentOccupancy: room.currentOccupancy,
            availableBeds: room.capacity - room.currentOccupancy,
            occupancyRate: room.capacity > 0 ? (room.currentOccupancy / room.capacity) * 100 : 0,
            students: room.students?.map(student => ({
                id: student.id,
                name: `${student.firstName} ${student.lastName}`,
                studentId: student.studentId,
                bedNumber: student.bedNumber,
                email: student.email
            })) || []
        }));
        return {
            rooms: roomMap,
            summary: {
                totalRooms: rooms.length,
                occupiedRooms: rooms.filter(r => r.currentOccupancy > 0).length,
                vacantRooms: rooms.filter(r => r.currentOccupancy === 0).length,
                totalCapacity: rooms.reduce((sum, r) => sum + r.capacity, 0),
                totalOccupancy: rooms.reduce((sum, r) => sum + r.currentOccupancy, 0),
                overallOccupancyRate: rooms.length > 0 ?
                    (rooms.reduce((sum, r) => sum + r.currentOccupancy, 0) /
                        rooms.reduce((sum, r) => sum + r.capacity, 0)) * 100 : 0
            }
        };
    }
    async allocate(allocateDto) {
        const { studentId, roomId, bedNumber } = allocateDto;
        const student = await this.studentRepository.findOne({ where: { id: studentId } });
        if (!student) {
            throw new common_1.NotFoundException('Student not found');
        }
        const room = await this.roomRepository.findOne({
            where: { id: roomId },
            relations: ['students']
        });
        if (!room) {
            throw new common_1.NotFoundException('Room not found');
        }
        if (room.currentOccupancy >= room.capacity) {
            throw new common_1.BadRequestException('Room is at full capacity');
        }
        if (bedNumber) {
            const bedOccupied = room.students?.some(s => s.bedNumber === bedNumber);
            if (bedOccupied) {
                throw new common_1.BadRequestException('Bed number is already occupied');
            }
        }
        student.roomId = roomId;
        student.bedNumber = bedNumber;
        await this.studentRepository.save(student);
        room.currentOccupancy += 1;
        await this.roomRepository.save(room);
        return {
            message: 'Room allocated successfully',
            student: {
                id: student.id,
                name: `${student.firstName} ${student.lastName}`,
                studentId: student.studentId,
                roomId: student.roomId,
                bedNumber: student.bedNumber
            },
            room: {
                id: room.id,
                roomNumber: room.roomNumber,
                capacity: room.capacity,
                currentOccupancy: room.currentOccupancy,
                availableBeds: room.capacity - room.currentOccupancy
            }
        };
    }
    async transfer(transferDto) {
        const { studentId, newRoomId, bedNumber } = transferDto;
        const student = await this.studentRepository.findOne({
            where: { id: studentId },
            relations: ['room']
        });
        if (!student) {
            throw new common_1.NotFoundException('Student not found');
        }
        const oldRoomId = student.roomId;
        const newRoom = await this.roomRepository.findOne({
            where: { id: newRoomId },
            relations: ['students']
        });
        if (!newRoom) {
            throw new common_1.NotFoundException('New room not found');
        }
        if (newRoom.currentOccupancy >= newRoom.capacity) {
            throw new common_1.BadRequestException('New room is at full capacity');
        }
        if (bedNumber) {
            const bedOccupied = newRoom.students?.some(s => s.bedNumber === bedNumber);
            if (bedOccupied) {
                throw new common_1.BadRequestException('Bed number is already occupied');
            }
        }
        student.roomId = newRoomId;
        student.bedNumber = bedNumber;
        await this.studentRepository.save(student);
        if (oldRoomId) {
            const oldRoom = await this.roomRepository.findOne({ where: { id: oldRoomId } });
            if (oldRoom) {
                oldRoom.currentOccupancy -= 1;
                await this.roomRepository.save(oldRoom);
            }
        }
        newRoom.currentOccupancy += 1;
        await this.roomRepository.save(newRoom);
        return {
            message: 'Student transferred successfully',
            student: {
                id: student.id,
                name: `${student.firstName} ${student.lastName}`,
                studentId: student.studentId,
                oldRoomId,
                newRoomId: student.roomId,
                bedNumber: student.bedNumber
            },
            newRoom: {
                id: newRoom.id,
                roomNumber: newRoom.roomNumber,
                capacity: newRoom.capacity,
                currentOccupancy: newRoom.currentOccupancy,
                availableBeds: newRoom.capacity - newRoom.currentOccupancy
            }
        };
    }
    async swap(swapDto) {
        const { student1Id, student2Id } = swapDto;
        const student1 = await this.studentRepository.findOne({ where: { id: student1Id } });
        const student2 = await this.studentRepository.findOne({ where: { id: student2Id } });
        if (!student1 || !student2) {
            throw new common_1.NotFoundException('One or both students not found');
        }
        const tempRoomId = student1.roomId;
        const tempBedNumber = student1.bedNumber;
        student1.roomId = student2.roomId;
        student1.bedNumber = student2.bedNumber;
        student2.roomId = tempRoomId;
        student2.bedNumber = tempBedNumber;
        await this.studentRepository.save([student1, student2]);
        return {
            message: 'Students swapped successfully',
            student1: {
                id: student1.id,
                name: `${student1.firstName} ${student1.lastName}`,
                studentId: student1.studentId,
                roomId: student1.roomId,
                bedNumber: student1.bedNumber
            },
            student2: {
                id: student2.id,
                name: `${student2.firstName} ${student2.lastName}`,
                studentId: student2.studentId,
                roomId: student2.roomId,
                bedNumber: student2.bedNumber
            }
        };
    }
    async getRoomDetails(roomId) {
        const room = await this.roomRepository.findOne({
            where: { id: roomId },
            relations: ['students', 'block', 'block.hostel']
        });
        if (!room) {
            throw new common_1.NotFoundException('Room not found');
        }
        return {
            id: room.id,
            roomNumber: room.roomNumber,
            block: {
                id: room.block?.id,
                name: room.block?.name
            },
            hostel: {
                id: room.block?.hostel?.id,
                name: room.block?.hostel?.name
            },
            capacity: room.capacity,
            currentOccupancy: room.currentOccupancy,
            availableBeds: room.capacity - room.currentOccupancy,
            occupancyRate: room.capacity > 0 ? (room.currentOccupancy / room.capacity) * 100 : 0,
            students: room.students?.map(student => ({
                id: student.id,
                name: `${student.firstName} ${student.lastName}`,
                studentId: student.studentId,
                bedNumber: student.bedNumber,
                email: student.email,
                phone: student.phone
            })) || []
        };
    }
    async getAvailableRooms(hostelId) {
        const query = this.roomRepository.createQueryBuilder('room')
            .leftJoinAndSelect('room.block', 'block')
            .leftJoinAndSelect('block.hostel', 'hostel')
            .where('room.currentOccupancy < room.capacity')
            .andWhere('room.isActive = :isActive', { isActive: true });
        if (hostelId) {
            query.andWhere('room.hostelId = :hostelId', { hostelId });
        }
        const rooms = await query.getMany();
        return rooms.map(room => ({
            id: room.id,
            roomNumber: room.roomNumber,
            blockName: room.block?.name,
            hostelName: room.block?.hostel?.name,
            capacity: room.capacity,
            currentOccupancy: room.currentOccupancy,
            availableBeds: room.capacity - room.currentOccupancy,
            occupancyRate: room.capacity > 0 ? (room.currentOccupancy / room.capacity) * 100 : 0
        }));
    }
};
exports.RoomsService = RoomsService;
exports.RoomsService = RoomsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(room_entity_1.Room)),
    __param(1, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __param(2, (0, typeorm_1.InjectRepository)(block_entity_1.Block)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], RoomsService);
//# sourceMappingURL=rooms.service.js.map