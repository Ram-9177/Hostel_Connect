# HostelConnect Deployment Guide

## 🚀 Overview

This guide covers the complete deployment process for HostelConnect, from development to production on Microsoft Azure.

## 📋 Prerequisites

### Required Tools
- **Azure CLI** - `az --version`
- **Docker** - `docker --version`
- **Node.js** - `node --version` (16+)
- **Flutter** - `flutter --version` (3.0+)
- **Git** - `git --version`

### Azure Resources
- **Azure Subscription** with billing enabled
- **Resource Group** for HostelConnect resources
- **Service Principal** for CI/CD authentication

## 🏗️ Infrastructure Setup

### 1. Create Resource Group
```bash
# Create resource group
az group create \
  --name HostelConnect-RG \
  --location eastus

# Verify creation
az group show --name HostelConnect-RG
```

### 2. Create PostgreSQL Flexible Server
```bash
# Create PostgreSQL server
az postgres flexible-server create \
  --resource-group HostelConnect-RG \
  --name hostelconnect-db \
  --location eastus \
  --admin-user hosteladmin \
  --admin-password "SecurePassword123!" \
  --sku-name Standard_B1ms \
  --tier Burstable \
  --public-access 0.0.0.0 \
  --storage-size 32

# Create database
az postgres flexible-server db create \
  --resource-group HostelConnect-RG \
  --server-name hostelconnect-db \
  --database-name hostelconnect
```

### 3. Create Redis Cache
```bash
# Create Redis cache
az redis create \
  --resource-group HostelConnect-RG \
  --name hostelconnect-redis \
  --location eastus \
  --sku Basic \
  --vm-size c0

# Get connection string
az redis list-keys \
  --resource-group HostelConnect-RG \
  --name hostelconnect-redis
```

### 4. Create Storage Account
```bash
# Create storage account
az storage account create \
  --resource-group HostelConnect-RG \
  --name hostelconnectstorage \
  --location eastus \
  --sku Standard_LRS

# Create container for uploads
az storage container create \
  --name uploads \
  --account-name hostelconnectstorage
```

### 5. Create App Service Plan
```bash
# Create App Service plan
az appservice plan create \
  --resource-group HostelConnect-RG \
  --name HostelConnect-Plan \
  --location eastus \
  --sku B1 \
  --is-linux
```

## 🔧 Backend Deployment

### 1. Prepare API for Production
```bash
cd hostelconnect/api

# Install dependencies
npm install

# Build production version
npm run build

# Test production build
npm run start:prod
```

### 2. Create Docker Image
```dockerfile
# Dockerfile.api
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY dist/ ./dist/

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "dist/main.js"]
```

### 3. Build and Push Docker Image
```bash
# Build image
docker build -f Dockerfile.api -t hostelconnect-api:latest .

# Tag for Azure Container Registry
docker tag hostelconnect-api:latest hostelconnect.azurecr.io/api:latest

# Push to registry
docker push hostelconnect.azurecr.io/api:latest
```

### 4. Deploy to App Service
```bash
# Create web app
az webapp create \
  --resource-group HostelConnect-RG \
  --plan HostelConnect-Plan \
  --name hostelconnect-api \
  --deployment-container-image-name hostelconnect.azurecr.io/api:latest

# Configure app settings
az webapp config appsettings set \
  --resource-group HostelConnect-RG \
  --name hostelconnect-api \
  --settings \
    NODE_ENV=production \
    PORT=3000 \
    DATABASE_URL="postgresql://hosteladmin:SecurePassword123!@hostelconnect-db.postgres.database.azure.com:5432/hostelconnect" \
    REDIS_URL="redis://hostelconnect-redis.redis.cache.windows.net:6380" \
    JWT_SECRET="your-production-jwt-secret" \
    JWT_EXPIRES_IN="24h"
```

## 📱 Mobile App Deployment

### 1. Android Build
```bash
cd hostelconnect/mobile

# Clean and get dependencies
flutter clean
flutter pub get

# Build release APK
flutter build apk --release

# Build App Bundle (AAB)
flutter build appbundle --release
```

### 2. iOS Build
```bash
# Build iOS app
flutter build ios --release

# Archive for App Store
flutter build ipa --release
```

### 3. App Store Deployment
```bash
# Android - Upload to Play Console
# Use the generated AAB file from build/app/outputs/bundle/release/

# iOS - Upload to App Store Connect
# Use the generated IPA file from build/ios/ipa/
```

## 🔄 CI/CD Pipeline

### 1. GitHub Actions Workflow
```yaml
# .github/workflows/deploy.yml
name: Deploy to Azure

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm test

  build-api:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: azure/docker-login@v1
        with:
          login-server: hostelconnect.azurecr.io
          username: ${{ secrets.ACR_USERNAME }}
          password: ${{ secrets.ACR_PASSWORD }}
      - run: docker build -f Dockerfile.api -t hostelconnect-api:latest .
      - run: docker tag hostelconnect-api:latest hostelconnect.azurecr.io/api:latest
      - run: docker push hostelconnect.azurecr.io/api:latest

  deploy-api:
    needs: build-api
    runs-on: ubuntu-latest
    steps:
      - uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      - uses: azure/webapps-deploy@v2
        with:
          app-name: hostelconnect-api
          images: hostelconnect.azurecr.io/api:latest

  build-mobile:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.0.0'
      - run: flutter pub get
      - run: flutter build apk --release
      - run: flutter build appbundle --release
      - uses: actions/upload-artifact@v3
        with:
          name: android-builds
          path: build/app/outputs/
```

### 2. Environment Variables
```bash
# GitHub Secrets
ACR_USERNAME=your-acr-username
ACR_PASSWORD=your-acr-password
AZURE_CREDENTIALS=your-service-principal-json
```

## 🔒 Security Configuration

### 1. SSL/TLS Setup
```bash
# Enable HTTPS
az webapp config ssl bind \
  --resource-group HostelConnect-RG \
  --name hostelconnect-api \
  --certificate-thumbprint your-certificate-thumbprint
```

### 2. CORS Configuration
```typescript
// In your NestJS app
app.enableCors({
  origin: [
    'https://your-domain.com',
    'https://your-mobile-app.com'
  ],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
});
```

### 3. Rate Limiting
```typescript
// Implement rate limiting
import { ThrottlerModule } from '@nestjs/throttler';

@Module({
  imports: [
    ThrottlerModule.forRoot({
      ttl: 60,
      limit: 100,
    }),
  ],
})
export class AppModule {}
```

## 📊 Monitoring Setup

### 1. Application Insights
```bash
# Create Application Insights
az monitor app-insights component create \
  --resource-group HostelConnect-RG \
  --app hostelconnect-insights \
  --location eastus

# Get instrumentation key
az monitor app-insights component show \
  --resource-group HostelConnect-RG \
  --app hostelconnect-insights \
  --query instrumentationKey
```

### 2. Configure Monitoring
```typescript
// In your NestJS app
import { ApplicationInsights } from '@microsoft/applicationinsights';

const appInsights = new ApplicationInsights({
  config: {
    instrumentationKey: process.env.APPINSIGHTS_INSTRUMENTATIONKEY,
  }
});

appInsights.start();
```

### 3. Set Up Alerts
```bash
# Create alert rule
az monitor metrics alert create \
  --resource-group HostelConnect-RG \
  --name "High CPU Usage" \
  --scopes /subscriptions/your-subscription-id/resourceGroups/HostelConnect-RG/providers/Microsoft.Web/sites/hostelconnect-api \
  --condition "avg Percentage CPU > 80" \
  --description "Alert when CPU usage exceeds 80%"
```

## 🔄 Database Migration

### 1. Run Migrations
```bash
# Connect to database
psql "postgresql://hosteladmin:SecurePassword123!@hostelconnect-db.postgres.database.azure.com:5432/hostelconnect"

# Run migrations
npm run migration:run
```

### 2. Seed Initial Data
```bash
# Seed database with initial data
npm run seed:run
```

## 🧪 Testing Deployment

### 1. Health Check
```bash
# Check API health
curl https://hostelconnect-api.azurewebsites.net/health

# Check database connection
curl https://hostelconnect-api.azurewebsites.net/api/v1/health/db
```

### 2. Load Testing
```bash
# Install artillery
npm install -g artillery

# Run load test
artillery run load-test.yml
```

### 3. Mobile App Testing
```bash
# Test on physical device
flutter install --release

# Test on emulator
flutter run --release
```

## 📈 Performance Optimization

### 1. Enable Caching
```typescript
// Redis caching
import { CacheModule } from '@nestjs/cache-manager';
import { redisStore } from 'cache-manager-redis-store';

@Module({
  imports: [
    CacheModule.register({
      store: redisStore,
      host: process.env.REDIS_HOST,
      port: process.env.REDIS_PORT,
      password: process.env.REDIS_PASSWORD,
    }),
  ],
})
export class AppModule {}
```

### 2. Database Optimization
```sql
-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_attendance_date ON attendance(date);
CREATE INDEX idx_gate_pass_status ON gate_pass(status);
```

### 3. CDN Configuration
```bash
# Enable CDN for static assets
az cdn profile create \
  --resource-group HostelConnect-RG \
  --name hostelconnect-cdn \
  --sku Standard_Microsoft
```

## 🚨 Troubleshooting

### Common Issues

#### 1. Database Connection Issues
```bash
# Check database connectivity
az postgres flexible-server show \
  --resource-group HostelConnect-RG \
  --name hostelconnect-db

# Test connection
psql "postgresql://hosteladmin:SecurePassword123!@hostelconnect-db.postgres.database.azure.com:5432/hostelconnect"
```

#### 2. Redis Connection Issues
```bash
# Check Redis status
az redis show \
  --resource-group HostelConnect-RG \
  --name hostelconnect-redis

# Test connection
redis-cli -h hostelconnect-redis.redis.cache.windows.net -p 6380 -a your-redis-key
```

#### 3. App Service Issues
```bash
# Check app service logs
az webapp log tail \
  --resource-group HostelConnect-RG \
  --name hostelconnect-api

# Restart app service
az webapp restart \
  --resource-group HostelConnect-RG \
  --name hostelconnect-api
```

## 📋 Maintenance

### 1. Regular Updates
- **Security Patches:** Monthly
- **Dependencies:** Quarterly
- **Infrastructure:** As needed

### 2. Backup Strategy
```bash
# Database backup
az postgres flexible-server backup create \
  --resource-group HostelConnect-RG \
  --name hostelconnect-db \
  --backup-name daily-backup-$(date +%Y%m%d)
```

### 3. Monitoring
- **Uptime:** 99.9% SLA
- **Performance:** <300ms response time
- **Errors:** <1% error rate

## 🎯 Success Metrics

### Deployment Success
- ✅ API deployed and accessible
- ✅ Database connected and migrated
- ✅ Redis cache operational
- ✅ Mobile app builds successfully
- ✅ CI/CD pipeline functional
- ✅ Monitoring and alerts configured

### Performance Targets
- **API Response Time:** <300ms (p95)
- **Database Query Time:** <100ms (p95)
- **Mobile App Startup:** <3 seconds
- **Uptime:** 99.9% availability

---

**This deployment guide provides a comprehensive roadmap for deploying HostelConnect to production on Microsoft Azure.**
