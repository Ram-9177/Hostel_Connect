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
import * as bcrypt from 'bcrypt';

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

    // Create demo users for each role
    const demoUsers = [
      {
        studentId: 'STU001',
        firstName: 'John',
        lastName: 'Student',
        email: 'student@demo.com',
        phone: '9876543210',
        password: 'password123',
        role: 'student',
        roomId: room.id,
        hostelId: hostel.id,
      },
      {
        studentId: 'WARD001',
        firstName: 'Jane',
        lastName: 'Warden',
        email: 'warden@demo.com',
        phone: '9876543211',
        password: 'password123',
        role: 'warden',
        roomId: room.id,
        hostelId: hostel.id,
      },
      {
        studentId: 'WARDH001',
        firstName: 'Mike',
        lastName: 'WardenHead',
        email: 'wardenhead@demo.com',
        phone: '9876543212',
        password: 'password123',
        role: 'warden_head',
        roomId: room.id,
        hostelId: hostel.id,
      },
      {
        studentId: 'CHEF001',
        firstName: 'Sarah',
        lastName: 'Chef',
        email: 'chef@demo.com',
        phone: '9876543213',
        password: 'password123',
        role: 'chef',
        roomId: room.id,
        hostelId: hostel.id,
      },
      {
        studentId: 'ADMIN001',
        firstName: 'Admin',
        lastName: 'Super',
        email: 'admin@demo.com',
        phone: '9876543214',
        password: 'password123',
        role: 'super_admin',
        roomId: room.id,
        hostelId: hostel.id,
      },
    ];

    for (const userData of demoUsers) {
      // Create student record
      const student = studentRepository.create({
        studentId: userData.studentId,
        firstName: userData.firstName,
        lastName: userData.lastName,
        email: userData.email,
        phone: userData.phone,
        password: await bcrypt.hash(userData.password, 10),
        role: userData.role,
        roomId: userData.roomId,
        hostelId: userData.hostelId,
        isActive: true,
      });
      await studentRepository.save(student);

      // Create user record
      const user = userRepository.create({
        email: userData.email,
        passwordHash: await bcrypt.hash(userData.password, 10),
        role: userData.role,
        isActive: true,
      });
      await userRepository.save(user);
    }

    console.log('Demo users created successfully!');
    console.log('Demo credentials:');
    console.log('Student: student@demo.com / password123');
    console.log('Warden: warden@demo.com / password123');
    console.log('Warden Head: wardenhead@demo.com / password123');
    console.log('Chef: chef@demo.com / password123');
    console.log('Super Admin: admin@demo.com / password123');

  } catch (error) {
    console.error('Error seeding database:', error);
  } finally {
    await dataSource.destroy();
  }
}

seedDatabase();
