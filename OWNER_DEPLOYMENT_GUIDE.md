# HostelConnect Deployment & Installation Guide for Owners
## Complete Production Deployment Guide

> **For:** Hostel Owners, Administrators, IT Managers  
> **Difficulty:** Beginner-Friendly  
> **Time Required:** 2-4 hours

---

## 📋 Table of Contents

1. [System Requirements](#system-requirements)
2. [Pre-Deployment Checklist](#pre-deployment-checklist)
3. [Deployment Options](#deployment-options)
4. [Quick Start Deployment (Docker - Recommended)](#quick-start-deployment)
5. [Manual Deployment](#manual-deployment)
6. [Mobile App Distribution](#mobile-app-distribution)
7. [Post-Deployment Configuration](#post-deployment-configuration)
8. [Maintenance & Backups](#maintenance--backups)
9. [Cost Breakdown](#cost-breakdown)
10. [Support & Troubleshooting](#support--troubleshooting)

---

## 💻 System Requirements

### For Self-Hosting (On-Premise Server)

**Minimum Requirements:**
- **CPU:** 4 cores (2.5 GHz+)
- **RAM:** 8 GB
- **Storage:** 100 GB SSD
- **OS:** Ubuntu 22.04 LTS / Windows Server 2019+
- **Network:** Static IP address, 100 Mbps+ internet

**Recommended for 500+ Students:**
- **CPU:** 8 cores (3.0 GHz+)
- **RAM:** 16 GB
- **Storage:** 250 GB SSD
- **Network:** Dedicated server with backup internet

### For Cloud Hosting

**Budget Option ($20-40/month):**
- DigitalOcean Droplet (2 vCPUs, 4GB RAM) - $24/month
- AWS EC2 t3.medium - ~$30/month
- Linode Shared 4GB - $24/month

**Production Option ($50-100/month):**
- AWS EC2 t3.large (2 vCPUs, 8GB) + RDS PostgreSQL
- DigitalOcean Premium Droplet (4GB) + Managed Database
- Azure B2s VM + Azure Database for PostgreSQL

---

## ✅ Pre-Deployment Checklist

### Required Information

- [ ] **Domain Name** (e.g., hostel.yourcollegename.edu)
- [ ] **SSL Certificate** (Let's Encrypt - free, or purchased)
- [ ] **SMTP Email Server** (for notifications)
  - Gmail SMTP (free for low volume)
  - SendGrid / Mailgun (paid, reliable)
- [ ] **Firebase Account** (for mobile push notifications - free tier)
- [ ] **Admin Contact Details**
  - Super Admin Name, Email, Phone
  - Initial Warden Names, Emails
- [ ] **Hostel Structure Data**
  - Hostel Names
  - Block/Floor/Room Information

### Required Accounts

1. **Cloud Provider** (if cloud hosting)
   - AWS / DigitalOcean / Azure account
2. **Firebase Project**
   - Go to https://console.firebase.google.com
   - Create new project
   - Enable Cloud Messaging
3. **Email Provider**
   - Gmail account or
   - SendGrid account (https://sendgrid.com)

---

## 🚀 Deployment Options

### Option 1: Docker Deployment (RECOMMENDED ⭐)

**Best For:** Quick setup, easy maintenance, scalability  
**Difficulty:** Easy  
**Time:** 30 minutes

### Option 2: Manual Deployment

**Best For:** Full control, custom configurations  
**Difficulty:** Advanced  
**Time:** 2-3 hours

### Option 3: Cloud Platform Deployment

**Best For:** Zero server management, auto-scaling  
**Difficulty:** Easy  
**Time:** 1 hour

---

## 🐳 Quick Start Deployment (Docker - Recommended)

### Step 1: Server Setup

**Ubuntu 22.04 Server:**

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo apt install docker-compose -y

# Verify installation
docker --version
docker-compose --version
```

### Step 2: Get Application Files

```bash
# Create directory
mkdir -p /opt/hostelconnect
cd /opt/hostelconnect

# Clone repository (or upload files)
git clone https://github.com/yourusername/hostelconnect.git .

# Or download and extract ZIP
wget https://github.com/yourusername/hostelconnect/archive/main.zip
unzip main.zip
mv hostelconnect-main/* .
```

### Step 3: Configure Environment

```bash
# Copy example environment file
cp hostelconnect/production.env.example hostelconnect/.env

# Edit configuration
nano hostelconnect/.env
```

**Critical Settings to Update:**

```env
# Database Configuration
DATABASE_URL=postgresql://hostelconnect:CHANGE_THIS_PASSWORD@postgres:5432/hostelconnect

# Application Settings
JWT_SECRET=GENERATE_RANDOM_32_CHAR_STRING_HERE
API_URL=https://yourdomain.com/api/v1

# Email Configuration (Gmail Example)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-specific-password

# Firebase (for mobile notifications)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com
```

**Generate Secure JWT Secret:**
```bash
openssl rand -base64 32
```

### Step 4: Launch Application

```bash
cd hostelconnect

# Start all services
docker-compose -f docker-compose.production.yml up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f api
```

**Expected Output:**
```
NAME                STATUS              PORTS
hostelconnect_api   Up 30 seconds       0.0.0.0:3000->3000/tcp
hostelconnect_db    Up 30 seconds       5432/tcp
hostelconnect_redis Up 30 seconds       6379/tcp
hostelconnect_web   Up 30 seconds       0.0.0.0:80->80/tcp
```

### Step 5: Initial Data Setup

```bash
# Run database migrations
docker-compose exec api npm run migration:run

# Seed initial data
docker-compose exec api npm run seed
```

**Default Admin Credentials (CHANGE IMMEDIATELY):**
```
Email: admin@hostelconnect.com
Password: admin123
```

### Step 6: SSL Certificate Setup (HTTPS)

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx -y

# Get SSL certificate
sudo certbot --nginx -d yourdomain.com

# Auto-renewal (certificate renews every 90 days)
sudo certbot renew --dry-run
```

### Step 7: Configure Nginx

```bash
sudo nano /etc/nginx/sites-available/hostelconnect
```

**Nginx Configuration:**
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # API Backend
    location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # WebSocket for real-time features
    location /socket.io {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # Frontend
    location / {
        proxy_pass http://localhost:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

```bash
# Enable site
sudo ln -s /etc/nginx/sites-available/hostelconnect /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

---

## 📱 Mobile App Distribution

### Android App (APK)

**Method 1: Direct APK Distribution**

1. Build production APK:
   ```bash
   cd hostelconnect/mobile
   flutter build apk --release
   ```

2. APK location: `build/app/outputs/flutter-apk/app-release.apk`

3. Distribute via:
   - **Your Website:** Upload APK to `https://yourdomain.com/downloads/app.apk`
   - **File Sharing:** Google Drive, Dropbox (share link with students)
   - **Internal App Store:** If your institution has one

**Installation Instructions for Students:**

```
1. Download APK from https://yourdomain.com/downloads/app.apk
2. Open downloaded file
3. If "Install Blocked" appears:
   - Go to Settings → Security
   - Enable "Unknown Sources" or "Install from Unknown Sources"
4. Tap "Install"
5. Open app and login with hall ticket number
```

**Method 2: Google Play Store (Recommended for Official Release)**

1. Build App Bundle:
   ```bash
   flutter build appbundle --release
   ```

2. Create Google Play Developer Account ($25 one-time fee)
   - https://play.google.com/console

3. Upload app bundle and publish

**Cost:** $25 one-time + 0% commission

### iOS App (iPhone/iPad)

**Requirements:**
- Apple Developer Account ($99/year)
- macOS computer for building

**Steps:**
1. Build iOS app:
   ```bash
   flutter build ios --release
   ```

2. Upload to App Store Connect
3. Submit for review

---

## ⚙️ Post-Deployment Configuration

### Step 1: Create Admin Account

```bash
# Access application at https://yourdomain.com
# Login with default credentials
# Navigate to: Settings → Users → Create User

Name: Your Name
Email: admin@yourcollegename.edu
Phone: +91 9876543210
Role: SUPER_ADMIN
```

**IMPORTANT:** Delete default admin account after creating yours!

### Step 2: Add Hostel Structure

1. **Login as Super Admin**
2. **Navigate to: Hostels → Add New**
   
   **Example:**
   ```
   Hostel Name: Boys Hostel A
   Warden: Assign warden
   Total Capacity: 500
   ```

3. **Add Blocks (if applicable)**
   ```
   Block Name: Block A
   Hostel: Boys Hostel A
   Floors: 4
   ```

4. **Add Rooms**
   ```
   Room Number: 101
   Block: Block A
   Floor: 1
   Capacity: 4
   Type: Shared
   ```

### Step 3: Bulk Import Students

1. **Download CSV Template**
   - Navigate to: Students → Bulk Upload → Download Template

2. **Fill Student Data**
   ```csv
   name,hallTicket,collegeCode,phoneNumber,hostelName
   John Doe,2024CS001,CSE,9876543210,Boys Hostel A
   Jane Smith,2024EC002,ECE,9876543211,Girls Hostel A
   ```

3. **Upload CSV**
   - Select file → Upload
   - Review results
   - Students receive login credentials via email/SMS

### Step 4: Configure Notifications

1. **Navigate to: Settings → Notifications**

2. **Email Settings:**
   ```
   SMTP Host: smtp.gmail.com
   SMTP Port: 587
   Username: notifications@yourcollegename.edu
   Password: [App-specific password]
   From Name: HostelConnect Notifications
   ```

3. **SMS Settings (Optional):**
   - Integrate with Twilio / MSG91 / Fast2SMS

4. **Test Notifications:**
   - Send test notification to verify

---

## 🔧 Maintenance & Backups

### Daily Automated Backups

**Database Backup Script:**

```bash
#!/bin/bash
# /opt/hostelconnect/backup.sh

BACKUP_DIR="/opt/hostelconnect/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup database
docker-compose exec -T postgres pg_dump -U hostelconnect hostelconnect > $BACKUP_DIR/db_backup_$DATE.sql

# Backup uploaded files
tar -czf $BACKUP_DIR/uploads_$DATE.tar.gz /opt/hostelconnect/hostelconnect/uploads

# Delete backups older than 30 days
find $BACKUP_DIR -type f -mtime +30 -delete

echo "Backup completed: $DATE"
```

**Setup Cron Job:**
```bash
# Edit crontab
crontab -e

# Add backup job (runs daily at 2 AM)
0 2 * * * /opt/hostelconnect/backup.sh >> /var/log/hostelconnect_backup.log 2>&1
```

### System Updates

**Monthly Updates:**
```bash
cd /opt/hostelconnect/hostelconnect

# Backup first!
./backup.sh

# Pull latest updates
git pull origin main

# Rebuild containers
docker-compose down
docker-compose -f docker-compose.production.yml up -d --build

# Run migrations
docker-compose exec api npm run migration:run
```

### Monitoring

**Check System Health:**
```bash
# View API logs
docker-compose logs -f api

# Check disk space
df -h

# Check memory usage
free -m

# Check Docker container status
docker-compose ps
```

**Setup Monitoring Dashboard:**
- Access Grafana at `http://yourdomain.com:3001`
- Default credentials: admin/admin
- View system metrics, API performance, database stats

---

## 💰 Cost Breakdown

### Self-Hosting (On-Premise)

| Item | One-Time | Monthly |
|------|----------|---------|
| Server Hardware | $1,000-$2,000 | - |
| Domain Name | - | $1-2 |
| SSL Certificate | Free (Let's Encrypt) | - |
| Email Service (Gmail) | Free | Free |
| Backup Storage | - | $5-10 |
| **Total** | **$1,000-$2,000** | **$6-12** |

### Cloud Hosting

| Item | One-Time | Monthly |
|------|----------|---------|
| Server (DigitalOcean 4GB) | - | $24 |
| Database (Managed PostgreSQL) | - | $15 |
| Domain Name | - | $1-2 |
| SSL Certificate | Free | - |
| Email Service (SendGrid) | - | $15 |
| Backup Storage (50GB) | - | $5 |
| **Total** | **$0** | **$60** |

### Mobile App Distribution

| Platform | One-Time | Recurring |
|----------|----------|-----------|
| Direct APK (Free) | $0 | $0 |
| Google Play Store | $25 | $0 |
| Apple App Store | $99 | $99/year |

---

## 📞 Support & Troubleshooting

### Common Issues

**1. Application Not Starting**
```bash
# Check Docker logs
docker-compose logs

# Restart services
docker-compose restart
```

**2. Database Connection Error**
```bash
# Check PostgreSQL is running
docker-compose ps postgres

# View database logs
docker-compose logs postgres
```

**3. Students Can't Login**
- Verify student credentials in database
- Check email notifications are being sent
- Reset password via admin panel

**4. Mobile App Can't Connect**
- Verify API URL in app settings
- Check firewall allows port 3000
- Test API endpoint: `https://yourdomain.com/api/v1/health`

### Getting Help

**Email Support:** support@hostelconnect.com  
**Documentation:** https://github.com/yourusername/hostelconnect/wiki  
**Emergency Hotline:** +91 9876543210 (24/7)

### Maintenance Contract (Optional)

**Basic Plan ($99/month):**
- Monthly system updates
- Daily backups
- Email support (48-hour response)
- Security patches

**Premium Plan ($299/month):**
- Everything in Basic
- 24/7 phone support
- Priority bug fixes
- Custom feature development (5 hours/month)
- On-site support (quarterly)

---

## 🎓 Training Resources

### For Administrators

**Video Tutorials:** https://youtube.com/hostelconnect-tutorials
- System Setup (15 mins)
- User Management (10 mins)
- Bulk Student Import (8 mins)
- Creating Notifications (5 mins)

**Live Training:** Schedule via support@hostelconnect.com

### For Students

**User Guide:** https://yourdomain.com/student-guide.pdf
- How to Login
- Creating Gate Pass
- Meal Intent
- QR Code Scanning

---

## ✅ Deployment Checklist

- [ ] Server/Cloud hosting set up
- [ ] Domain name configured
- [ ] SSL certificate installed
- [ ] Docker containers running
- [ ] Database migrated and seeded
- [ ] Admin account created
- [ ] Default credentials changed
- [ ] Hostel structure added
- [ ] Students imported
- [ ] Email notifications configured
- [ ] Mobile app built and distributed
- [ ] Backup system configured
- [ ] Monitoring dashboard set up
- [ ] Admin training completed
- [ ] Student guide distributed

---

**Congratulations! Your HostelConnect system is now live! 🎉**

**Next Steps:**
1. Train your staff on the admin panel
2. Distribute mobile app to students
3. Monitor system performance
4. Gather feedback and iterate

For any questions or issues, don't hesitate to contact our support team!
