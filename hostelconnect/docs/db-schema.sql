# HostelConnect Database Schema

## Overview

This document describes the complete database schema for HostelConnect, including all tables, relationships, indexes, and materialized views.

## Database Configuration

- **Database**: PostgreSQL 15+
- **Extensions**: uuid-ossp
- **Timezone**: IST (Asia/Kolkata)
- **Character Set**: UTF-8

## Core Tables

### Users Table
```sql
CREATE TABLE "users" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "email" character varying NOT NULL,
  "password_hash" character varying NOT NULL,
  "role" character varying NOT NULL CHECK (role IN ('SUPER_ADMIN', 'WARDEN_HEAD', 'WARDEN', 'STUDENT', 'CHEF')),
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_users_id" PRIMARY KEY ("id"),
  CONSTRAINT "UQ_users_email" UNIQUE ("email")
);
```

### Students Table
```sql
CREATE TABLE "students" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "user_id" uuid NOT NULL,
  "student_id" character varying NOT NULL,
  "name" character varying NOT NULL,
  "phone" character varying,
  "hostel_id" uuid NOT NULL,
  "room_id" uuid,
  "bed_number" integer,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_students_id" PRIMARY KEY ("id"),
  CONSTRAINT "UQ_students_student_id" UNIQUE ("student_id"),
  CONSTRAINT "FK_students_user_id" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
);
```

### Hostels Table
```sql
CREATE TABLE "hostels" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "name" character varying NOT NULL,
  "address" text,
  "capacity" integer NOT NULL,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_hostels_id" PRIMARY KEY ("id")
);
```

### Blocks Table
```sql
CREATE TABLE "blocks" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "hostel_id" uuid NOT NULL,
  "name" character varying NOT NULL,
  "floors" integer NOT NULL,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_blocks_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_blocks_hostel_id" FOREIGN KEY ("hostel_id") REFERENCES "hostels"("id") ON DELETE CASCADE
);
```

### Rooms Table
```sql
CREATE TABLE "rooms" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "block_id" uuid NOT NULL,
  "room_number" character varying NOT NULL,
  "floor" integer NOT NULL,
  "capacity" integer NOT NULL DEFAULT 1,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_rooms_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_rooms_block_id" FOREIGN KEY ("block_id") REFERENCES "blocks"("id") ON DELETE CASCADE
);
```

### Devices Table
```sql
CREATE TABLE "devices" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "device_id" character varying NOT NULL,
  "name" character varying NOT NULL,
  "type" character varying NOT NULL CHECK (type IN ('KIOSK_SCANNER', 'WARDEN_SCANNER', 'GATE')),
  "hostel_id" uuid NOT NULL,
  "location" character varying,
  "is_active" boolean NOT NULL DEFAULT true,
  "last_seen" timestamp,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_devices_id" PRIMARY KEY ("id"),
  CONSTRAINT "UQ_devices_device_id" UNIQUE ("device_id"),
  CONSTRAINT "FK_devices_hostel_id" FOREIGN KEY ("hostel_id") REFERENCES "hostels"("id") ON DELETE CASCADE
);
```

## Gate Pass System

### Gate Passes Table
```sql
CREATE TABLE "gate_passes" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "student_id" uuid NOT NULL,
  "hostel_id" uuid NOT NULL,
  "type" character varying NOT NULL CHECK (type IN ('OUTING', 'EMERGENCY')),
  "start_time" timestamp NOT NULL,
  "end_time" timestamp NOT NULL,
  "status" character varying NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED', 'EXPIRED')),
  "reason" text NOT NULL,
  "note" text,
  "decision_by" uuid,
  "decision_at" timestamp,
  "qr_token_hash" character varying,
  "qr_token_expires_at" timestamp,
  "is_emergency" boolean NOT NULL DEFAULT false,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_gate_passes_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_gate_passes_student_id" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_gate_passes_hostel_id" FOREIGN KEY ("hostel_id") REFERENCES "hostels"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_gate_passes_decision_by" FOREIGN KEY ("decision_by") REFERENCES "users"("id")
);
```

### Gate Events Table
```sql
CREATE TABLE "gate_events" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "pass_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "event_type" character varying NOT NULL CHECK (event_type IN ('OUT', 'IN')),
  "method" character varying NOT NULL CHECK (method IN ('QR_SCAN', 'MANUAL')),
  "device_id" uuid,
  "guard_user_id" uuid,
  "timestamp" timestamp NOT NULL DEFAULT now(),
  "latitude" double precision,
  "longitude" double precision,
  "created_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_gate_events_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_gate_events_pass_id" FOREIGN KEY ("pass_id") REFERENCES "gate_passes"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_gate_events_student_id" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_gate_events_device_id" FOREIGN KEY ("device_id") REFERENCES "devices"("id"),
  CONSTRAINT "FK_gate_events_guard_user_id" FOREIGN KEY ("guard_user_id") REFERENCES "users"("id")
);
```

## Attendance System

### Attendance Sessions Table
```sql
CREATE TABLE "attendance_sessions" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "hostel_id" uuid NOT NULL,
  "wing_ids" uuid[] NOT NULL,
  "date" date NOT NULL,
  "slot" character varying NOT NULL CHECK (slot IN ('MORNING', 'EVENING', 'NIGHT')),
  "start_time" timestamp NOT NULL,
  "end_time" timestamp NOT NULL,
  "mode" character varying NOT NULL CHECK (mode IN ('KIOSK_ONLY', 'WARDEN_ROUND', 'HYBRID')),
  "nonce" character varying NOT NULL,
  "status" character varying NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'CLOSED', 'CANCELLED')),
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_attendance_sessions_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_attendance_sessions_hostel_id" FOREIGN KEY ("hostel_id") REFERENCES "hostels"("id") ON DELETE CASCADE
);
```

### Attendance Roster Table
```sql
CREATE TABLE "attendance_roster" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "session_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "room_id" uuid NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_attendance_roster_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_attendance_roster_session_id" FOREIGN KEY ("session_id") REFERENCES "attendance_sessions"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_attendance_roster_student_id" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_attendance_roster_room_id" FOREIGN KEY ("room_id") REFERENCES "rooms"("id") ON DELETE CASCADE
);
```

### Attendance Checks Table
```sql
CREATE TABLE "attendance_checks" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "session_id" uuid NOT NULL,
  "student_id" uuid NOT NULL,
  "method" character varying NOT NULL CHECK (method IN ('STUDENT_QR', 'MANUAL', 'GATE')),
  "timestamp" timestamp NOT NULL DEFAULT now(),
  "warden_id" uuid,
  "device_id" uuid,
  "reason" text,
  "photo_url" character varying,
  "created_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_attendance_checks_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_attendance_checks_session_id" FOREIGN KEY ("session_id") REFERENCES "attendance_sessions"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_attendance_checks_student_id" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_attendance_checks_warden_id" FOREIGN KEY ("warden_id") REFERENCES "users"("id"),
  CONSTRAINT "FK_attendance_checks_device_id" FOREIGN KEY ("device_id") REFERENCES "devices"("id")
);
```

## Meals System

### Meal Intents Table
```sql
CREATE TABLE "meal_intents" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "date" date NOT NULL,
  "meal" character varying NOT NULL CHECK (meal IN ('BREAKFAST', 'LUNCH', 'SNACKS', 'DINNER')),
  "student_id" uuid NOT NULL,
  "value" character varying NOT NULL CHECK (value IN ('YES', 'NO')),
  "decided_at" timestamp NOT NULL DEFAULT now(),
  "diet" character varying,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_meal_intents_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_meal_intents_student_id" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE CASCADE,
  CONSTRAINT "UQ_meal_intents_student_date_meal" UNIQUE ("student_id", "date", "meal")
);
```

### Meal Overrides Table
```sql
CREATE TABLE "meal_overrides" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "date" date NOT NULL,
  "meal" character varying NOT NULL CHECK (meal IN ('BREAKFAST', 'LUNCH', 'SNACKS', 'DINNER')),
  "hostel_id" uuid NOT NULL,
  "delta" integer NOT NULL,
  "reason" text NOT NULL,
  "created_by" uuid NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_meal_overrides_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_meal_overrides_hostel_id" FOREIGN KEY ("hostel_id") REFERENCES "hostels"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_meal_overrides_created_by" FOREIGN KEY ("created_by") REFERENCES "users"("id")
);
```

## Ads System

### Ads Table
```sql
CREATE TABLE "ads" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "type" character varying NOT NULL CHECK (type IN ('INTERSTITIAL', 'BANNER', 'MINICARD')),
  "asset_url" character varying NOT NULL,
  "duration_s" integer NOT NULL,
  "active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp NOT NULL DEFAULT now(),
  "updated_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_ads_id" PRIMARY KEY ("id")
);
```

### Ad Events Table
```sql
CREATE TABLE "ad_events" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "ad_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "module" character varying NOT NULL,
  "timestamp" timestamp NOT NULL DEFAULT now(),
  "result" character varying NOT NULL CHECK (result IN ('STARTED', 'COMPLETED', 'SKIPPED')),
  "created_at" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_ad_events_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_ad_events_ad_id" FOREIGN KEY ("ad_id") REFERENCES "ads"("id") ON DELETE CASCADE,
  CONSTRAINT "FK_ad_events_user_id" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
);
```

## Audit System

### Audit Events Table
```sql
CREATE TABLE "audit_events" (
  "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "user_id" uuid,
  "action" character varying NOT NULL,
  "entity_type" character varying NOT NULL,
  "entity_id" uuid,
  "old_values" jsonb,
  "new_values" jsonb,
  "ip_address" character varying,
  "user_agent" text,
  "timestamp" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT "PK_audit_events_id" PRIMARY KEY ("id"),
  CONSTRAINT "FK_audit_events_user_id" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL
);
```

## Indexes

### Performance Indexes
```sql
-- Gate Pass Performance
CREATE INDEX "IDX_gate_passes_student_status" ON "gate_passes" ("student_id", "status");
CREATE INDEX "IDX_gate_passes_hostel_created" ON "gate_passes" ("hostel_id", "created_at" DESC);

-- Gate Events Performance
CREATE INDEX "IDX_gate_events_student_timestamp" ON "gate_events" ("student_id", "timestamp" DESC);
CREATE INDEX "IDX_gate_events_pass_id" ON "gate_events" ("pass_id");

-- Attendance Performance
CREATE INDEX "IDX_attendance_checks_session_student" ON "attendance_checks" ("session_id", "student_id");
CREATE INDEX "IDX_attendance_checks_timestamp" ON "attendance_checks" ("timestamp" DESC);
CREATE INDEX "IDX_attendance_sessions_date_hostel" ON "attendance_sessions" ("date", "hostel_id");

-- Meals Performance
CREATE INDEX "IDX_meal_intents_date_meal" ON "meal_intents" ("date", "meal");
CREATE INDEX "IDX_meal_intents_student_date" ON "meal_intents" ("student_id", "date");

-- Audit Performance
CREATE INDEX "IDX_audit_events_timestamp" ON "audit_events" ("timestamp" DESC);
CREATE INDEX "IDX_audit_events_user_id" ON "audit_events" ("user_id");

-- General Performance
CREATE INDEX "IDX_students_hostel_active" ON "students" ("hostel_id", "is_active");
CREATE INDEX "IDX_rooms_block_active" ON "rooms" ("block_id", "is_active");
```

## Materialized Views

### Live Hostel Dashboard
```sql
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
GROUP BY h.id, h.name;
```

### Attendance Session Summary
```sql
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
GROUP BY as.id, as.hostel_id, as.date, as.slot, as.mode, as.created_at, as.updated_at;
```

### Gate Funnel Daily
```sql
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
GROUP BY DATE(gp.created_at), h.id, h.name;
```

### Meal Forecast Daily
```sql
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
GROUP BY mi.date, mi.meal, h.id, h.name, mo.delta;
```

### Room Occupancy Daily
```sql
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
GROUP BY h.id, h.name, b.id, b.name;
```

### Monthly Analytics
```sql
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
GROUP BY h.id, h.name;
```

## Refresh Strategy

### Materialized View Refresh Schedule
- **Live Views**: Every 15-30 seconds
- **Daily Views**: Every 5 minutes
- **Monthly Views**: Every hour

### Refresh Commands
```sql
-- Refresh all materialized views
REFRESH MATERIALIZED VIEW mv_hostel_live;
REFRESH MATERIALIZED VIEW mv_attendance_session;
REFRESH MATERIALIZED VIEW mv_gate_funnel_day;
REFRESH MATERIALIZED VIEW mv_meal_forecast_day;
REFRESH MATERIALIZED VIEW mv_room_occupancy_day;
REFRESH MATERIALIZED VIEW mv_monthly_analytics;
```

## Data Partitioning (Future)

### Partitioned Tables
For high-volume tables, consider partitioning by date:

```sql
-- Example: Partition gate_events by month
CREATE TABLE gate_events_y2024m01 PARTITION OF gate_events
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE gate_events_y2024m02 PARTITION OF gate_events
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
```

## Backup Strategy

### Automated Backups
- **Full Backup**: Daily at 2 AM IST
- **Incremental Backup**: Every 6 hours
- **Point-in-time Recovery**: 7-day retention
- **Cross-region Replication**: For disaster recovery

### Backup Commands
```bash
# Full backup
pg_dump -h localhost -U postgres -d hostelconnect > backup_$(date +%Y%m%d_%H%M%S).sql

# Incremental backup (WAL files)
pg_basebackup -h localhost -U postgres -D /backup/path -Ft -z -P
```

## Performance Monitoring

### Key Metrics
- Query execution time
- Index usage statistics
- Materialized view refresh time
- Connection pool utilization
- Lock contention

### Monitoring Queries
```sql
-- Slow queries
SELECT query, mean_time, calls, total_time 
FROM pg_stat_statements 
ORDER BY mean_time DESC 
LIMIT 10;

-- Index usage
SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;

-- Materialized view refresh time
SELECT schemaname, matviewname, last_refresh_time
FROM pg_matviews;
```
