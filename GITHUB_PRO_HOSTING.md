# GitHub Pages Deployment Configuration

## 🚀 Deploy HostelConnect to GitHub Pages

### Step 1: Update Vite Configuration

```typescript
// vite.config.ts
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  base: '/hostelconnect/', // Replace 'hostelconnect' with your repo name
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.json'],
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  build: {
    target: 'esnext',
    outDir: 'dist',
  },
  server: {
    port: 5500,
    open: true,
  },
});
```

### Step 2: Update API Configuration

```typescript
// src/services/api.ts
const API_BASE_URL = process.env.NODE_ENV === 'production' 
  ? 'https://your-api-domain.com/api/v1'  // Your production API
  : 'http://localhost:3007/api/v1';       // Local development

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  studentId?: string;
  hostelId?: string;
  roomId?: string;
  phone?: string;
  isActive: boolean;
  lastLogin?: Date;
  createdAt: Date;
}
```

### Step 3: Create GitHub Actions Workflow

```yaml
# .github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4
      
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Build
      run: npm run build
      
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      if: github.ref == 'refs/heads/main'
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./dist
```

### Step 4: Update Package.json Scripts

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "deploy": "npm run build && gh-pages -d dist",
    "predeploy": "npm run build"
  },
  "devDependencies": {
    "gh-pages": "^6.0.0"
  }
}
```

### Step 5: Enable GitHub Pages

1. Go to your repository **Settings**
2. Scroll to **Pages** section
3. Source: **GitHub Actions**
4. Your app will be available at: `https://yourusername.github.io/hostelconnect`

---

## 🌐 Option 2: Vercel (Recommended for Full-Stack)

### Step 1: Connect to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel --prod
```

### Step 2: Vercel Configuration

```json
// vercel.json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
  "env": {
    "VITE_API_BASE_URL": "https://your-api-domain.com/api/v1"
  }
}
```

---

## 🔧 Option 3: Netlify (Alternative)

### Step 1: Netlify Configuration

```toml
# netlify.toml
[build]
  publish = "dist"
  command = "npm run build"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[build.environment]
  NODE_VERSION = "18"
```

### Step 2: Deploy to Netlify

```bash
# Install Netlify CLI
npm i -g netlify-cli

# Login
netlify login

# Deploy
netlify deploy --prod --dir=dist
```

---

## 🎯 **RECOMMENDED APPROACH**

### **For Quick Setup (GitHub Pages):**

1. **Update your repository settings**
2. **Enable GitHub Pages**
3. **Push your code**
4. **Your app goes live automatically**

### **For Production (Vercel + Custom Domain):**

1. **Deploy to Vercel**
2. **Configure custom domain**
3. **Set up production API**
4. **Enable SSL/HTTPS**

---

## 🚀 **IMMEDIATE STEPS**

### **Step 1: Prepare for Deployment**

```bash
# Update vite.config.ts with correct base path
# Update API configuration for production
# Create GitHub Actions workflow
```

### **Step 2: Deploy**

```bash
# Push to main branch
git add .
git commit -m "Prepare for GitHub Pages deployment"
git push origin main
```

### **Step 3: Configure GitHub Pages**

1. Go to **Settings** → **Pages**
2. Source: **GitHub Actions**
3. Your app will be live at: `https://yourusername.github.io/hostelconnect`

---

## 🌐 **Custom Domain Setup**

### **With GitHub Pages:**

1. **Add CNAME file** to your repository
2. **Configure DNS** with your domain provider
3. **Enable HTTPS** in GitHub Pages settings

### **With Vercel:**

1. **Add domain** in Vercel dashboard
2. **Update DNS** records
3. **SSL automatically enabled**

---

## 📱 **Mobile App Deployment**

### **Play Store:**

```bash
# Build Flutter app
cd hostelconnect/mobile
flutter build appbundle --release

# Upload to Play Console
# Follow Google Play Console instructions
```

### **App Store:**

```bash
# Build iOS app
flutter build ios --release

# Upload to App Store Connect
# Follow Apple Developer instructions
```

---

## 🔒 **Security & Production**

### **Environment Variables:**

```env
# Production environment
VITE_API_BASE_URL=https://api.hostelconnect.app
VITE_APP_NAME=HostelConnect
VITE_APP_VERSION=1.0.0
```

### **API Security:**

- Enable HTTPS
- Configure CORS
- Set up rate limiting
- Add authentication middleware

---

## 🎉 **Your App Will Be Live At:**

- **GitHub Pages**: `https://yourusername.github.io/hostelconnect`
- **Vercel**: `https://hostelconnect.vercel.app`
- **Custom Domain**: `https://hostelconnect.app`

**Ready to go live? Let's start with GitHub Pages!**
