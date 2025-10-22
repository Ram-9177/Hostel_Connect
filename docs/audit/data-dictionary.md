# 📊 HostelConnect - Data Dictionary for Dashboard Tiles

## 🎯 **OVERVIEW**

This document provides a comprehensive data dictionary for all dashboard tiles, queries, and materialized views used in the HostelConnect Reports & Analytics system.

---

## 📋 **DASHBOARD TILES DATA DICTIONARY**

### 🔴 **Live Dashboard Tiles**

#### **1. Attendance Tile**
```sql
-- Query: attendance_daily_summary
SELECT 
    COUNT(DISTINCT s.id) as total_students,
    COUNT(CASE WHEN ae.status = 'present' THEN 1 END) as present_count,
    COUNT(CASE WHEN ae.status = 'absent' THEN 1 END) as absent_count,
    COUNT(CASE WHEN ae.status = 'late' THEN 1 END) as late_count,
    COUNT(CASE WHEN ae.status = 'excused' THEN 1 END) as excused_count,
    ROUND(
        (COUNT(CASE WHEN ae.status = 'present' THEN 1 END) * 100.0) / 
        COUNT(DISTINCT s.id), 2
    ) as attendance_percentage,
    COUNT(CASE WHEN ae.is_manual = true THEN 1 END) as manual_entries,
    ROUND(
        (COUNT(CASE WHEN ae.is_manual = true THEN 1 END) * 100.0) / 
        COUNT(DISTINCT s.id), 2
    ) as manual_percentage
FROM students s
LEFT JOIN attendance_entries ae ON s.id = ae.student_id 
    AND DATE(ae.created_at) = CURRENT_DATE
WHERE s.hostel_id = $1 AND s.is_active = true;
```

**Fields:**
- `total_students`: Total number of active students in the hostel
- `present_count`: Number of students marked present today
- `absent_count`: Number of students marked absent today
- `late_count`: Number of students marked late today
- `excused_count`: Number of students with excused absence
- `attendance_percentage`: Overall attendance percentage for today
- `manual_entries`: Number of manual attendance entries
- `manual_percentage`: Percentage of manual entries

**Freshness Threshold:** 30 seconds
**Materialized View:** `mv_attendance_daily_summary`
**Refresh Frequency:** Every 30 seconds

#### **2. Gate Pass Tile**
```sql
-- Query: gate_pass_daily_summary
SELECT 
    COUNT(CASE WHEN gp.status = 'approved' AND gp.out_time IS NOT NULL THEN 1 END) as total_out_passes,
    COUNT(CASE WHEN gp.status = 'approved' AND gp.in_time IS NOT NULL THEN 1 END) as total_in_passes,
    COUNT(CASE WHEN gp.status = 'pending' THEN 1 END) as pending_passes,
    COUNT(CASE WHEN gp.status = 'approved' THEN 1 END) as approved_passes,
    COUNT(CASE WHEN gp.status = 'rejected' THEN 1 END) as rejected_passes,
    AVG(
        CASE 
            WHEN gp.out_time IS NOT NULL AND gp.in_time IS NOT NULL 
            THEN EXTRACT(EPOCH FROM (gp.in_time - gp.out_time))
            ELSE NULL 
        END
    ) as average_tat_seconds,
    AVG(
        CASE 
            WHEN gp.out_time IS NOT NULL 
            THEN EXTRACT(EPOCH FROM (gp.out_time - gp.created_at))
            ELSE NULL 
        END
    ) as average_out_time_seconds
FROM gate_passes gp
WHERE gp.hostel_id = $1 
    AND DATE(gp.created_at) = CURRENT_DATE;
```

**Fields:**
- `total_out_passes`: Number of approved out passes today
- `total_in_passes`: Number of completed in passes today
- `pending_passes`: Number of pending gate pass requests
- `approved_passes`: Number of approved gate passes
- `rejected_passes`: Number of rejected gate passes
- `average_tat_seconds`: Average turnaround time in seconds
- `average_out_time_seconds`: Average time to process out pass

**Freshness Threshold:** 30 seconds
**Materialized View:** `mv_gate_pass_daily_summary`
**Refresh Frequency:** Every 30 seconds

#### **3. Meals Tile**
```sql
-- Query: meals_daily_summary
SELECT 
    SUM(mi.forecasted_count) as total_forecasted,
    SUM(mi.actual_count) as total_actual,
    ROUND(
        ((SUM(mi.actual_count) - SUM(mi.forecasted_count)) * 100.0) / 
        NULLIF(SUM(mi.forecasted_count), 0), 2
    ) as variance_percentage,
    COUNT(DISTINCT mi.meal_type) as meal_types_count
FROM meal_intents mi
WHERE mi.hostel_id = $1 
    AND DATE(mi.date) = CURRENT_DATE;
```

**Fields:**
- `total_forecasted`: Total forecasted meal count for today
- `total_actual`: Total actual meal count for today
- `variance_percentage`: Percentage variance between actual and forecasted
- `meal_types_count`: Number of different meal types

**Freshness Threshold:** 30 seconds
**Materialized View:** `mv_meals_daily_summary`
**Refresh Frequency:** Every 30 seconds

#### **4. Occupancy Tile**
```sql
-- Query: occupancy_daily_summary
SELECT 
    COUNT(DISTINCT r.id) as total_rooms,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) as occupied_rooms,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NULL THEN r.id END) as vacant_rooms,
    COUNT(DISTINCT b.id) as total_beds,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN b.id END) as occupied_beds,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NULL THEN b.id END) as vacant_beds,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) * 100.0) / 
        COUNT(DISTINCT r.id), 2
    ) as room_occupancy_percentage,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN b.id END) * 100.0) / 
        COUNT(DISTINCT b.id), 2
    ) as bed_occupancy_percentage
FROM rooms r
JOIN blocks bl ON r.block_id = bl.id
JOIN beds b ON b.room_id = r.id
LEFT JOIN room_allocations ra ON ra.bed_id = b.id 
    AND ra.is_active = true
WHERE bl.hostel_id = $1;
```

**Fields:**
- `total_rooms`: Total number of rooms in the hostel
- `occupied_rooms`: Number of rooms with at least one occupied bed
- `vacant_rooms`: Number of completely vacant rooms
- `total_beds`: Total number of beds in the hostel
- `occupied_beds`: Number of occupied beds
- `vacant_beds`: Number of vacant beds
- `room_occupancy_percentage`: Percentage of rooms occupied
- `bed_occupancy_percentage`: Percentage of beds occupied

**Freshness Threshold:** 30 seconds
**Materialized View:** `mv_occupancy_daily_summary`
**Refresh Frequency:** Every 30 seconds

#### **5. Integrity Tile**
```sql
-- Query: integrity_daily_summary
SELECT 
    COUNT(*) as total_checks,
    COUNT(CASE WHEN ic.status = 'passed' THEN 1 END) as passed_checks,
    COUNT(CASE WHEN ic.status = 'failed' THEN 1 END) as failed_checks,
    ROUND(
        (COUNT(CASE WHEN ic.status = 'passed' THEN 1 END) * 100.0) / 
        COUNT(*), 2
    ) as integrity_percentage
FROM integrity_checks ic
WHERE ic.hostel_id = $1 
    AND DATE(ic.checked_at) = CURRENT_DATE;
```

**Fields:**
- `total_checks`: Total number of integrity checks performed today
- `passed_checks`: Number of checks that passed
- `failed_checks`: Number of checks that failed
- `integrity_percentage`: Overall integrity percentage

**Freshness Threshold:** 30 seconds
**Materialized View:** `mv_integrity_daily_summary`
**Refresh Frequency:** Every 30 seconds

---

## 📊 **DRILL-DOWN QUERIES DATA DICTIONARY**

### 🔍 **Attendance Drill-Downs**

#### **1. Attendance Sessions List**
```sql
-- Query: attendance_sessions_drill_down
SELECT 
    as.id as session_id,
    as.name,
    as.mode,
    as.start_time,
    as.end_time,
    COUNT(DISTINCT ae.student_id) as total_students,
    COUNT(CASE WHEN ae.status = 'present' THEN 1 END) as present_count,
    COUNT(CASE WHEN ae.status = 'absent' THEN 1 END) as absent_count,
    ROUND(
        (COUNT(CASE WHEN ae.status = 'present' THEN 1 END) * 100.0) / 
        COUNT(DISTINCT ae.student_id), 2
    ) as attendance_percentage,
    EXTRACT(EPOCH FROM (as.end_time - as.start_time)) as duration_seconds
FROM attendance_sessions as
LEFT JOIN attendance_entries ae ON ae.session_id = as.id
WHERE as.hostel_id = $1 
    AND DATE(as.start_time) = $2
GROUP BY as.id, as.name, as.mode, as.start_time, as.end_time
ORDER BY as.start_time DESC;
```

#### **2. Manual Entries List**
```sql
-- Query: manual_attendance_drill_down
SELECT 
    ae.id,
    s.name as student_name,
    s.roll_number,
    ae.status,
    ae.reason,
    ae.created_at,
    u.name as entered_by
FROM attendance_entries ae
JOIN students s ON ae.student_id = s.id
JOIN users u ON ae.created_by = u.id
WHERE ae.is_manual = true 
    AND s.hostel_id = $1 
    AND DATE(ae.created_at) = $2
ORDER BY ae.created_at DESC;
```

### 🚪 **Gate Pass Drill-Downs**

#### **1. Recent Gate Passes**
```sql
-- Query: recent_gate_passes_drill_down
SELECT 
    gp.id as pass_id,
    gp.student_id,
    s.name as student_name,
    gp.out_time,
    gp.in_time,
    CASE 
        WHEN gp.out_time IS NOT NULL AND gp.in_time IS NOT NULL 
        THEN EXTRACT(EPOCH FROM (gp.in_time - gp.out_time))
        ELSE NULL 
    END as duration_seconds,
    gp.status,
    gp.reason
FROM gate_passes gp
JOIN students s ON gp.student_id = s.id
WHERE gp.hostel_id = $1 
    AND DATE(gp.created_at) = $2
ORDER BY gp.created_at DESC
LIMIT 50;
```

#### **2. Gate Pass TAT Analysis**
```sql
-- Query: gate_pass_tat_drill_down
SELECT 
    gp.id,
    s.name as student_name,
    gp.created_at as request_time,
    gp.out_time,
    gp.in_time,
    EXTRACT(EPOCH FROM (gp.out_time - gp.created_at)) as approval_time_seconds,
    CASE 
        WHEN gp.out_time IS NOT NULL AND gp.in_time IS NOT NULL 
        THEN EXTRACT(EPOCH FROM (gp.in_time - gp.out_time))
        ELSE NULL 
    END as duration_seconds,
    gp.status
FROM gate_passes gp
JOIN students s ON gp.student_id = s.id
WHERE gp.hostel_id = $1 
    AND DATE(gp.created_at) = $2
    AND gp.status = 'approved'
ORDER BY gp.created_at DESC;
```

### 🍽️ **Meals Drill-Downs**

#### **1. Meal Variance Details**
```sql
-- Query: meal_variance_drill_down
SELECT 
    mi.date,
    mi.meal_type,
    mi.forecasted_count,
    mi.actual_count,
    (mi.actual_count - mi.forecasted_count) as variance,
    ROUND(
        ((mi.actual_count - mi.forecasted_count) * 100.0) / 
        NULLIF(mi.forecasted_count, 0), 2
    ) as variance_percentage,
    mi.variance_reason
FROM meal_intents mi
WHERE mi.hostel_id = $1 
    AND mi.date BETWEEN $2 AND $3
ORDER BY mi.date DESC, mi.meal_type;
```

#### **2. Meal Type Breakdown**
```sql
-- Query: meal_type_breakdown_drill_down
SELECT 
    mi.meal_type,
    SUM(mi.forecasted_count) as total_forecasted,
    SUM(mi.actual_count) as total_actual,
    SUM(mi.actual_count - mi.forecasted_count) as total_variance,
    ROUND(
        (SUM(mi.actual_count - mi.forecasted_count) * 100.0) / 
        NULLIF(SUM(mi.forecasted_count), 0), 2
    ) as variance_percentage,
    COUNT(*) as days_count
FROM meal_intents mi
WHERE mi.hostel_id = $1 
    AND mi.date BETWEEN $2 AND $3
GROUP BY mi.meal_type
ORDER BY mi.meal_type;
```

### 🏠 **Occupancy Drill-Downs**

#### **1. Room Details**
```sql
-- Query: room_occupancy_drill_down
SELECT 
    r.id as room_id,
    r.room_number,
    bl.name as block_name,
    f.name as floor_name,
    COUNT(b.id) as total_beds,
    COUNT(CASE WHEN ra.student_id IS NOT NULL THEN b.id END) as occupied_beds,
    ROUND(
        (COUNT(CASE WHEN ra.student_id IS NOT NULL THEN b.id END) * 100.0) / 
        COUNT(b.id), 2
    ) as occupancy_percentage,
    STRING_AGG(s.name, ', ') as student_names
FROM rooms r
JOIN blocks bl ON r.block_id = bl.id
JOIN floors f ON r.floor_id = f.id
JOIN beds b ON b.room_id = r.id
LEFT JOIN room_allocations ra ON ra.bed_id = b.id AND ra.is_active = true
LEFT JOIN students s ON ra.student_id = s.id
WHERE bl.hostel_id = $1
GROUP BY r.id, r.room_number, bl.name, f.name
ORDER BY bl.name, f.name, r.room_number;
```

#### **2. Block Occupancy**
```sql
-- Query: block_occupancy_drill_down
SELECT 
    bl.id as block_id,
    bl.name as block_name,
    COUNT(DISTINCT r.id) as total_rooms,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) as occupied_rooms,
    COUNT(DISTINCT b.id) as total_beds,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN b.id END) as occupied_beds,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) * 100.0) / 
        COUNT(DISTINCT r.id), 2
    ) as room_occupancy_percentage,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN b.id END) * 100.0) / 
        COUNT(DISTINCT b.id), 2
    ) as bed_occupancy_percentage
FROM blocks bl
JOIN rooms r ON r.block_id = bl.id
JOIN beds b ON b.room_id = r.id
LEFT JOIN room_allocations ra ON ra.bed_id = b.id AND ra.is_active = true
WHERE bl.hostel_id = $1
GROUP BY bl.id, bl.name
ORDER BY bl.name;
```

### 🔒 **Integrity Drill-Downs**

#### **1. Integrity Checks Details**
```sql
-- Query: integrity_checks_drill_down
SELECT 
    ic.id as check_id,
    ic.name,
    ic.type,
    ic.status,
    ic.description,
    ic.checked_at,
    ic.error_message,
    ic.details
FROM integrity_checks ic
WHERE ic.hostel_id = $1 
    AND DATE(ic.checked_at) = $2
ORDER BY ic.checked_at DESC;
```

#### **2. Integrity Check Breakdown**
```sql
-- Query: integrity_check_breakdown_drill_down
SELECT 
    ic.type,
    COUNT(*) as total_checks,
    COUNT(CASE WHEN ic.status = 'passed' THEN 1 END) as passed_checks,
    COUNT(CASE WHEN ic.status = 'failed' THEN 1 END) as failed_checks,
    COUNT(CASE WHEN ic.status = 'warning' THEN 1 END) as warning_checks,
    ROUND(
        (COUNT(CASE WHEN ic.status = 'passed' THEN 1 END) * 100.0) / 
        COUNT(*), 2
    ) as pass_percentage
FROM integrity_checks ic
WHERE ic.hostel_id = $1 
    AND DATE(ic.checked_at) = $2
GROUP BY ic.type
ORDER BY ic.type;
```

---

## 📈 **TREND QUERIES DATA DICTIONARY**

### 📊 **Attendance Trends**

#### **Daily Attendance Trend**
```sql
-- Query: daily_attendance_trend
SELECT 
    DATE(ae.created_at) as date,
    COUNT(DISTINCT s.id) as total_students,
    COUNT(CASE WHEN ae.status = 'present' THEN 1 END) as present_count,
    ROUND(
        (COUNT(CASE WHEN ae.status = 'present' THEN 1 END) * 100.0) / 
        COUNT(DISTINCT s.id), 2
    ) as attendance_percentage
FROM students s
LEFT JOIN attendance_entries ae ON s.id = ae.student_id 
    AND DATE(ae.created_at) BETWEEN $2 AND $3
WHERE s.hostel_id = $1 AND s.is_active = true
GROUP BY DATE(ae.created_at)
ORDER BY DATE(ae.created_at);
```

#### **Weekly Attendance Average**
```sql
-- Query: weekly_attendance_average
SELECT 
    EXTRACT(WEEK FROM DATE(ae.created_at)) as week_number,
    ROUND(AVG(
        (COUNT(CASE WHEN ae.status = 'present' THEN 1 END) * 100.0) / 
        COUNT(DISTINCT s.id)
    ), 2) as average_attendance
FROM students s
LEFT JOIN attendance_entries ae ON s.id = ae.student_id 
    AND DATE(ae.created_at) BETWEEN $2 AND $3
WHERE s.hostel_id = $1 AND s.is_active = true
GROUP BY EXTRACT(WEEK FROM DATE(ae.created_at))
ORDER BY week_number;
```

### 🚪 **Gate Pass Trends**

#### **Daily Gate Pass Trend**
```sql
-- Query: daily_gate_pass_trend
SELECT 
    DATE(gp.created_at) as date,
    COUNT(*) as total_passes,
    COUNT(CASE WHEN gp.status = 'approved' THEN 1 END) as approved_passes,
    COUNT(CASE WHEN gp.status = 'rejected' THEN 1 END) as rejected_passes,
    AVG(
        CASE 
            WHEN gp.out_time IS NOT NULL AND gp.in_time IS NOT NULL 
            THEN EXTRACT(EPOCH FROM (gp.in_time - gp.out_time))
            ELSE NULL 
        END
    ) as average_tat_seconds
FROM gate_passes gp
WHERE gp.hostel_id = $1 
    AND DATE(gp.created_at) BETWEEN $2 AND $3
GROUP BY DATE(gp.created_at)
ORDER BY DATE(gp.created_at);
```

### 🍽️ **Meal Trends**

#### **Daily Meal Variance Trend**
```sql
-- Query: daily_meal_variance_trend
SELECT 
    mi.date,
    SUM(mi.forecasted_count) as total_forecasted,
    SUM(mi.actual_count) as total_actual,
    SUM(mi.actual_count - mi.forecasted_count) as total_variance,
    ROUND(
        (SUM(mi.actual_count - mi.forecasted_count) * 100.0) / 
        NULLIF(SUM(mi.forecasted_count), 0), 2
    ) as variance_percentage
FROM meal_intents mi
WHERE mi.hostel_id = $1 
    AND mi.date BETWEEN $2 AND $3
GROUP BY mi.date
ORDER BY mi.date;
```

### 🏠 **Occupancy Trends**

#### **Daily Occupancy Trend**
```sql
-- Query: daily_occupancy_trend
SELECT 
    DATE(ra.created_at) as date,
    COUNT(DISTINCT r.id) as total_rooms,
    COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) as occupied_rooms,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ra.student_id IS NOT NULL THEN r.id END) * 100.0) / 
        COUNT(DISTINCT r.id), 2
    ) as room_occupancy_percentage
FROM rooms r
JOIN blocks bl ON r.block_id = bl.id
LEFT JOIN room_allocations ra ON ra.bed_id IN (
    SELECT b.id FROM beds b WHERE b.room_id = r.id
) AND ra.is_active = true
WHERE bl.hostel_id = $1
GROUP BY DATE(ra.created_at)
ORDER BY DATE(ra.created_at);
```

---

## 🔄 **MATERIALIZED VIEWS REFRESH STRATEGY**

### ⏰ **Refresh Schedule**

| Materialized View | Refresh Frequency | Priority |
|-------------------|-------------------|----------|
| `mv_attendance_daily_summary` | Every 30 seconds | High |
| `mv_gate_pass_daily_summary` | Every 30 seconds | High |
| `mv_meals_daily_summary` | Every 30 seconds | High |
| `mv_occupancy_daily_summary` | Every 30 seconds | High |
| `mv_integrity_daily_summary` | Every 30 seconds | High |
| `mv_attendance_weekly_trend` | Every 5 minutes | Medium |
| `mv_gate_pass_weekly_trend` | Every 5 minutes | Medium |
| `mv_meals_weekly_trend` | Every 5 minutes | Medium |
| `mv_occupancy_weekly_trend` | Every 5 minutes | Medium |
| `mv_integrity_weekly_trend` | Every 5 minutes | Medium |

### 🔧 **Refresh Commands**

```sql
-- Refresh all high-priority views
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_attendance_daily_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_gate_pass_daily_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_meals_daily_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_occupancy_daily_summary;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_integrity_daily_summary;

-- Refresh all medium-priority views
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_attendance_weekly_trend;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_gate_pass_weekly_trend;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_meals_weekly_trend;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_occupancy_weekly_trend;
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_integrity_weekly_trend;
```

---

## 📊 **PERFORMANCE MONITORING QUERIES**

### ⚡ **Query Performance Metrics**

```sql
-- Query: query_performance_metrics
SELECT 
    query_name,
    AVG(execution_time_ms) as avg_execution_time,
    MAX(execution_time_ms) as max_execution_time,
    MIN(execution_time_ms) as min_execution_time,
    COUNT(*) as execution_count,
    AVG(rows_returned) as avg_rows_returned
FROM query_performance_log
WHERE executed_at BETWEEN $1 AND $2
GROUP BY query_name
ORDER BY avg_execution_time DESC;
```

### 📈 **Materialized View Status**

```sql
-- Query: materialized_view_status
SELECT 
    schemaname,
    matviewname,
    matviewowner,
    ispopulated,
    definition
FROM pg_matviews
WHERE schemaname = 'public'
ORDER BY matviewname;
```

---

## 🎯 **ACCEPTANCE CRITERIA VERIFICATION**

### ✅ **Tile Refresh Verification**
```sql
-- Verify tile freshness
SELECT 
    tile_id,
    last_updated,
    EXTRACT(EPOCH FROM (NOW() - last_updated)) as age_seconds,
    CASE 
        WHEN EXTRACT(EPOCH FROM (NOW() - last_updated)) <= 30 THEN 'Fresh'
        ELSE 'Stale'
    END as freshness_status
FROM dashboard_tiles
WHERE hostel_id = $1;
```

### ✅ **Drill-down Verification**
```sql
-- Verify drill-down data consistency
SELECT 
    'attendance_sessions' as drill_down_type,
    COUNT(*) as record_count,
    MAX(created_at) as latest_record
FROM attendance_sessions
WHERE hostel_id = $1 AND DATE(start_time) = $2

UNION ALL

SELECT 
    'gate_passes' as drill_down_type,
    COUNT(*) as record_count,
    MAX(created_at) as latest_record
FROM gate_passes
WHERE hostel_id = $1 AND DATE(created_at) = $2

UNION ALL

SELECT 
    'meal_intents' as drill_down_type,
    COUNT(*) as record_count,
    MAX(created_at) as latest_record
FROM meal_intents
WHERE hostel_id = $1 AND DATE(date) = $2;
```

---

*Last Updated: 2025-10-20*
*Status: ✅ Data Dictionary Complete*
*Commit: feat(dash): live tiles + daily/monthly drilldowns + freshness labels*
