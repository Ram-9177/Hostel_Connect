# HostelConnect API Runbook

## 🚀 API Operations Guide

### Starting the API Server

#### Development Mode
```bash
cd hostelconnect/api
node test-server.js
```

#### Production Mode (NestJS)
```bash
cd hostelconnect/api
npm install
npm run build
npm run start:prod
```

### API Endpoints

#### Authentication
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/refresh` - Token refresh
- `GET /api/v1/auth/profile` - User profile

#### Gate Pass Management
- `GET /api/v1/gate-passes/:id/qr?adCompleted=true` - Generate QR (requires ad)
- `POST /api/v1/gate/scan` - Scan QR token
- `POST /api/v1/gate-passes` - Request gate pass
- `PATCH /api/v1/gate-passes/:id/approve` - Approve gate pass

#### Attendance
- `POST /api/v1/attendance/mark` - Mark attendance
- `GET /api/v1/attendance/sessions` - Get sessions
- `POST /api/v1/attendance/sessions` - Create session

#### Dashboard & Analytics
- `GET /api/v1/dashboard/:role` - Get role-specific dashboard
- `POST /api/v1/dashboard/refresh` - Refresh materialized views

#### CSV Operations
- `GET /api/v1/export/:type` - Export CSV (rooms, students, attendance)
- `POST /api/v1/import/:type` - Import CSV data

#### Push Notifications
- `POST /api/v1/fcm/register` - Register device token
- `POST /api/v1/notices/push` - Send push notification

#### Ad Analytics
- `POST /api/v1/ads/impression` - Track ad impression
- `POST /api/v1/ads/completion` - Track ad completion
- `GET /api/v1/ads/stats` - Get ad statistics

### Health Monitoring

#### Health Check
```bash
curl http://localhost:3000/api/v1/health
```

#### Performance Monitoring
- Response time monitoring
- Error rate tracking
- Memory usage monitoring
- Database connection monitoring

### Troubleshooting

#### Common Issues
1. **Port 3000 in use**
   ```bash
   lsof -ti:3000 | xargs kill -9
   ```

2. **CORS errors**
   - Check CORS configuration in server
   - Verify client URL in CORS settings

3. **Database connection issues**
   - Check database server status
   - Verify connection string
   - Check network connectivity

#### Logs
- API logs: Console output
- Error logs: Check application logs
- Performance logs: Monitor response times

### Security

#### Rate Limiting
- Login endpoint: 5 requests per minute
- QR generation: 10 requests per minute
- General API: 100 requests per minute

#### Authentication
- JWT tokens with 1-hour expiry
- Refresh tokens with 7-day expiry
- Secure token storage

#### Data Protection
- PII encryption at rest
- Secure data transmission
- Input validation and sanitization

### Deployment

#### Environment Variables
```bash
NODE_ENV=production
PORT=3000
DB_URL=postgresql://...
REDIS_URL=redis://...
JWT_SECRET=your-secret-key
FCM_KEY=your-fcm-key
```

#### Docker Deployment
```bash
docker build -t hostelconnect-api .
docker run -p 3000:3000 hostelconnect-api
```

#### Azure Deployment
- Use Azure App Service
- Configure environment variables
- Set up monitoring
- Configure scaling
