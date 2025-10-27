# 🔒 SECURITY NOTE - NEVER COMMIT SECRETS

> **CRITICAL:** This document explains how to handle sensitive credentials securely using GitHub Secrets.

---

## ⚠️ NEVER COMMIT THESE FILES

The following files contain sensitive credentials and **MUST NEVER** be committed to git:

### Firebase Credentials
- ❌ `google-services.json` (Android)
- ❌ `GoogleService-Info.plist` (iOS)
- ❌ `serviceAccountKey.json` (Admin SDK)
- ❌ `firebase-adminsdk-*.json` (Service Account)
- ❌ `.firebase/` directory

### Signing Keys
- ❌ `*.keystore` (Android release keystore)
- ❌ `*.jks` (Java KeyStore)
- ❌ `*.p12` (iOS distribution certificate)
- ❌ `*.p8` (APNs auth key)
- ❌ `keys/` directory

### Environment Files
- ❌ `.env` (environment variables)
- ❌ `.env.local`
- ❌ `local.properties` (Android local config)

### Play Store
- ❌ Play Console JSON key
- ❌ API credentials

---

## ✅ HOW TO SECURELY CONFIGURE GITHUB SECRETS

### Step 1: Prepare Firebase Service Account

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Navigate to: **Project Settings** → **Service accounts**
4. Click **Generate new private key**
5. Save the downloaded JSON file as `serviceAccountKey.json`
6. **DO NOT commit this file!**

### Step 2: Base64 Encode the Service Account

**On macOS/Linux:**
```bash
base64 -i serviceAccountKey.json | pbcopy
# Result is now in your clipboard
```

**On Windows (PowerShell):**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("serviceAccountKey.json")) | Set-Clipboard
```

### Step 3: Add GitHub Secrets

1. Go to your GitHub repository
2. Navigate to: **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the following secrets:

#### Required Secrets:

| Secret Name | Value | How to Get |
|------------|-------|------------|
| `FIREBASE_SERVICE_ACCOUNT` | Base64-encoded service account JSON | From Step 2 above |
| `FIREBASE_PROJECT_ID` | Your Firebase project ID (e.g., `hostelconnect-prod`) | From Firebase Console → Project Settings |

#### Optional Secrets (for production):

| Secret Name | Value | Purpose |
|------------|-------|---------|
| `ANDROID_KEYSTORE` | Base64-encoded `.jks` file | For signed Android releases |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password | Signing config |
| `ANDROID_KEY_ALIAS` | Key alias | Signing config |
| `ANDROID_KEY_PASSWORD` | Key password | Signing config |

---

## 🔧 HOW TO USE SECRETS IN WORKFLOWS

### Example: Firebase Functions Deploy

```yaml
- name: Deploy to Firebase Functions
  env:
    FIREBASE_SERVICE_ACCOUNT: ${{ secrets.FIREBASE_SERVICE_ACCOUNT }}
    FIREBASE_PROJECT_ID: ${{ secrets.FIREBASE_PROJECT_ID }}
  run: |
    echo "$FIREBASE_SERVICE_ACCOUNT" | base64 -d > serviceAccountKey.json
    firebase use $FIREBASE_PROJECT_ID
    firebase deploy --only functions --token "$(gcloud auth print-access-token)"
```

### Example: Android Release Build

```yaml
- name: Decode Keystore
  env:
    ANDROID_KEYSTORE: ${{ secrets.ANDROID_KEYSTORE }}
  run: |
    echo "$ANDROID_KEYSTORE" | base64 -d > android/app/upload-keystore.jks
```

---

## 🛡️ SECURITY BEST PRACTICES

### ✅ DO:
- Store all credentials in GitHub Secrets
- Use base64 encoding for binary files (keystores, JSON keys)
- Rotate service account keys every 90 days
- Use least-privilege IAM roles for service accounts
- Delete local copies of secrets after uploading to GitHub
- Add `.gitignore` entries before creating secret files

### ❌ DON'T:
- Commit secrets to git (even in private repos)
- Share secrets via email, Slack, or other channels
- Use production credentials in development
- Store secrets in code comments
- Leave secrets in CI logs (mask them!)

---

## 🔍 HOW TO CHECK IF SECRETS WERE LEAKED

### Scan git history:
```bash
# Check for common secret patterns
git log -p | grep -E "AIza|ya29|sk_live|sk_test|serviceAccount"

# Check for JSON keys
git log -p | grep -E "private_key|client_email"
```

### Use GitHub Secret Scanning:
1. Go to **Settings** → **Code security and analysis**
2. Enable **Secret scanning**
3. Enable **Push protection**

---

## 🚨 IF YOU ACCIDENTALLY COMMIT A SECRET

### Immediate Actions:

1. **Revoke the compromised credential** immediately:
   - Firebase: Generate new service account key, delete old one
   - Keystore: Generate new keystore for future releases
   - API keys: Rotate the key in the provider's dashboard

2. **Remove from git history:**
```bash
# Use BFG Repo-Cleaner (recommended)
bfg --delete-files serviceAccountKey.json
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Or use git-filter-repo
git filter-repo --invert-paths --path serviceAccountKey.json
```

3. **Force push** (⚠️ breaks others' clones):
```bash
git push --force-with-lease origin main
```

4. **Notify your team** that they need to re-clone the repo

---

## 📚 REFERENCES

- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Firebase Admin SDK Setup](https://firebase.google.com/docs/admin/setup)
- [Android App Signing](https://developer.android.com/studio/publish/app-signing)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)

---

**Last Updated:** October 27, 2025  
**Maintained by:** DevOps Team
