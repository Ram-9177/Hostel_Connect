# Azure Deployment Guide for HostelConnect

## 🚀 **AZURE INFRASTRUCTURE SETUP**

### **1. Resource Provisioning**

#### **App Service (Linux)**
```bash
# Create App Service Plan
az appservice plan create \
  --name "hostelconnect-plan" \
  --resource-group "hostelconnect-rg" \
  --sku "B1" \
  --is-linux

# Create Web App
az webapp create \
  --name "hostelconnect-api" \
  --resource-group "hostelconnect-rg" \
  --plan "hostelconnect-plan" \
  --runtime "NODE|18-lts"
```

#### **PostgreSQL Flexible Server**
```bash
# Create PostgreSQL server
az postgres flexible-server create \
  --name "hostelconnect-db" \
  --resource-group "hostelconnect-rg" \
  --admin-user "hosteladmin" \
  --admin-password "SecurePassword123!" \
  --sku-name "Standard_B1ms" \
  --tier "Burstable" \
  --public-access "0.0.0.0-255.255.255.255"
```

#### **Azure Cache for Redis**
```bash
# Create Redis cache
az redis create \
  --name "hostelconnect-redis" \
  --resource-group "hostelconnect-rg" \
  --location "East US" \
  --sku "Standard" \
  --vm-size "c1"
```

#### **Azure Storage Account**
```bash
# Create storage account
az storage account create \
  --name "hostelconnectstorage" \
  --resource-group "hostelconnect-rg" \
  --location "East US" \
  --sku "Standard_LRS"
```

### **2. Environment Variables**

#### **Required Secrets for GitHub Actions**
```yaml
# GitHub Secrets to configure:
AZURE_WEBAPP_NAME: hostelconnect-api
AZURE_CREDENTIALS: <Service Principal JSON>
DB_URL: postgresql://hosteladmin:SecurePassword123!@hostelconnect-db.postgres.database.azure.com:5432/hostelconnect
REDIS_URL: redis://hostelconnect-redis.redis.cache.windows.net:6380
JWT_SECRET: your-super-secret-jwt-key-here
FCM_KEY: your-firebase-cloud-messaging-key
AZURE_STORAGE_CONNECTION_STRING: DefaultEndpointsProtocol=https;AccountName=hostelconnectstorage;AccountKey=...
```

### **3. GitHub Actions Pipeline**

#### **`.github/workflows/azure-deploy.yml`**
```yaml
name: Deploy to Azure

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        cache-dependency-path: hostelconnect/api/package-lock.json
    
    - name: Install API dependencies
      run: |
        cd hostelconnect/api
        npm ci
    
    - name: Build API
      run: |
        cd hostelconnect/api
        npm run build
    
    - name: Run API tests
      run: |
        cd hostelconnect/api
        npm test
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        channel: 'stable'
    
    - name: Install Flutter dependencies
      run: |
        cd hostelconnect/mobile
        flutter pub get
    
    - name: Run Flutter tests
      run: |
        cd hostelconnect/mobile
        flutter test
    
    - name: Build Flutter APK
      run: |
        cd hostelconnect/mobile
        flutter build apk --release
    
    - name: Login to Azure
      uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    
    - name: Deploy to Azure App Service
      uses: azure/webapps-deploy@v2
      with:
        app-name: ${{ secrets.AZURE_WEBAPP_NAME }}
        package: hostelconnect/api/dist
    
    - name: Run Database Migrations
      run: |
        cd hostelconnect/api
        npm run migration:run
    
    - name: Seed Database
      run: |
        cd hostelconnect/api
        npm run seed:run
```

### **4. Auto-scaling Configuration**

#### **Scale Rules**
```json
{
  "profiles": [
    {
      "name": "AutoScaleProfile",
      "capacity": {
        "minimum": "1",
        "maximum": "3",
        "default": "1"
      },
      "rules": [
        {
          "metricTrigger": {
            "metricName": "CpuPercentage",
            "metricResourceUri": "/subscriptions/{subscription-id}/resourceGroups/hostelconnect-rg/providers/Microsoft.Web/serverfarms/hostelconnect-plan",
            "timeGrain": "PT1M",
            "statistic": "Average",
            "timeWindow": "PT5M",
            "timeAggregation": "Average",
            "operator": "GreaterThan",
            "threshold": 65
          },
          "scaleAction": {
            "direction": "Increase",
            "type": "ChangeCount",
            "value": "1",
            "cooldown": "PT5M"
          }
        },
        {
          "metricTrigger": {
            "metricName": "CpuPercentage",
            "metricResourceUri": "/subscriptions/{subscription-id}/resourceGroups/hostelconnect-rg/providers/Microsoft.Web/serverfarms/hostelconnect-plan",
            "timeGrain": "PT1M",
            "statistic": "Average",
            "timeWindow": "PT30M",
            "timeAggregation": "Average",
            "operator": "LessThan",
            "threshold": 35
          },
          "scaleAction": {
            "direction": "Decrease",
            "type": "ChangeCount",
            "value": "1",
            "cooldown": "PT30M"
          }
        }
      ]
    }
  ]
}
```

### **5. Monitoring and Logging**

#### **Application Insights**
```bash
# Create Application Insights
az monitor app-insights component create \
  --app "hostelconnect-insights" \
  --location "East US" \
  --resource-group "hostelconnect-rg"
```

#### **Log Analytics Workspace**
```bash
# Create Log Analytics workspace
az monitor log-analytics workspace create \
  --workspace-name "hostelconnect-logs" \
  --resource-group "hostelconnect-rg" \
  --location "East US"
```

### **6. Security Configuration**

#### **Network Security Groups**
```bash
# Create NSG for App Service
az network nsg create \
  --name "hostelconnect-nsg" \
  --resource-group "hostelconnect-rg"

# Allow HTTPS traffic
az network nsg rule create \
  --name "AllowHTTPS" \
  --nsg-name "hostelconnect-nsg" \
  --resource-group "hostelconnect-rg" \
  --priority 100 \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 443 \
  --access Allow \
  --protocol Tcp
```

#### **SSL Certificate**
```bash
# Create SSL certificate
az webapp config ssl upload \
  --name "hostelconnect-api" \
  --resource-group "hostelconnect-rg" \
  --certificate-file "certificate.pfx" \
  --certificate-password "YourPassword"
```

### **7. Backup Configuration**

#### **Database Backup**
```bash
# Enable automated backups
az postgres flexible-server backup create \
  --resource-group "hostelconnect-rg" \
  --name "hostelconnect-db" \
  --backup-name "daily-backup"
```

#### **Storage Account Backup**
```bash
# Configure storage account backup
az storage account blob-service-properties update \
  --account-name "hostelconnectstorage" \
  --resource-group "hostelconnect-rg" \
  --enable-change-feed true \
  --enable-versioning true
```

### **8. Cost Optimization**

#### **Estimated Monthly Costs (2k users)**
- **App Service B1**: $13.14/month
- **PostgreSQL Flexible Server**: $25.00/month
- **Redis Cache C1**: $15.00/month
- **Storage Account**: $5.00/month
- **Application Insights**: $10.00/month
- **Total**: ~$68.14/month

#### **Cost Optimization Tips**
1. Use **Reserved Instances** for 1-year commitment (33% savings)
2. Enable **Auto-shutdown** for non-production environments
3. Use **Spot Instances** for batch processing
4. Implement **Caching** to reduce database load
5. Use **CDN** for static assets

### **9. Deployment Commands**

#### **One-time Setup**
```bash
# Create resource group
az group create --name "hostelconnect-rg" --location "East US"

# Deploy all resources
az deployment group create \
  --resource-group "hostelconnect-rg" \
  --template-file "azure-deploy.json" \
  --parameters "azure-deploy.parameters.json"
```

#### **Manual Deployment**
```bash
# Deploy API
az webapp deployment source config-zip \
  --name "hostelconnect-api" \
  --resource-group "hostelconnect-rg" \
  --src "api-dist.zip"

# Deploy mobile app to Google Play Store
# (Use Google Play Console or Firebase App Distribution)
```

### **10. Monitoring Dashboard**

#### **Key Metrics to Monitor**
- **API Response Time**: < 200ms
- **Database Connections**: < 80% of max
- **Memory Usage**: < 70%
- **CPU Usage**: < 65%
- **Error Rate**: < 1%
- **Active Users**: Real-time count

#### **Alerts Configuration**
```json
{
  "alerts": [
    {
      "name": "High CPU Usage",
      "condition": "CPU > 80%",
      "action": "Scale out"
    },
    {
      "name": "High Error Rate",
      "condition": "Error Rate > 5%",
      "action": "Send notification"
    },
    {
      "name": "Database Connection High",
      "condition": "DB Connections > 90%",
      "action": "Scale database"
    }
  ]
}
```

### **11. Disaster Recovery**

#### **Backup Strategy**
- **Database**: Daily automated backups (7-day retention)
- **Application Code**: Git repository + Azure DevOps
- **Configuration**: Azure Key Vault
- **Static Assets**: Azure Storage with geo-replication

#### **Recovery Time Objective (RTO)**: 4 hours
#### **Recovery Point Objective (RPO)**: 1 hour

---

## 🎯 **DEPLOYMENT CHECKLIST**

- [ ] Create Azure Resource Group
- [ ] Provision App Service (Linux)
- [ ] Setup PostgreSQL Flexible Server
- [ ] Configure Redis Cache
- [ ] Create Storage Account
- [ ] Setup Application Insights
- [ ] Configure GitHub Actions
- [ ] Set environment variables
- [ ] Run database migrations
- [ ] Seed initial data
- [ ] Configure SSL certificate
- [ ] Setup monitoring alerts
- [ ] Test auto-scaling
- [ ] Verify backup configuration
- [ ] Performance testing
- [ ] Security audit
- [ ] Go live! 🚀

---

*This deployment guide supports ~2,000 concurrent users with auto-scaling capabilities.*
