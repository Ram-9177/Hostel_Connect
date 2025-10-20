"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const typeorm_1 = require("typeorm");
const student_entity_1 = require("../students/entities/student.entity");
const user_entity_1 = require("../users/entities/user.entity");
const hostel_entity_1 = require("../hostels/entities/hostel.entity");
const block_entity_1 = require("../hostels/entities/block.entity");
const room_entity_1 = require("../rooms/entities/room.entity");
const attendance_session_entity_1 = require("../attendance/entities/attendance-session.entity");
const attendance_check_entity_1 = require("../attendance/entities/attendance-check.entity");
const attendance_roster_entity_1 = require("../attendance/entities/attendance-roster.entity");
const gate_pass_entity_1 = require("../gatepass/entities/gate-pass.entity");
const ad_entity_1 = require("../ads/entities/ad.entity");
const ad_event_entity_1 = require("../ads/entities/ad-event.entity");
const meal_intent_entity_1 = require("../meals/entities/meal-intent.entity");
const meal_override_entity_1 = require("../meals/entities/meal-override.entity");
const device_entity_1 = require("../devices/entities/device.entity");
const bcrypt = require("bcrypt");
const dataSource = new typeorm_1.DataSource({
    type: 'sqlite',
    database: 'hostelconnect.db',
    entities: [
        student_entity_1.Student,
        user_entity_1.User,
        hostel_entity_1.Hostel,
        block_entity_1.Block,
        room_entity_1.Room,
        attendance_session_entity_1.AttendanceSession,
        attendance_check_entity_1.AttendanceCheck,
        attendance_roster_entity_1.AttendanceRoster,
        gate_pass_entity_1.GatePass,
        ad_entity_1.Ad,
        ad_event_entity_1.AdEvent,
        meal_intent_entity_1.MealIntent,
        meal_override_entity_1.MealOverride,
        device_entity_1.Device,
    ],
    synchronize: true,
});
async function seedDatabase() {
    try {
        await dataSource.initialize();
        console.log('Database connected');
        const studentRepository = dataSource.getRepository(student_entity_1.Student);
        const userRepository = dataSource.getRepository(user_entity_1.User);
        const hostelRepository = dataSource.getRepository(hostel_entity_1.Hostel);
        const blockRepository = dataSource.getRepository(block_entity_1.Block);
        const roomRepository = dataSource.getRepository(room_entity_1.Room);
        const hostel = hostelRepository.create({
            id: '550e8400-e29b-41d4-a716-446655440001',
            name: 'Demo Hostel',
            address: '123 University Road',
            capacity: 500,
            isActive: true,
        });
        await hostelRepository.save(hostel);
        const block = blockRepository.create({
            name: 'Block A',
            hostelId: hostel.id,
            isActive: true,
        });
        await blockRepository.save(block);
        const room = roomRepository.create({
            roomNumber: 'A-101',
            blockId: block.id,
            hostelId: hostel.id,
            capacity: 4,
            isActive: true,
        });
        await roomRepository.save(room);
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
    }
    catch (error) {
        console.error('Error seeding database:', error);
    }
    finally {
        await dataSource.destroy();
    }
}
seedDatabase();
//# sourceMappingURL=seed.js.map