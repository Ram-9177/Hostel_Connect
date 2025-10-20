import { MigrationInterface, QueryRunner } from 'typeorm';

export class InitialSchema1700000000000 implements MigrationInterface {
  name = 'InitialSchema1700000000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    // Enable UUID extension
    await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS "uuid-ossp"`);

    // Users table
    await queryRunner.query(`
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
      )
    `);

    // Students table
    await queryRunner.query(`
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
      )
    `);

    // Hostels table
    await queryRunner.query(`
      CREATE TABLE "hostels" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "name" character varying NOT NULL,
        "address" text,
        "capacity" integer NOT NULL,
        "is_active" boolean NOT NULL DEFAULT true,
        "created_at" timestamp NOT NULL DEFAULT now(),
        "updated_at" timestamp NOT NULL DEFAULT now(),
        CONSTRAINT "PK_hostels_id" PRIMARY KEY ("id")
      )
    `);

    // Blocks table
    await queryRunner.query(`
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
      )
    `);

    // Rooms table
    await queryRunner.query(`
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
      )
    `);

    // Devices table
    await queryRunner.query(`
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
      )
    `);

    // Gate Passes table
    await queryRunner.query(`
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
      )
    `);

    // Gate Events table
    await queryRunner.query(`
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
      )
    `);

    // Attendance Sessions table
    await queryRunner.query(`
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
      )
    `);

    // Attendance Roster table
    await queryRunner.query(`
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
      )
    `);

    // Attendance Checks table
    await queryRunner.query(`
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
      )
    `);

    // Meal Intents table
    await queryRunner.query(`
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
      )
    `);

    // Meal Overrides table
    await queryRunner.query(`
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
      )
    `);

    // Ads table
    await queryRunner.query(`
      CREATE TABLE "ads" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "type" character varying NOT NULL CHECK (type IN ('INTERSTITIAL', 'BANNER', 'MINICARD')),
        "asset_url" character varying NOT NULL,
        "duration_s" integer NOT NULL,
        "active" boolean NOT NULL DEFAULT true,
        "created_at" timestamp NOT NULL DEFAULT now(),
        "updated_at" timestamp NOT NULL DEFAULT now(),
        CONSTRAINT "PK_ads_id" PRIMARY KEY ("id")
      )
    `);

    // Ad Events table
    await queryRunner.query(`
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
      )
    `);

    // Audit Events table
    await queryRunner.query(`
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
      )
    `);

    // Create indexes for performance
    await queryRunner.query(`CREATE INDEX "IDX_gate_passes_student_status" ON "gate_passes" ("student_id", "status")`);
    await queryRunner.query(`CREATE INDEX "IDX_gate_events_student_timestamp" ON "gate_events" ("student_id", "timestamp" DESC)`);
    await queryRunner.query(`CREATE INDEX "IDX_attendance_checks_session_student" ON "attendance_checks" ("session_id", "student_id")`);
    await queryRunner.query(`CREATE INDEX "IDX_meal_intents_date_meal" ON "meal_intents" ("date", "meal")`);
    await queryRunner.query(`CREATE INDEX "IDX_audit_events_timestamp" ON "audit_events" ("timestamp" DESC)`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    // Drop tables in reverse order
    await queryRunner.query(`DROP TABLE "audit_events"`);
    await queryRunner.query(`DROP TABLE "ad_events"`);
    await queryRunner.query(`DROP TABLE "ads"`);
    await queryRunner.query(`DROP TABLE "meal_overrides"`);
    await queryRunner.query(`DROP TABLE "meal_intents"`);
    await queryRunner.query(`DROP TABLE "attendance_checks"`);
    await queryRunner.query(`DROP TABLE "attendance_roster"`);
    await queryRunner.query(`DROP TABLE "attendance_sessions"`);
    await queryRunner.query(`DROP TABLE "gate_events"`);
    await queryRunner.query(`DROP TABLE "gate_passes"`);
    await queryRunner.query(`DROP TABLE "devices"`);
    await queryRunner.query(`DROP TABLE "rooms"`);
    await queryRunner.query(`DROP TABLE "blocks"`);
    await queryRunner.query(`DROP TABLE "hostels"`);
    await queryRunner.query(`DROP TABLE "students"`);
    await queryRunner.query(`DROP TABLE "users"`);
  }
}
