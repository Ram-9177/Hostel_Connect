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
exports.HostelsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const hostel_entity_1 = require("./entities/hostel.entity");
const block_entity_1 = require("./entities/block.entity");
const room_entity_1 = require("../rooms/entities/room.entity");
const student_entity_1 = require("../students/entities/student.entity");
let HostelsService = class HostelsService {
    constructor(hostelRepository, blockRepository, roomRepository, studentRepository) {
        this.hostelRepository = hostelRepository;
        this.blockRepository = blockRepository;
        this.roomRepository = roomRepository;
        this.studentRepository = studentRepository;
    }
    async createHostel(createHostelDto) {
        const hostel = this.hostelRepository.create(createHostelDto);
        return await this.hostelRepository.save(hostel);
    }
    async getAllHostels() {
        return await this.hostelRepository.find({
            relations: ['blocks', 'blocks.rooms'],
            order: { createdAt: 'DESC' }
        });
    }
    async getHostelById(id) {
        const hostel = await this.hostelRepository.findOne({
            where: { id },
            relations: ['blocks', 'blocks.rooms', 'blocks.rooms.students']
        });
        if (!hostel) {
            throw new common_1.NotFoundException('Hostel not found');
        }
        return hostel;
    }
    async updateHostel(id, updateHostelDto) {
        const hostel = await this.getHostelById(id);
        Object.assign(hostel, updateHostelDto);
        return await this.hostelRepository.save(hostel);
    }
    async deleteHostel(id) {
        const hostel = await this.getHostelById(id);
        await this.hostelRepository.remove(hostel);
        return { message: 'Hostel deleted successfully' };
    }
    async createBlock(hostelId, createBlockDto) {
        const hostel = await this.getHostelById(hostelId);
        const block = this.blockRepository.create({
            ...createBlockDto,
            hostelId
        });
        return await this.blockRepository.save(block);
    }
    async getBlocksByHostel(hostelId) {
        return await this.blockRepository.find({
            where: { hostelId },
            relations: ['rooms', 'rooms.students'],
            order: { name: 'ASC' }
        });
    }
    async updateBlock(id, updateBlockDto) {
        const block = await this.blockRepository.findOne({ where: { id } });
        if (!block) {
            throw new common_1.NotFoundException('Block not found');
        }
        Object.assign(block, updateBlockDto);
        return await this.blockRepository.save(block);
    }
    async deleteBlock(id) {
        const block = await this.blockRepository.findOne({ where: { id } });
        if (!block) {
            throw new common_1.NotFoundException('Block not found');
        }
        await this.blockRepository.remove(block);
        return { message: 'Block deleted successfully' };
    }
    async createRoom(blockId, createRoomDto) {
        const block = await this.blockRepository.findOne({
            where: { id: blockId },
            relations: ['hostel']
        });
        if (!block) {
            throw new common_1.NotFoundException('Block not found');
        }
        const room = this.roomRepository.create({
            ...createRoomDto,
            blockId,
            hostelId: block.hostelId
        });
        return await this.roomRepository.save(room);
    }
    async getRoomsByBlock(blockId) {
        return await this.roomRepository.find({
            where: { blockId },
            relations: ['students'],
            order: { roomNumber: 'ASC' }
        });
    }
    async getRoomsByHostel(hostelId) {
        return await this.roomRepository.find({
            where: { hostelId },
            relations: ['students', 'block'],
            order: { roomNumber: 'ASC' }
        });
    }
    async updateRoom(id, updateRoomDto) {
        const room = await this.roomRepository.findOne({ where: { id } });
        if (!room) {
            throw new common_1.NotFoundException('Room not found');
        }
        Object.assign(room, updateRoomDto);
        return await this.roomRepository.save(room);
    }
    async deleteRoom(id) {
        const room = await this.roomRepository.findOne({
            where: { id },
            relations: ['students']
        });
        if (!room) {
            throw new common_1.NotFoundException('Room not found');
        }
        if (room.students && room.students.length > 0) {
            throw new common_1.BadRequestException('Cannot delete room with students assigned');
        }
        await this.roomRepository.remove(room);
        return { message: 'Room deleted successfully' };
    }
    async allocateRoom(studentId, roomId, bedNumber) {
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
            const bedOccupied = room.students.some(s => s.bedNumber === bedNumber);
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
            student,
            room: await this.roomRepository.findOne({
                where: { id: roomId },
                relations: ['students', 'block']
            })
        };
    }
    async transferStudent(studentId, newRoomId, bedNumber) {
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
            const bedOccupied = newRoom.students.some(s => s.bedNumber === bedNumber);
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
            student,
            newRoom: await this.roomRepository.findOne({
                where: { id: newRoomId },
                relations: ['students', 'block']
            })
        };
    }
    async swapStudents(student1Id, student2Id) {
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
            student1,
            student2
        };
    }
    async getHostelAnalytics(hostelId) {
        const hostel = await this.getHostelById(hostelId);
        const totalRooms = await this.roomRepository.count({ where: { hostelId } });
        const occupiedRooms = await this.roomRepository.count({
            where: { hostelId, currentOccupancy: (0, typeorm_2.MoreThan)(0) }
        });
        const totalStudents = await this.studentRepository.count({ where: { hostelId } });
        const blocks = await this.getBlocksByHostel(hostelId);
        const blockAnalytics = blocks.map(block => ({
            id: block.id,
            name: block.name,
            totalRooms: block.rooms.length,
            occupiedRooms: block.rooms.filter(room => room.currentOccupancy > 0).length,
            totalCapacity: block.rooms.reduce((sum, room) => sum + room.capacity, 0),
            currentOccupancy: block.rooms.reduce((sum, room) => sum + room.currentOccupancy, 0)
        }));
        return {
            hostel: {
                id: hostel.id,
                name: hostel.name,
                address: hostel.address,
                capacity: hostel.capacity
            },
            analytics: {
                totalRooms,
                occupiedRooms,
                vacantRooms: totalRooms - occupiedRooms,
                totalStudents,
                occupancyRate: totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0,
                capacityUtilization: hostel.capacity > 0 ? (totalStudents / hostel.capacity) * 100 : 0
            },
            blocks: blockAnalytics
        };
    }
    async getRoomMap(hostelId) {
        const blocks = await this.getBlocksByHostel(hostelId);
        const roomMap = blocks.map(block => ({
            id: block.id,
            name: block.name,
            rooms: block.rooms.map(room => ({
                id: room.id,
                roomNumber: room.roomNumber,
                capacity: room.capacity,
                currentOccupancy: room.currentOccupancy,
                availableBeds: room.capacity - room.currentOccupancy,
                students: room.students.map(student => ({
                    id: student.id,
                    name: student.firstName + ' ' + student.lastName,
                    studentId: student.studentId,
                    bedNumber: student.bedNumber
                }))
            }))
        }));
        return roomMap;
    }
};
exports.HostelsService = HostelsService;
exports.HostelsService = HostelsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(hostel_entity_1.Hostel)),
    __param(1, (0, typeorm_1.InjectRepository)(block_entity_1.Block)),
    __param(2, (0, typeorm_1.InjectRepository)(room_entity_1.Room)),
    __param(3, (0, typeorm_1.InjectRepository)(student_entity_1.Student)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], HostelsService);
//# sourceMappingURL=hostels.service.js.map