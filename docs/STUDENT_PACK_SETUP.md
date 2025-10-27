# 🎓 GITHUB STUDENT PACK SETUP GUIDE

> **Free-First Education Pipeline for HostelConnect**

---

## ✅ BENEFITS USED (100% FREE)

This project is optimized for the **GitHub Student Developer Pack**:

### 🎁 Core Benefits
- ✅ **GitHub Actions** - 3,000 minutes/month free (we use ~500 min/month)
- ✅ **GitHub Pages** - Unlimited static hosting for documentation
- ✅ **GitHub Packages** - 500MB storage for artifacts
- ✅ **Codecov** - Free code coverage reports
- ✅ **Firebase** - Spark Plan (free tier - sufficient for 100+ students)

### 📦 Optional Partners (Documentation Only - Not Required)
- Railway: $5/month credit (NestJS backend hosting)
- Render: Free tier (alternative backend hosting)
- MongoDB Atlas: Free M0 cluster
- Supabase: Free PostgreSQL database
- DigitalOcean: $200 credit (production scaling)

**NOTE:** This setup works 100% with free tiers. Paid partners are documented for future scaling only.

---

## 🚀 QUICK START (5 STEPS)

### Step 1: Apply for GitHub Student Pack

1. Go to: https://education.github.com/pack
2. Click **"Get your Pack"**
3. Verify with your `.edu` email or student ID
4. Wait 1-7 days for approval
5. Check approval at: https://education.github.com/

### Step 2: Fork This Repository

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/HostelConnect.git
cd HostelConnect

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL_REPO/HostelConnect.git
```

### Step 3: Enable GitHub Actions

1. Go to your repository **Settings**
2. Navigate to **Actions** → **General**
3. Select **"Allow all actions and reusable workflows"**
4. Click **Save**

### Step 4: Add Required Secrets

Go to **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

#### Required Secrets (2 total):

| Secret Name | Value | How to Get |
|------------|-------|------------|
| `FIREBASE_SERVICE_ACCOUNT` | Base64-encoded service account JSON | See [SECRETS.md](./SECRETS.md) |
| `FIREBASE_PROJECT_ID` | Your Firebase project ID | From Firebase Console |

#### Optional Secrets (for production):

| Secret Name | Purpose |
|------------|---------|
| `ANDROID_KEYSTORE` | Signed APK/AAB builds |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_ALIAS` | Key alias |
| `ANDROID_KEY_PASSWORD` | Key password |

### Step 5: Enable GitHub Pages

1. Go to **Settings** → **Pages**
2. Source: **GitHub Actions**
3. Click **Save**
4. Your docs will be live at: `https://YOUR_USERNAME.github.io/HostelConnect/`

---

## 📁 REPOSITORY STRUCTURE

```
HostelConnect/
├── .github/
│   ├── workflows/
│   │   ├── flutter-ci.yml              # Android/iOS builds on PR
│   │   ├── firebase-functions-deploy.yml  # Deploy Cloud Functions
│   │   └── pages-site.yml              # Deploy documentation
│   └── dependabot.yml                  # Auto dependency updates
│
├── hostelconnect/
│   ├── mobile/                         # Flutter app
│   ├── api/                            # NestJS backend
│   └── functions/                      # Firebase Cloud Functions (create this)
│
├── docs/                               # GitHub Pages documentation
│   ├── STUDENT_PACK_SETUP.md          # This file
│   ├── SECRETS.md                      # Secret management guide
│   ├── CI_PIPELINES.md                 # Workflow documentation
│   ├── FIREBASE_FUNCTIONS.md           # Functions deployment
│   ├── RUNBOOK.md                      # Step-by-step deployment
│   ├── ADMIN_GUIDE.md                  # Admin operations
│   ├── MODULES.md                      # Database schemas
│   └── COST_GUARDRAILS.md              # Stay within free tier
│
├── reports/                            # Auto-generated audit reports
│   ├── ANDROID_COMPAT.md
│   ├── FEATURE_AUDIT.md
│   ├── FUNCTIONS_LIST.md
│   ├── SECURITY_AUDIT.md
│   └── INDEXES_STATUS.md
│
├── .gitignore                          # Excludes secrets, keystores
└── SECURITY_NOTE.md                    # Never commit secrets guide
```

---

## 🔄 CI/CD WORKFLOWS

### Workflow 1: Flutter CI (Runs on Pull Requests)

**Trigger:** Any PR that modifies `hostelconnect/mobile/**`

**What it does:**
1. ✅ Runs Flutter analyze
2. ✅ Runs unit tests with coverage
3. ✅ Builds Android APK (debug)
4. ✅ Builds Android AAB (release - unsigned)
5. ✅ Uploads artifacts (7-day retention)
6. ⚠️ Builds iOS (only if not a draft PR - macOS runner costs more)

**Estimated time:** 15-20 minutes  
**Cost:** FREE (3,000 min/month = ~150 builds)

### Workflow 2: Firebase Functions Deploy

**Trigger:**
- Push to `main` with changes in `functions/**`
- Manual workflow dispatch

**What it does:**
1. ✅ Decodes Firebase service account
2. ✅ Installs dependencies
3. ✅ Runs tests
4. ✅ Deploys to Firebase Functions
5. ✅ Lists deployed function names

**Estimated time:** 5-10 minutes  
**Cost:** FREE (Firebase Spark Plan)

### Workflow 3: GitHub Pages Deploy

**Trigger:** Push to `main` with changes in `docs/**`

**What it does:**
1. ✅ Builds static documentation site
2. ✅ Deploys to GitHub Pages
3. ✅ Provides deployment URL

**Estimated time:** 2-5 minutes  
**Cost:** FREE (unlimited Pages hosting)

---

## 💰 COST BREAKDOWN (FREE TIER LIMITS)

### GitHub Actions (FREE: 3,000 min/month)

| Workflow | Minutes/Run | Runs/Month | Total Minutes |
|----------|-------------|------------|---------------|
| Flutter CI | 20 min | 20 PRs | 400 min |
| Firebase Deploy | 10 min | 10 deploys | 100 min |
| Pages Deploy | 3 min | 20 pushes | 60 min |
| **TOTAL** | - | - | **560 min/month** |

**Margin:** 2,440 minutes unused ✅

### Firebase Spark Plan (FREE)

| Resource | Free Limit | Expected Usage | Status |
|----------|------------|----------------|--------|
| Firestore Reads | 50K/day | ~5K/day (100 students) | ✅ Safe |
| Firestore Writes | 20K/day | ~2K/day | ✅ Safe |
| Storage | 5GB | ~500MB | ✅ Safe |
| Functions | 2M invocations/month | ~100K/month | ✅ Safe |
| FCM Messages | Unlimited | Unlimited | ✅ Free |

### GitHub Pages (FREE: Unlimited)

- Static site hosting: **FREE**
- Custom domain support: **FREE**
- HTTPS included: **FREE**

---

## 🎯 FIRST-TIME SETUP CHECKLIST

- [ ] **1.** Applied for GitHub Student Pack (approved)
- [ ] **2.** Forked this repository
- [ ] **3.** Enabled GitHub Actions
- [ ] **4.** Created Firebase project (free Spark plan)
- [ ] **5.** Generated Firebase service account JSON
- [ ] **6.** Base64-encoded service account → added to GitHub Secrets
- [ ] **7.** Added `FIREBASE_PROJECT_ID` secret
- [ ] **8.** Enabled GitHub Pages (Source: GitHub Actions)
- [ ] **9.** Opened first PR → CI runs automatically
- [ ] **10.** Merged PR → Functions deploy + Pages publish

---

## 🆘 TROUBLESHOOTING

### "FIREBASE_SERVICE_ACCOUNT secret not set"

**Solution:**
1. Go to **Settings** → **Secrets** → **Actions**
2. Create secret named `FIREBASE_SERVICE_ACCOUNT`
3. Value: Base64-encoded service account JSON (see [SECRETS.md](./SECRETS.md))

### "Flutter analyze failed"

**Solution:**
```bash
cd hostelconnect/mobile
flutter pub get
flutter analyze --no-fatal-infos
# Fix reported issues
```

### "Workflow not running on PR"

**Solution:**
1. Check **Actions** tab → **Enable Actions**
2. Verify PR modifies files in watched paths:
   - `hostelconnect/mobile/**` for Flutter CI
   - `functions/**` for Firebase deploy
   - `docs/**` for Pages

### "GitHub Pages not deploying"

**Solution:**
1. Go to **Settings** → **Pages**
2. Source: Select **"GitHub Actions"** (not "Deploy from branch")
3. Push a change to `docs/` folder

---

## 📚 NEXT STEPS

1. ✅ **Read:** [SECRETS.md](./SECRETS.md) - How to add Firebase credentials
2. ✅ **Read:** [RUNBOOK.md](./RUNBOOK.md) - Full deployment guide
3. ✅ **Read:** [ADMIN_GUIDE.md](./ADMIN_GUIDE.md) - Admin operations
4. ✅ **Read:** [COST_GUARDRAILS.md](./COST_GUARDRAILS.md) - Stay within free tier

---

## 🎓 EDUCATION BENEFITS APPLIED FOR

This project qualifies for:

- ✅ GitHub Student Developer Pack
- ✅ Firebase Spark Plan (no credit card required)
- ✅ Codecov (free for open-source)
- ✅ Sentry (free 5K errors/month - optional)
- ✅ MongoDB Atlas M0 (free forever - optional)

**Total Cost:** $0/month for 100-500 students ✅

---

**Last Updated:** October 27, 2025  
**Maintained by:** DevOps Team  
**Support:** Open an issue for help!
