# HostelConnect Delta Plan - Path to 100%

## 🎯 Current Status Analysis
- **Working:** 35/41 features (85%)
- **Needs Fix:** 12 features (23%)
- **Missing:** 5 features (12%)

## 📋 Delta Items to Fix

### A) Authentication & Session (3 items)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| Session persistence | Token storage not verified | Test token persistence, silent refresh | `fix(auth): persistent session + emulator networking + null-safe parsing` |
| Silent refresh | Logic exists but untested | Verify refresh on app start/resume | Same commit |
| Null-safe parsing | User model null handling | Fix User.fromJson null safety | Same commit |

### B) Gate Pass Security (1 item)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| Interstitial ad 20s | Ad system not implemented | Implement ad requirement before QR | `feat(gate): HMAC QR + TTL + replay guard + OUT/IN verify` |

### C) Attendance System (1 item)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| Photo upload | UI exists but untested | Test camera integration | `feat(attendance): modes + manual + adjusted recompute` |

### D) Rooms & Beds (1 item)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| CSV import/export | Functionality exists but untested | Test CSV operations | `feat(rooms): structure CRUD + CSV + allot/transfer/swap/vacate + history` |

### E) Notices & Push (3 items)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| FCM push notifications | Integration needs testing | Test FCM device registration | `feat(notices): push + inbox + read receipts + offline queue` |
| Offline queue | Functionality needs testing | Test offline read queue | Same commit |
| Replay on reconnect | Mechanism needs testing | Test replay functionality | Same commit |

### F) Dashboards & Analytics (2 items)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| MV refresh ≤30s | Refresh job needs implementation | Implement background refresh | `perf(dash): MV refresh + freshness UI + drilldowns` |
| Updated HH:MM IST | Timestamp display needs testing | Test timestamp display | Same commit |

### G) Technical Infrastructure (2 items)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| Emulator networking | 10.0.2.2:3000 needs verification | Test emulator connectivity | `fix(auth): persistent session + emulator networking + null-safe parsing` |
| Rate limiting | Needs testing | Test rate limiting endpoints | `chore(security): rate-limits + pii masking + guard UX` |

### H) Ads System (5 items)
| Item | Root Cause | Fix Steps | Target Commit |
|------|------------|-----------|---------------|
| Banners ≤60px | Not implemented | Implement banner ads | `feat(ads): non-intrusive banners + interstitial polish + analytics screen` |
| Collapsible banners | Not implemented | Implement collapsible behavior | Same commit |
| Interstitial ads | Not implemented | Implement interstitial ads | Same commit |
| No nav overlap | Not implemented | Implement safe positioning | Same commit |
| Analytics tracking | Not implemented | Implement ad analytics | Same commit |

## 🎯 Implementation Priority

### Phase 1: Critical Fixes (Authentication & Infrastructure)
1. Fix Environment.dart duplicate declarations
2. Test emulator networking (10.0.2.2:3000)
3. Verify session persistence and silent refresh
4. Test null-safe parsing

### Phase 2: Core Features (Gate Pass, Attendance, Rooms)
1. Implement ad requirement for QR generation
2. Test photo upload functionality
3. Test CSV import/export operations

### Phase 3: Advanced Features (Notices, Dashboards, Ads)
1. Test FCM push notifications
2. Implement MV refresh job
3. Implement ad system with analytics

### Phase 4: Final Verification & Release
1. Update all documentation
2. Capture screenshots
3. Create release package
4. Generate final 100% report

## 📊 Success Metrics
- All 41 features marked as ✅
- Emulator running successfully
- All tests passing
- Release package created
- Documentation updated

## 🚀 Expected Outcome
**Target:** 100% feature completion (41/41 ✅)
**Timeline:** Immediate implementation
**Result:** Production-ready release package
