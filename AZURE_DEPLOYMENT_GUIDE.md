# Azure Deployment Configuration for HostelConnect

## 🚀 Quick Fix for Server Connection Issue

### **Immediate Solution:**

1. **Stop all API processes:**
   ```bash
   cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/api"
   pkill -f "nest start"
   pkill -f "node dist/main"
   ```

2. **Start API with proper configuration:**
   ```bash
   cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/api"
   npm run build
   PORT=3000 HOST=0.0.0.0 node dist/main.js
   ```

3. **Test API connection:**
   ```bash
   curl http://localhost:3000/api/v1/
   ```

### **Alternative: Use Docker (Recommended for Azure)**

```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"
docker-compose up -d postgres redis
docker-compose up -d api
```

---

## ☁️ Microsoft Azure Deployment Configuration

### **1. Azure App Service Configuration**

#### **Environment Variables for Azure:**
```bash
# Database Configuration
DB_HOST=your-postgres-server.postgres.database.azure.com
DB_PORT=5432
DB_USERNAME=hostelconnect@your-postgres-server
DB_PASSWORD=your-secure-password
DB_DATABASE=hostelconnect
DB_SSL=true

# Redis Configuration
REDIS_HOST=your-redis-cache.redis.cache.windows.net
REDIS_PORT=6380
REDIS_PASSWORD=your-redis-key
REDIS_TLS=true

# Application Configuration
NODE_ENV=production
PORT=8080
HOST=0.0.0.0
JWT_SECRET=your-super-secure-jwt-secret
JWT_REFRESH_SECRET=your-super-secure-refresh-secret

# CORS Configuration
CORS_ORIGIN=https://your-app.azurewebsites.net
FRONTEND_URL=https://your-app.azurewebsites.net

# Firebase Configuration (if using)
FIREBASE_PROJECT_ID=your-firebase-project
FIREBASE_PRIVATE_KEY=your-firebase-private-key
FIREBASE_CLIENT_EMAIL=your-firebase-client-email
```

### **2. Azure Resources Setup**

#### **Required Azure Services:**
1. **Azure App Service** (for API)
2. **Azure Database for PostgreSQL** (for database)
3. **Azure Cache for Redis** (for caching)
4. **Azure Storage Account** (for file uploads)
5. **Azure Application Insights** (for monitoring)

#### **Deployment Commands:**
```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to Azure
az login

# Create resource group
az group create --name HostelConnectRG --location "East US"

# Create PostgreSQL server
az postgres flexible-server create \
  --resource-group HostelConnectRG \
  --name hostelconnect-postgres \
  --admin-user hostelconnect \
  --admin-password "YourSecurePassword123!" \
  --sku-name Standard_B1ms \
  --tier Burstable \
  --public-access 0.0.0.0-255.255.255.255

# Create Redis cache
az redis create \
  --resource-group HostelConnectRG \
  --name hostelconnect-redis \
  --location "East US" \
  --sku Basic \
  --vm-size c0

# Create App Service
az webapp create \
  --resource-group HostelConnectRG \
  --plan HostelConnectPlan \
  --name hostelconnect-api \
  --runtime "NODE|18-lts"
```

### **3. Docker Configuration for Azure**

#### **Dockerfile for Azure:**
```dockerfile
FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nestjs
COPY --from=builder --chown=nestjs:nodejs /app/dist ./dist
COPY --from=base --chown=nestjs:nodejs /app/node_modules ./node_modules
COPY --chown=nestjs:nodejs package.json ./
USER nestjs
EXPOSE 8080
ENV PORT=8080
ENV HOST=0.0.0.0
CMD ["node", "dist/main.js"]
```

#### **docker-compose.yml for Azure:**
```yaml
version: '3.8'
services:
  api:
    build: .
    ports:
      - "8080:8080"
    environment:
      - NODE_ENV=production
      - PORT=8080
      - HOST=0.0.0.0
      - DB_HOST=${DB_HOST}
      - DB_PORT=${DB_PORT}
      - DB_USERNAME=${DB_USERNAME}
      - DB_PASSWORD=${DB_PASSWORD}
      - DB_DATABASE=${DB_DATABASE}
      - REDIS_HOST=${REDIS_HOST}
      - REDIS_PORT=${REDIS_PORT}
      - REDIS_PASSWORD=${REDIS_PASSWORD}
      - JWT_SECRET=${JWT_SECRET}
      - JWT_REFRESH_SECRET=${JWT_REFRESH_SECRET}
      - CORS_ORIGIN=${CORS_ORIGIN}
```

### **4. Azure Deployment Script**

#### **deploy-to-azure.sh:**
```bash
#!/bin/bash

echo "🚀 Deploying HostelConnect to Azure..."

# Build the application
echo "📦 Building application..."
npm run build

# Create Docker image
echo "🐳 Creating Docker image..."
docker build -t hostelconnect-api .

# Tag for Azure Container Registry
docker tag hostelconnect-api hostelconnect.azurecr.io/hostelconnect-api:latest

# Push to Azure Container Registry
echo "📤 Pushing to Azure Container Registry..."
docker push hostelconnect.azurecr.io/hostelconnect-api:latest

# Deploy to Azure App Service
echo "☁️ Deploying to Azure App Service..."
az webapp config container set \
  --name hostelconnect-api \
  --resource-group HostelConnectRG \
  --docker-custom-image-name hostelconnect.azurecr.io/hostelconnect-api:latest

echo "✅ Deployment complete!"
```

### **5. Mobile App Configuration for Azure**

#### **Update API Base URL in Flutter App:**
```dart
// lib/core/config/api_config.dart
class ApiConfig {
  static const String baseUrl = 'https://hostelconnect-api.azurewebsites.net/api/v1';
  static const String socketUrl = 'wss://hostelconnect-api.azurewebsites.net/notifications';
  
  // For development
  static const String devBaseUrl = 'http://localhost:3000/api/v1';
  static const String devSocketUrl = 'ws://localhost:3000/notifications';
  
  static String get currentBaseUrl {
    return kDebugMode ? devBaseUrl : baseUrl;
  }
  
  static String get currentSocketUrl {
    return kDebugMode ? devSocketUrl : socketUrl;
  }
}
```

### **6. Environment-Specific Configuration**

#### **Production Environment (.env.production):**
```bash
NODE_ENV=production
PORT=8080
HOST=0.0.0.0

# Azure PostgreSQL
DB_HOST=hostelconnect-postgres.postgres.database.azure.com
DB_PORT=5432
DB_USERNAME=hostelconnect@hostelconnect-postgres
DB_PASSWORD=YourSecurePassword123!
DB_DATABASE=hostelconnect
DB_SSL=true

# Azure Redis
REDIS_HOST=hostelconnect-redis.redis.cache.windows.net
REDIS_PORT=6380
REDIS_PASSWORD=YourRedisKey
REDIS_TLS=true

# JWT Secrets
JWT_SECRET=your-super-secure-jwt-secret-for-production
JWT_REFRESH_SECRET=your-super-secure-refresh-secret-for-production

# CORS
CORS_ORIGIN=https://hostelconnect-app.azurewebsites.net
FRONTEND_URL=https://hostelconnect-app.azurewebsites.net

# Firebase (if using)
FIREBASE_PROJECT_ID=hostelconnect-prod
FIREBASE_PRIVATE_KEY=your-firebase-private-key
FIREBASE_CLIENT_EMAIL=your-firebase-client-email
```

### **7. Monitoring and Logging**

#### **Azure Application Insights Integration:**
```typescript
// src/main.ts
import { ApplicationInsights } from '@microsoft/applicationinsights-web';

const appInsights = new ApplicationInsights({
  config: {
    connectionString: process.env.APPLICATIONINSIGHTS_CONNECTION_STRING,
    enableAutoRouteTracking: true,
    enableCorsCorrelation: true,
  }
});

appInsights.loadAppInsights();
appInsights.trackPageView();
```

### **8. Security Configuration**

#### **Azure Security Settings:**
```bash
# Enable HTTPS only
az webapp update --name hostelconnect-api --resource-group HostelConnectRG --https-only true

# Configure CORS
az webapp cors add --name hostelconnect-api --resource-group HostelConnectRG --allowed-origins "https://hostelconnect-app.azurewebsites.net"

# Enable managed identity
az webapp identity assign --name hostelconnect-api --resource-group HostelConnectRG
```

---

## 🔧 **Immediate Fix for Current Issue**

### **Step 1: Fix Local API**
```bash
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/api"
pkill -f "nest start"
npm run build
PORT=3000 HOST=0.0.0.0 node dist/main.js
```

### **Step 2: Test Connection**
```bash
curl http://localhost:3000/api/v1/
```

### **Step 3: Update Mobile App API URL**
Update the API base URL in your Flutter app to point to `http://localhost:3000/api/v1`

### **Step 4: Test Login**
Use the credentials:
- Email: `student@demo.com`
- Password: `password123`

---

## 📱 **Mobile App Testing Checklist**

- [ ] API server running on port 3000
- [ ] Mobile app can connect to API
- [ ] Login functionality works
- [ ] All API endpoints responding
- [ ] Real-time features working
- [ ] File uploads working
- [ ] Push notifications working

---

## ☁️ **Azure Deployment Checklist**

- [ ] Azure resources created
- [ ] Environment variables configured
- [ ] Docker image built and pushed
- [ ] App Service deployed
- [ ] Database migrations run
- [ ] SSL certificates configured
- [ ] Monitoring enabled
- [ ] Security settings applied

This configuration will make your HostelConnect app ready for Microsoft Azure deployment! 🚀
