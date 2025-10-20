"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MaterializedViews1700000000001 = void 0;
class MaterializedViews1700000000001 {
    constructor() {
        this.name = 'MaterializedViews1700000000001';
    }
    async up(queryRunner) {
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_hostel_live AS
      SELECT 
        h.id as hostel_id,
        h.name as hostel_name,
        COUNT(DISTINCT s.id) as total_strength,
        COUNT(DISTINCT CASE WHEN gp.status = 'APPROVED' AND gp.start_time <= NOW() AND gp.end_time >= NOW() THEN s.id END) as outpass_now,
        COUNT(DISTINCT CASE WHEN gp.status = 'APPROVED' AND gp.start_time <= NOW() AND gp.end_time >= NOW() THEN s.id END) as present_derived,
        COUNT(DISTINCT CASE WHEN ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as scan_present,
        COUNT(DISTINCT CASE WHEN ac.method = 'MANUAL' AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as manual_present,
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'KIOSK_SCANNER'
        ) AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as kiosk_scans,
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'WARDEN_SCANNER'
        ) AND ac.session_id IN (
          SELECT id FROM attendance_sessions 
          WHERE date = CURRENT_DATE AND status = 'ACTIVE'
        ) THEN ac.student_id END) as warden_scans,
        NOW() as updated_at
      FROM hostels h
      LEFT JOIN students s ON s.hostel_id = h.id AND s.is_active = true
      LEFT JOIN gate_passes gp ON gp.student_id = s.id
      LEFT JOIN attendance_checks ac ON ac.student_id = s.id
      WHERE h.is_active = true
      GROUP BY h.id, h.name
    `);
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_attendance_session AS
      SELECT 
        as.id as session_id,
        as.hostel_id,
        as.date,
        as.slot,
        as.mode,
        COUNT(DISTINCT ar.student_id) as total_roster,
        COUNT(DISTINCT ac.student_id) as scanned_count,
        COUNT(DISTINCT CASE WHEN ac.method = 'MANUAL' THEN ac.student_id END) as manual_count,
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'KIOSK_SCANNER'
        ) THEN ac.student_id END) as kiosk_count,
        COUNT(DISTINCT CASE WHEN ac.device_id IN (
          SELECT id FROM devices WHERE type = 'WARDEN_SCANNER'
        ) THEN ac.student_id END) as warden_count,
        ROUND(
          (COUNT(DISTINCT ac.student_id)::float / NULLIF(COUNT(DISTINCT ar.student_id), 0)) * 100, 
          2
        ) as attendance_percentage,
        as.created_at,
        as.updated_at
      FROM attendance_sessions as
      LEFT JOIN attendance_roster ar ON ar.session_id = as.id
      LEFT JOIN attendance_checks ac ON ac.session_id = as.id
      GROUP BY as.id, as.hostel_id, as.date, as.slot, as.mode, as.created_at, as.updated_at
    `);
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_gate_funnel_day AS
      SELECT 
        DATE(gp.created_at) as date,
        h.id as hostel_id,
        h.name as hostel_name,
        COUNT(*) as total_requests,
        COUNT(CASE WHEN gp.status = 'APPROVED' THEN 1 END) as approved_count,
        COUNT(CASE WHEN gp.status = 'REJECTED' THEN 1 END) as rejected_count,
        COUNT(CASE WHEN gp.status = 'CANCELLED' THEN 1 END) as cancelled_count,
        COUNT(CASE WHEN gp.status = 'EXPIRED' THEN 1 END) as expired_count,
        ROUND(
          (COUNT(CASE WHEN gp.status = 'APPROVED' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100, 
          2
        ) as approval_rate,
        AVG(CASE WHEN gp.decision_at IS NOT NULL THEN 
          EXTRACT(EPOCH FROM (gp.decision_at - gp.created_at))/60 
        END) as avg_decision_time_minutes,
        COUNT(CASE WHEN ge.event_type = 'OUT' THEN 1 END) as out_scans,
        COUNT(CASE WHEN ge.event_type = 'IN' THEN 1 END) as in_scans
      FROM gate_passes gp
      JOIN hostels h ON h.id = gp.hostel_id
      LEFT JOIN gate_events ge ON ge.pass_id = gp.id
      WHERE gp.created_at >= CURRENT_DATE - INTERVAL '30 days'
      GROUP BY DATE(gp.created_at), h.id, h.name
    `);
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_meal_forecast_day AS
      SELECT 
        mi.date,
        mi.meal,
        h.id as hostel_id,
        h.name as hostel_name,
        COUNT(CASE WHEN mi.value = 'YES' THEN 1 END) as yes_count,
        COUNT(CASE WHEN mi.value = 'NO' THEN 1 END) as no_count,
        COUNT(*) as total_intents,
        ROUND(
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100, 
          2
        ) as yes_percentage,
        COALESCE(mo.delta, 0) as override_delta,
        ROUND(
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100 + 
          COALESCE(mo.delta, 0), 
          2
        ) as forecast_count
      FROM meal_intents mi
      JOIN students s ON s.id = mi.student_id
      JOIN hostels h ON h.id = s.hostel_id
      LEFT JOIN meal_overrides mo ON mo.date = mi.date AND mo.meal = mi.meal AND mo.hostel_id = h.id
      WHERE mi.date >= CURRENT_DATE
      GROUP BY mi.date, mi.meal, h.id, h.name, mo.delta
    `);
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_room_occupancy_day AS
      SELECT 
        CURRENT_DATE as date,
        h.id as hostel_id,
        h.name as hostel_name,
        b.id as block_id,
        b.name as block_name,
        COUNT(DISTINCT r.id) as total_rooms,
        COUNT(DISTINCT CASE WHEN s.id IS NOT NULL THEN r.id END) as occupied_rooms,
        COUNT(DISTINCT s.id) as total_students,
        ROUND(
          (COUNT(DISTINCT CASE WHEN s.id IS NOT NULL THEN r.id END)::float / NULLIF(COUNT(DISTINCT r.id), 0)) * 100, 
          2
        ) as occupancy_percentage,
        COUNT(DISTINCT CASE WHEN s.id IS NOT NULL AND s.is_active = true THEN r.id END) as active_occupancy
      FROM hostels h
      JOIN blocks b ON b.hostel_id = h.id
      JOIN rooms r ON r.block_id = b.id
      LEFT JOIN students s ON s.room_id = r.id
      WHERE h.is_active = true AND b.is_active = true AND r.is_active = true
      GROUP BY h.id, h.name, b.id, b.name
    `);
        await queryRunner.query(`
      CREATE MATERIALIZED VIEW mv_monthly_analytics AS
      SELECT 
        DATE_TRUNC('month', CURRENT_DATE) as month,
        h.id as hostel_id,
        h.name as hostel_name,
        -- Attendance metrics
        COUNT(DISTINCT CASE WHEN as.date >= DATE_TRUNC('month', CURRENT_DATE) THEN as.id END) as attendance_sessions,
        ROUND(AVG(CASE WHEN as.date >= DATE_TRUNC('month', CURRENT_DATE) THEN 
          (SELECT COUNT(DISTINCT ac.student_id)::float / NULLIF(COUNT(DISTINCT ar.student_id), 0) * 100
           FROM attendance_checks ac
           LEFT JOIN attendance_roster ar ON ar.session_id = as.id
           WHERE ac.session_id = as.id)
        END), 2) as avg_attendance_percentage,
        
        -- Gate pass metrics
        COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', CURRENT_DATE) THEN 1 END) as gate_pass_requests,
        COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', CURRENT_DATE) AND gp.status = 'APPROVED' THEN 1 END) as gate_pass_approved,
        ROUND(
          (COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', CURRENT_DATE) AND gp.status = 'APPROVED' THEN 1 END)::float / 
           NULLIF(COUNT(CASE WHEN gp.created_at >= DATE_TRUNC('month', CURRENT_DATE) THEN 1 END), 0)) * 100, 
          2
        ) as gate_pass_approval_rate,
        
        -- Meal metrics
        COUNT(DISTINCT CASE WHEN mi.date >= DATE_TRUNC('month', CURRENT_DATE) THEN mi.date END) as meal_days,
        ROUND(AVG(CASE WHEN mi.date >= DATE_TRUNC('month', CURRENT_DATE) THEN 
          (COUNT(CASE WHEN mi.value = 'YES' THEN 1 END)::float / NULLIF(COUNT(*), 0)) * 100
        END), 2) as avg_meal_yes_percentage,
        
        -- Room metrics
        COUNT(DISTINCT CASE WHEN s.is_active = true THEN s.room_id END) as occupied_rooms,
        COUNT(DISTINCT r.id) as total_rooms,
        ROUND(
          (COUNT(DISTINCT CASE WHEN s.is_active = true THEN s.room_id END)::float / 
           NULLIF(COUNT(DISTINCT r.id), 0)) * 100, 
          2
        ) as room_occupancy_percentage,
        
        NOW() as updated_at
      FROM hostels h
      LEFT JOIN students s ON s.hostel_id = h.id
      LEFT JOIN rooms r ON r.block_id IN (SELECT id FROM blocks WHERE hostel_id = h.id)
      LEFT JOIN gate_passes gp ON gp.hostel_id = h.id
      LEFT JOIN meal_intents mi ON mi.student_id = s.id
      LEFT JOIN attendance_sessions as ON as.hostel_id = h.id
      WHERE h.is_active = true
      GROUP BY h.id, h.name
    `);
        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_mv_hostel_live_hostel_id" ON "mv_hostel_live" ("hostel_id")`);
        await queryRunner.query(`CREATE INDEX "IDX_mv_attendance_session_date" ON "mv_attendance_session" ("date")`);
        await queryRunner.query(`CREATE INDEX "IDX_mv_gate_funnel_day_date" ON "mv_gate_funnel_day" ("date")`);
        await queryRunner.query(`CREATE INDEX "IDX_mv_meal_forecast_day_date" ON "mv_meal_forecast_day" ("date")`);
        await queryRunner.query(`CREATE INDEX "IDX_mv_room_occupancy_day_date" ON "mv_room_occupancy_day" ("date")`);
        await queryRunner.query(`CREATE INDEX "IDX_mv_monthly_analytics_month" ON "mv_monthly_analytics" ("month")`);
    }
    async down(queryRunner) {
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_monthly_analytics`);
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_room_occupancy_day`);
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_meal_forecast_day`);
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_gate_funnel_day`);
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_attendance_session`);
        await queryRunner.query(`DROP MATERIALIZED VIEW IF EXISTS mv_hostel_live`);
    }
}
exports.MaterializedViews1700000000001 = MaterializedViews1700000000001;
//# sourceMappingURL=1700000000001-MaterializedViews.js.map