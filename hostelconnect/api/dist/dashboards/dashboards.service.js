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
exports.DashboardsService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
let DashboardsService = class DashboardsService {
    constructor(dataSource) {
        this.dataSource = dataSource;
    }
    async getHostelLive(hostelId) {
        const query = `
      SELECT 
        h.id as "hostelId",
        h.name as "hostelName",
        COUNT(DISTINCT s.id) as "totalStrength",
        COUNT(DISTINCT CASE WHEN gp.status = 'APPROVED' AND gp.start_time <= NOW() AND gp.end_time >= NOW() THEN s.id END) as "outpassNow",
        COUNT(DISTINCT CASE WHEN gp.status = 'APPROVED' AND gp.start_time <= NOW() AND gp.end_time >= NOW() THEN s.id END) as "presentDerived",
        COUNT(DISTINCT CASE WHEN ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as "scanPresent",
        COUNT(DISTINCT CASE WHEN ac.method = 'MANUAL' AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as "manualPresent",
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'KIOSK_SCANNER'
        ) AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as "kioskScans",
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'WARDEN_SCANNER'
        ) AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as "wardenScans",
        NOW() as "updatedAt"
      FROM hostels h
      LEFT JOIN students s ON s.hostel_id = h.id AND s.is_active = true
      LEFT JOIN gate_passes gp ON gp.student_id = s.id
      LEFT JOIN attendance_checks ac ON ac.student_id = s.id
      WHERE h.is_active = true
      ${hostelId ? 'AND h.id = $1' : ''}
      GROUP BY h.id, h.name
    `;
        const parameters = hostelId ? [hostelId] : [];
        const result = await this.dataSource.query(query, parameters);
        return result.map(row => ({
            hostelId: row.hostelId,
            hostelName: row.hostelName,
            totalStrength: parseInt(row.totalStrength) || 0,
            outpassNow: parseInt(row.outpassNow) || 0,
            presentDerived: parseInt(row.presentDerived) || 0,
            scanPresent: parseInt(row.scanPresent) || 0,
            manualPresent: parseInt(row.manualPresent) || 0,
            kioskScans: parseInt(row.kioskScans) || 0,
            wardenScans: parseInt(row.wardenScans) || 0,
            updatedAt: row.updatedAt,
        }));
    }
    async getAttendanceSessionSummary(sessionId) {
        const query = `
      SELECT 
        as.id as "sessionId",
        as.hostel_id as "hostelId",
        as.date,
        as.slot,
        as.mode,
        COUNT(DISTINCT ar.student_id) as "totalRoster",
        COUNT(DISTINCT ac.student_id) as "scannedCount",
        COUNT(DISTINCT CASE WHEN ac.method = 'MANUAL' THEN ac.student_id END) as "manualCount",
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'KIOSK_SCANNER'
        ) THEN ac.student_id END) as "kioskCount",
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'WARDEN_SCANNER'
        ) THEN ac.student_id END) as "wardenCount",
        ROUND(
          (COUNT(DISTINCT ac.student_id)::float / NULLIF(COUNT(DISTINCT ar.student_id), 0)) * 100, 
          2
        ) as "attendancePercentage",
        as.updated_at as "updatedAt"
      FROM attendance_sessions as
      LEFT JOIN attendance_roster ar ON ar.session_id = as.id
      LEFT JOIN attendance_checks ac ON ac.session_id = as.id
      WHERE as.id = $1
      GROUP BY as.id, as.hostel_id, as.date, as.slot, as.mode, as.updated_at
    `;
        const result = await this.dataSource.query(query, [sessionId]);
        if (result.length === 0) {
            throw new Error('Attendance session not found');
        }
        const row = result[0];
        return {
            sessionId: row.sessionId,
            hostelId: row.hostelId,
            date: row.date,
            slot: row.slot,
            mode: row.mode,
            totalRoster: parseInt(row.totalRoster) || 0,
            scannedCount: parseInt(row.scannedCount) || 0,
            manualCount: parseInt(row.manualCount) || 0,
            kioskCount: parseInt(row.kioskCount) || 0,
            wardenCount: parseInt(row.wardenCount) || 0,
            attendancePercentage: parseFloat(row.attendancePercentage) || 0,
            updatedAt: row.updatedAt,
        };
    }
    async getGateFunnel(hostelId, days = 7) {
        const query = `
      SELECT 
        DATE(gp.created_at) as date,
        h.id as "hostelId",
        h.name as "hostelName",
        COUNT(*) as "totalRequests",
        COUNT(CASE WHEN gp.status = 'APPROVED' THEN 1 END) as "approvedCount",
        COUNT(CASE WHEN gp.status = 'REJECTED' THEN 1 END) as "rejectedCount",
        COUNT(CASE WHEN gp.status = 'CANCELLED' THEN 1 END) as "cancelledCount",
        COUNT(CASE WHEN gp.status = 'EXPIRED' THEN 1 END) as "expiredCount",
        ROUND(
          (COUNT(CASE WHEN gp.status = 'APPROVED' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100, 
          2
        ) as "approvalRate",
        AVG(CASE WHEN gp.decision_at IS NOT NULL THEN 
          EXTRACT(EPOCH FROM (gp.decision_at - gp.created_at))/60 
        END) as "avgDecisionTimeMinutes",
        COUNT(CASE WHEN ge.event_type = 'OUT' THEN 1 END) as "outScans",
        COUNT(CASE WHEN ge.event_type = 'IN' THEN 1 END) as "inScans"
      FROM gate_passes gp
      JOIN hostels h ON h.id = gp.hostel_id
      LEFT JOIN gate_events ge ON ge.pass_id = gp.id
      WHERE gp.created_at >= CURRENT_DATE - INTERVAL '${days} days'
      ${hostelId ? 'AND h.id = $1' : ''}
      GROUP BY DATE(gp.created_at), h.id, h.name
      ORDER BY date DESC
    `;
        const parameters = hostelId ? [hostelId] : [];
        return this.dataSource.query(query, parameters);
    }
    async getMealForecast(hostelId, days = 7) {
        const query = `
      SELECT 
        mi.date,
        mi.meal,
        h.id as "hostelId",
        h.name as "hostelName",
        COUNT(CASE WHEN mi.value = 'YES' THEN 1 END) as "yesCount",
        COUNT(CASE WHEN mi.value = 'NO' THEN 1 END) as "noCount",
        COUNT(*) as "totalIntents",
        ROUND(
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100, 
          2
        ) as "yesPercentage",
        COALESCE(mo.delta, 0) as "overrideDelta",
        ROUND(
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100 + 
          COALESCE(mo.delta, 0), 
          2
        ) as "forecastCount"
      FROM meal_intents mi
      JOIN students s ON s.id = mi.student_id
      JOIN hostels h ON h.id = s.hostel_id
      LEFT JOIN meal_overrides mo ON mo.date = mi.date AND mo.meal = mi.meal AND mo.hostel_id = h.id
      WHERE mi.date >= CURRENT_DATE AND mi.date <= CURRENT_DATE + INTERVAL '${days} days'
      ${hostelId ? 'AND h.id = $1' : ''}
      GROUP BY mi.date, mi.meal, h.id, h.name, mo.delta
      ORDER BY mi.date, mi.meal
    `;
        const parameters = hostelId ? [hostelId] : [];
        return this.dataSource.query(query, parameters);
    }
    async getMonthlyAnalytics(hostelId, month) {
        const targetMonth = month || new Date().toISOString().slice(0, 7);
        const query = `
      SELECT 
        '${targetMonth}' as month,
        h.id as "hostelId",
        h.name as "hostelName",
        -- Attendance metrics
        COUNT(DISTINCT CASE WHEN as.date >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN as.id END) as "attendanceSessions",
        ROUND(AVG(CASE WHEN as.date >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN 
          (SELECT COUNT(DISTINCT ac.student_id)::float / NULLIF(COUNT(DISTINCT ar.student_id), 0) * 100
           FROM attendance_checks ac
           LEFT JOIN attendance_roster ar ON ar.session_id = as.id
           WHERE ac.session_id = as.id)
        END), 2) as "avgAttendancePercentage",
        
        -- Gate pass metrics
        COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN 1 END) as "gatePassRequests",
        COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', '${targetMonth}-01'::date) AND gp.status = 'APPROVED' THEN 1 END) as "gatePassApproved",
        ROUND(
          (COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', '${targetMonth}-01'::date) AND gp.status = 'APPROVED' THEN 1 END)::float / 
           NULLIF(COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN 1 END), 0)) * 100, 
          2
        ) as "gatePassApprovalRate",
        
        -- Meal metrics
        COUNT(DISTINCT CASE WHEN mi.date >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN mi.date END) as "mealDays",
        ROUND(AVG(CASE WHEN mi.date >= DATE_TRUNC('month', '${targetMonth}-01'::date) THEN 
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100
        END), 2) as "avgMealYesPercentage",
        
        -- Room metrics
        COUNT(DISTINCT CASE WHEN s.is_active = true THEN s.room_id END) as "occupiedRooms",
        COUNT(DISTINCT r.id) as "totalRooms",
        ROUND(
          (COUNT(DISTINCT CASE WHEN s.is_active = true THEN s.room_id END)::float / 
           NULLIF(COUNT(DISTINCT r.id), 0)) * 100, 
          2
        ) as "roomOccupancyPercentage",
        
        NOW() as "updatedAt"
      FROM hostels h
      LEFT JOIN students s ON s.hostel_id = h.id
      LEFT JOIN rooms r ON r.block_id IN (SELECT id FROM blocks WHERE hostel_id = h.id)
      LEFT JOIN gate_passes gp ON gp.hostel_id = h.id
      LEFT JOIN meal_intents mi ON mi.student_id = s.id
      LEFT JOIN attendance_sessions as ON as.hostel_id = h.id
      WHERE h.is_active = true
      ${hostelId ? 'AND h.id = $1' : ''}
      GROUP BY h.id, h.name
    `;
        const parameters = hostelId ? [hostelId] : [];
        const result = await this.dataSource.query(query, parameters);
        return result[0] || null;
    }
    async getRoomOccupancy(hostelId) {
        const query = `
      SELECT 
        CURRENT_DATE as date,
        h.id as "hostelId",
        h.name as "hostelName",
        b.id as "blockId",
        b.name as "blockName",
        COUNT(DISTINCT r.id) as "totalRooms",
        COUNT(DISTINCT CASE WHEN s.id IS NOT NULL THEN r.id END) as "occupiedRooms",
        COUNT(DISTINCT s.id) as "totalStudents",
        ROUND(
          (COUNT(DISTINCT CASE WHEN s.id IS NOT NULL THEN r.id END)::float / NULLIF(COUNT(DISTINCT r.id), 0)) * 100, 
          2
        ) as "occupancyPercentage",
        COUNT(DISTINCT CASE WHEN s.id IS NOT NULL AND s.is_active = true THEN r.id END) as "activeOccupancy"
      FROM hostels h
      JOIN blocks b ON b.hostel_id = h.id
      JOIN rooms r ON r.block_id = b.id
      LEFT JOIN students s ON s.room_id = r.id
      WHERE h.is_active = true AND b.is_active = true AND r.is_active = true
      ${hostelId ? 'AND h.id = $1' : ''}
      GROUP BY h.id, h.name, b.id, b.name
      ORDER BY h.name, b.name
    `;
        const parameters = hostelId ? [hostelId] : [];
        return this.dataSource.query(query, parameters);
    }
    async refreshMaterializedViews() {
        const views = [
            'mv_hostel_live',
            'mv_attendance_session',
            'mv_gate_funnel_day',
            'mv_meal_forecast_day',
            'mv_room_occupancy_day',
            'mv_monthly_analytics',
        ];
        for (const view of views) {
            try {
                await this.dataSource.query(`REFRESH MATERIALIZED VIEW ${view}`);
                console.log(`Refreshed materialized view: ${view}`);
            }
            catch (error) {
                console.error(`Failed to refresh materialized view ${view}:`, error);
            }
        }
    }
    async getStudentDashboard(studentId) {
        return {
            student: {
                id: studentId,
                name: 'Student Name',
                studentId: 'STU001',
                email: 'student@example.com',
                hostel: 'Phoenix Hall',
                room: '301-A',
                floor: '3rd Floor',
            },
            attendance: {
                percentage: 92,
                present: 23,
                total: 25,
                lastMarked: new Date().toISOString(),
                status: 'PRESENT',
            },
            gatePass: {
                active: 0,
                pending: 1,
                approved: 5,
                rejected: 0,
            },
            meals: {
                today: { breakfast: true, lunch: true, dinner: true },
                tomorrow: { breakfast: false, lunch: false, dinner: false },
                lockTime: '23:00',
            },
            complaints: {
                pending: 1,
                resolved: 3,
                total: 4,
            },
            notices: {
                unread: 2,
                total: 10,
            },
        };
    }
    async getWardenDashboard(wardenId) {
        const hostelLive = await this.getHostelLive();
        return {
            hostel: hostelLive[0] || {},
            gatePasses: {
                pending: 5,
                approved: 12,
                rejected: 2,
                activeNow: 8,
            },
            complaints: {
                pending: 8,
                inProgress: 3,
                resolved: 25,
            },
            rooms: {
                singleOccupancy: 10,
                doubleOccupancy: 40,
                tripleOccupancy: 10,
                vacant: 2,
            },
        };
    }
    async getWardenHeadDashboard(wardenHeadId) {
        const hostels = await this.getHostelLive();
        return {
            hostels: hostels.map(h => ({
                name: h.hostelName,
                students: h.totalStrength,
                attendance: Math.round((h.scanPresent / h.totalStrength) * 100),
                occupancy: 97,
            })),
            globalStats: {
                totalStudents: hostels.reduce((acc, h) => acc + h.totalStrength, 0),
                totalHostels: hostels.length,
                averageAttendance: 88,
                averageOccupancy: 97,
            },
            gatePasses: {
                pending: 12,
                approved: 45,
                rejected: 5,
                activeNow: 18,
            },
        };
    }
    async getAdminDashboard(adminId) {
        const hostels = await this.getHostelLive();
        return {
            overview: {
                totalStudents: hostels.reduce((acc, h) => acc + h.totalStrength, 0),
                totalHostels: hostels.length,
                totalWardens: 8,
                totalStaff: 35,
            },
            hostels: hostels.map(h => ({
                name: h.hostelName,
                students: h.totalStrength,
                attendance: Math.round((h.scanPresent / h.totalStrength) * 100),
                occupancy: 97,
            })),
            systemHealth: {
                apiStatus: 'OPERATIONAL',
                databaseStatus: 'OPERATIONAL',
                cacheStatus: 'OPERATIONAL',
                uptime: '99.9%',
            },
        };
    }
    async getChefDashboard(chefId) {
        const mealForecast = await this.getMealForecast();
        return {
            tomorrowForecast: {
                date: new Date(Date.now() + 86400000).toISOString().split('T')[0],
                isLocked: new Date().getHours() >= 23,
                meals: [
                    { name: 'Breakfast', yes: 165, buffer: 17, total: 182 },
                    { name: 'Lunch', yes: 172, buffer: 18, total: 190 },
                    { name: 'Dinner', yes: 168, buffer: 17, total: 185 },
                ],
            },
            dietarySplit: [
                { name: 'Vegetarian', value: 520 },
                { name: 'Non-Vegetarian', value: 127 },
            ],
            specialRequests: {
                pending: 3,
                approved: 15,
                total: 18,
            },
        };
    }
    async getSecurityDashboard(securityId) {
        const gateFunnel = await this.getGateFunnel();
        return {
            gateActivity: {
                today: { entriesIn: 142, entriesOut: 138, activeOut: 4 },
                lastHour: { in: 8, out: 5 },
            },
            activePasses: {
                total: 12,
                expiringSoon: 3,
                overdue: 1,
            },
            alerts: {
                total: 2,
                high: 0,
                medium: 1,
                low: 1,
            },
        };
    }
    async getGlobalStats() {
        const hostels = await this.getHostelLive();
        return {
            totalStudents: hostels.reduce((acc, h) => acc + h.totalStrength, 0),
            totalHostels: hostels.length,
            totalRooms: 227,
            averageAttendance: 88,
            averageOccupancy: 96,
            activeGatePasses: 18,
            pendingComplaints: 25,
            lastUpdated: new Date().toISOString(),
        };
    }
};
exports.DashboardsService = DashboardsService;
exports.DashboardsService = DashboardsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectDataSource)()),
    __metadata("design:paramtypes", [typeorm_2.DataSource])
], DashboardsService);
//# sourceMappingURL=dashboards.service.js.map