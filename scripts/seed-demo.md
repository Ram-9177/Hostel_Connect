# Demo Data Seeder

## Overview
This document describes the demo data seeding process for HostelConnect testing.

## Demo Accounts

### Student Account
- **Email:** student@demo.com
- **Password:** password123
- **Role:** student
- **Name:** John Student
- **Room:** Room 101, Bed 1

### Warden Account
- **Email:** warden@demo.com
- **Password:** password123
- **Role:** warden
- **Name:** Sarah Warden

### Warden Head Account
- **Email:** head@demo.com
- **Password:** password123
- **Role:** warden_head
- **Name:** Michael Head

### Super Admin Account
- **Email:** admin@demo.com
- **Password:** password123
- **Role:** super_admin
- **Name:** Admin User

### Chef Account
- **Email:** chef@demo.com
- **Password:** password123
- **Role:** chef
- **Name:** Chef Master

## Hostel Structure

### Blocks
1. **Block A** - Main Block
2. **Block B** - Annex Block

### Floors (per block)
- Floor 1 (Ground Floor)
- Floor 2
- Floor 3
- Floor 4

### Rooms (per floor)
- 10 rooms per floor
- Total: 40 rooms per block, 80 rooms total

### Beds (per room)
- 3 beds per room (triple occupancy)
- Total: 120 beds per block, 240 beds total

## Sample Data

### Gate Passes
- 3 pending gate passes from different students
- 2 approved gate passes ready for QR generation
- 1 rejected gate pass with reason

### Attendance Sessions
- 1 active KIOSK session
- 1 completed WARDEN session
- Sample attendance records

### Meal Preferences
- Today's meal preferences for all students
- Some opt-outs and special requests
- Chef forecast data

### Notices
- 2 active notices from Warden Head
- 1 emergency notice
- Sample read receipts

## Seeding Script

The demo data is automatically seeded when the API starts in development mode. The test-server.js includes mock endpoints that return realistic demo data.

## Testing Notes

- All demo accounts use the same password for easy testing
- Demo data is reset on each API restart
- Realistic data patterns for comprehensive testing
- All roles have appropriate permissions and access levels
