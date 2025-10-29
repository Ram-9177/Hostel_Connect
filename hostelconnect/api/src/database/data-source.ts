import { DataSource } from 'typeorm';
import { config } from 'dotenv';
import { Student } from '../students/entities/student.entity';
import { User } from '../users/entities/user.entity';
import { AttendanceSession } from '../attendance/entities/attendance-session.entity';
import { AttendanceCheck } from '../attendance/entities/attendance-check.entity';
import { AttendanceRoster } from '../attendance/entities/attendance-roster.entity';
import { GatePass } from '../gatepass/entities/gate-pass.entity';
import { Ad } from '../ads/entities/ad.entity';
import { AdEvent } from '../ads/entities/ad-event.entity';
import { MealIntent } from '../meals/entities/meal-intent.entity';
import { MealOverride } from '../meals/entities/meal-override.entity';
import { Hostel } from '../hostels/entities/hostel.entity';
import { Block } from '../hostels/entities/block.entity';
import { Room } from '../rooms/entities/room.entity';
import { Device } from '../devices/entities/device.entity';
import { Warden } from '../wardens/entities/warden.entity';
import { Chef } from '../chefs/entities/chef.entity';
import { Admin } from '../admins/entities/admin.entity';

config();

const entities = [
  Student,
  User,
  Warden,
  Chef,
  Admin,
  AttendanceSession,
  AttendanceCheck,
  AttendanceRoster,
  // Include GatePass entity always so relations (e.g., Hostel.gatePasses) resolve.
  // Entity is SQLite-friendly (uses 'datetime'), while services can still be gated by env.
  GatePass,
  Ad,
  AdEvent,
  MealIntent,
  MealOverride,
  Hostel,
  Block,
  Room,
  Device,
];

export const dataSourceOptions = {
  type: 'sqlite' as const,
  database: process.env.DB_DATABASE || 'hostelconnect.db',
  entities,
  synchronize: true, // Enable for development
  logging: process.env.NODE_ENV === 'development',
};

const dataSource = new DataSource(dataSourceOptions);
export default dataSource;
