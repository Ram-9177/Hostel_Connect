import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, MoreThan } from 'typeorm';
import { Hostel } from './entities/hostel.entity';
import { Block } from './entities/block.entity';
import { Room } from '../rooms/entities/room.entity';
import { Student } from '../students/entities/student.entity';

@Injectable()
export class HostelsService {
  constructor(
    @InjectRepository(Hostel)
    private readonly hostelRepository: Repository<Hostel>,
    @InjectRepository(Block)
    private readonly blockRepository: Repository<Block>,
    @InjectRepository(Room)
    private readonly roomRepository: Repository<Room>,
    @InjectRepository(Student)
    private readonly studentRepository: Repository<Student>,
  ) {}

  // Hostel Management
  async createHostel(createHostelDto: any) {
    const hostel = this.hostelRepository.create(createHostelDto);
    return await this.hostelRepository.save(hostel);
  }

  async getAllHostels() {
    return await this.hostelRepository.find({
      relations: ['blocks', 'blocks.rooms'],
      order: { createdAt: 'DESC' }
    });
  }

  async getHostelById(id: string) {
    const hostel = await this.hostelRepository.findOne({
      where: { id },
      relations: ['blocks', 'blocks.rooms', 'blocks.rooms.students']
    });
    
    if (!hostel) {
      throw new NotFoundException('Hostel not found');
    }
    
    return hostel;
  }

  async updateHostel(id: string, updateHostelDto: any) {
    const hostel = await this.getHostelById(id);
    Object.assign(hostel, updateHostelDto);
    return await this.hostelRepository.save(hostel);
  }

  async deleteHostel(id: string) {
    const hostel = await this.getHostelById(id);
    await this.hostelRepository.remove(hostel);
    return { message: 'Hostel deleted successfully' };
  }

  // Block Management
  async createBlock(hostelId: string, createBlockDto: any) {
    const hostel = await this.getHostelById(hostelId);
    const block = this.blockRepository.create({
      ...createBlockDto,
      hostelId
    });
    return await this.blockRepository.save(block);
  }

  async getBlocksByHostel(hostelId: string) {
    return await this.blockRepository.find({
      where: { hostelId },
      relations: ['rooms', 'rooms.students'],
      order: { name: 'ASC' }
    });
  }

  async updateBlock(id: string, updateBlockDto: any) {
    const block = await this.blockRepository.findOne({ where: { id } });
    if (!block) {
      throw new NotFoundException('Block not found');
    }
    Object.assign(block, updateBlockDto);
    return await this.blockRepository.save(block);
  }

  async deleteBlock(id: string) {
    const block = await this.blockRepository.findOne({ where: { id } });
    if (!block) {
      throw new NotFoundException('Block not found');
    }
    await this.blockRepository.remove(block);
    return { message: 'Block deleted successfully' };
  }

  // Room Management
  async createRoom(blockId: string, createRoomDto: any) {
    const block = await this.blockRepository.findOne({ 
      where: { id: blockId },
      relations: ['hostel']
    });
    if (!block) {
      throw new NotFoundException('Block not found');
    }

    const room = this.roomRepository.create({
      ...createRoomDto,
      blockId,
      hostelId: block.hostelId
    });
    return await this.roomRepository.save(room);
  }

  async getRoomsByBlock(blockId: string) {
    return await this.roomRepository.find({
      where: { blockId },
      relations: ['students'],
      order: { roomNumber: 'ASC' }
    });
  }

  async getRoomsByHostel(hostelId: string) {
    return await this.roomRepository.find({
      where: { hostelId },
      relations: ['students', 'block'],
      order: { roomNumber: 'ASC' }
    });
  }

  async updateRoom(id: string, updateRoomDto: any) {
    const room = await this.roomRepository.findOne({ where: { id } });
    if (!room) {
      throw new NotFoundException('Room not found');
    }
    Object.assign(room, updateRoomDto);
    return await this.roomRepository.save(room);
  }

  async deleteRoom(id: string) {
    const room = await this.roomRepository.findOne({ 
      where: { id },
      relations: ['students']
    });
    if (!room) {
      throw new NotFoundException('Room not found');
    }
    
    if (room.students && room.students.length > 0) {
      throw new BadRequestException('Cannot delete room with students assigned');
    }
    
    await this.roomRepository.remove(room);
    return { message: 'Room deleted successfully' };
  }

  // Room Allotment System
  async allocateRoom(studentId: string, roomId: string, bedNumber?: number) {
    const student = await this.studentRepository.findOne({ where: { id: studentId } });
    if (!student) {
      throw new NotFoundException('Student not found');
    }

    const room = await this.roomRepository.findOne({ 
      where: { id: roomId },
      relations: ['students']
    });
    if (!room) {
      throw new NotFoundException('Room not found');
    }

    if (room.currentOccupancy >= room.capacity) {
      throw new BadRequestException('Room is at full capacity');
    }

    // Check if bed number is available
    if (bedNumber) {
      const bedOccupied = room.students.some(s => s.bedNumber === bedNumber);
      if (bedOccupied) {
        throw new BadRequestException('Bed number is already occupied');
      }
    }

    // Update student room assignment
    student.roomId = roomId;
    student.bedNumber = bedNumber;
    await this.studentRepository.save(student);

    // Update room occupancy
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

  async transferStudent(studentId: string, newRoomId: string, bedNumber?: number) {
    const student = await this.studentRepository.findOne({ 
      where: { id: studentId },
      relations: ['room']
    });
    if (!student) {
      throw new NotFoundException('Student not found');
    }

    const oldRoomId = student.roomId;
    const newRoom = await this.roomRepository.findOne({ 
      where: { id: newRoomId },
      relations: ['students']
    });
    if (!newRoom) {
      throw new NotFoundException('New room not found');
    }

    if (newRoom.currentOccupancy >= newRoom.capacity) {
      throw new BadRequestException('New room is at full capacity');
    }

    // Check if bed number is available
    if (bedNumber) {
      const bedOccupied = newRoom.students.some(s => s.bedNumber === bedNumber);
      if (bedOccupied) {
        throw new BadRequestException('Bed number is already occupied');
      }
    }

    // Update student room assignment
    student.roomId = newRoomId;
    student.bedNumber = bedNumber;
    await this.studentRepository.save(student);

    // Update room occupancies
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

  async swapStudents(student1Id: string, student2Id: string) {
    const student1 = await this.studentRepository.findOne({ where: { id: student1Id } });
    const student2 = await this.studentRepository.findOne({ where: { id: student2Id } });
    
    if (!student1 || !student2) {
      throw new NotFoundException('One or both students not found');
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

  // Hostel Analytics
  async getHostelAnalytics(hostelId: string) {
    const hostel = await this.getHostelById(hostelId);
    const totalRooms = await this.roomRepository.count({ where: { hostelId } });
    const occupiedRooms = await this.roomRepository.count({ 
      where: { hostelId, currentOccupancy: MoreThan(0) } 
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

  // Room Map Generation
  async getRoomMap(hostelId: string) {
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
}
