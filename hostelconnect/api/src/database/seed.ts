import { DataSource } from 'typeorm';
import { Student } from '../students/entities/student.entity';
import { User } from '../users/entities/user.entity';
import { Hostel } from '../hostels/entities/hostel.entity';
import { Block } from '../hostels/entities/block.entity';
import { Room } from '../rooms/entities/room.entity';
import { AttendanceSession } from '../attendance/entities/attendance-session.entity';
import { AttendanceCheck } from '../attendance/entities/attendance-check.entity';
import { AttendanceRoster } from '../attendance/entities/attendance-roster.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { Ad } from '../ads/entities/ad.entity';
import { AdEvent } from '../ads/entities/ad-event.entity';
import { MealIntent } from '../meals/entities/meal-intent.entity';
import { MealOverride } from '../meals/entities/meal-override.entity';
import { Device } from '../devices/entities/device.entity';
import * as bcrypt from 'bcryptjs';

const dataSource = new DataSource({
  type: 'sqlite',
  database: 'hostelconnect.db',
  entities: [
    Student,
    User,
    Hostel,
    Block,
    Room,
    AttendanceSession,
    AttendanceCheck,
    AttendanceRoster,
    GatePass,
    Ad,
    AdEvent,
    MealIntent,
    MealOverride,
    Device,
  ],
  synchronize: true,
});

async function seedDatabase() {
  try {
    await dataSource.initialize();
    console.log('Database connected');

    const studentRepository = dataSource.getRepository(Student);
    const userRepository = dataSource.getRepository(User);
    const hostelRepository = dataSource.getRepository(Hostel);
    const blockRepository = dataSource.getRepository(Block);
    const roomRepository = dataSource.getRepository(Room);

    // Create demo hostel
    const hostel = hostelRepository.create({
      id: '550e8400-e29b-41d4-a716-446655440001',
      name: 'Demo Hostel',
      address: '123 University Road',
      capacity: 500,
      isActive: true,
    });
    await hostelRepository.save(hostel);

    // Create demo block
    const block = blockRepository.create({
      name: 'Block A',
      hostelId: hostel.id,
      isActive: true,
    });
    await blockRepository.save(block);

    // Create demo room
    const room = roomRepository.create({
      roomNumber: 'A-101',
      blockId: block.id,
      hostelId: hostel.id,
      capacity: 4,
      isActive: true,
    });
    await roomRepository.save(room);

    // Demo users removed. Use admin APIs or migrations to create production users.

  } catch (error) {
    console.error('Error seeding database:', error);
  } finally {
    await dataSource.destroy();
  }
}

seedDatabase();
