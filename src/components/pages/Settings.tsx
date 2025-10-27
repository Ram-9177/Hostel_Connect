import { useState } from "react";
import { 
  ArrowLeft, Moon, Sun, Globe, Bell, Fingerprint, Shield, HelpCircle, 
  Info, ChevronRight, User, Lock, Trash2, Database, LogOut, Key, 
  FileText, Scale, Mail, Phone, MapPin, Calendar, Camera, Edit2, 
  Download, AlertTriangle
} from "lucide-react";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Switch } from "../ui/switch";
import { Label } from "../ui/label";
import { Separator } from "../ui/separator";
import { Badge } from "../ui/badge";
import { motion } from "motion/react";
import { Input } from "../ui/input";

interface SettingsProps {
  onBack: () => void;
  userRole: string;
  onNavigate?: (page: string) => void;
  onLogout?: () => void;
}

export function Settings({ onBack, userRole, onNavigate, onLogout }: SettingsProps) {
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [language, setLanguage] = useState<"en" | "te">("en");
  const [biometricEnabled, setBiometricEnabled] = useState(true);
  const [notificationsEnabled, setNotificationsEnabled] = useState(true);
  const [gatePassNotif, setGatePassNotif] = useState(true);
  const [attendanceNotif, setAttendanceNotif] = useState(true);
  const [mealsNotif, setMealsNotif] = useState(false);
  const [complaintsNotif, setComplaintsNotif] = useState(true);
  const [dataSharing, setDataSharing] = useState(true);
  const [analytics, setAnalytics] = useState(true);
  const [showChangePassword, setShowChangePassword] = useState(false);
  const [oldPassword, setOldPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  // Mock user data - in production, this would come from AuthContext/API
  const userData = {
    name: userRole === "STUDENT" ? "John Student" : 
          userRole === "WARDEN" ? "Jane Warden" :
          userRole === "WARDEN_HEAD" ? "Head Warden" :
          userRole === "ADMIN" ? "Super Admin" :
          userRole === "CHEF" ? "Chef Kumar" : "Security Officer",
    email: `${userRole.toLowerCase()}@hostelconnect.com`,
    phone: "+91 98765 43210",
    studentId: userRole === "STUDENT" ? "STU2024001" : undefined,
    hostel: "Phoenix Hall",
    room: userRole === "STUDENT" ? "101" : undefined,
    joinDate: "January 2024"
  };

  const handleDarkModeToggle = () => {
    setIsDarkMode(!isDarkMode);
    document.documentElement.classList.toggle("dark");
  };

  const handleLanguageToggle = () => {
    const newLang = language === "en" ? "te" : "en";
    setLanguage(newLang);
  };

  const handleChangePassword = () => {
    if (!oldPassword || !newPassword || !confirmPassword) {
      alert("Please fill all password fields");
      return;
    }
    if (newPassword !== confirmPassword) {
      alert("New passwords don't match");
      return;
    }
    if (newPassword.length < 6) {
      alert("Password must be at least 6 characters");
      return;
    }
    alert("Password changed successfully!");
    setShowChangePassword(false);
    setOldPassword("");
    setNewPassword("");
    setConfirmPassword("");
  };

  const handleClearCache = () => {
    if (window.confirm("Clear cache? This will free up storage space.")) {
      localStorage.clear();
      alert("Cache cleared successfully! (12.5 MB freed)");
    }
  };

  const handleClearData = () => {
    if (window.confirm("⚠️ This will delete ALL offline data and logout. Continue?")) {
      localStorage.clear();
      sessionStorage.clear();
      alert("All data cleared. Logging out...");
      onLogout?.();
    }
  };

  const handleLogout = () => {
    if (window.confirm("Are you sure you want to logout?")) {
      onLogout?.();
    }
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Header */}
      <div className="bg-gradient-to-br from-primary to-secondary text-white p-6 pb-8">
        <div className="flex items-center gap-4 mb-6">
          <Button
            onClick={onBack}
            variant="ghost"
            size="icon"
            className="text-white hover:bg-white/20 rounded-full"
          >
            <ArrowLeft className="h-5 w-5" />
          </Button>
          <div className="flex-1">
            <h1 className="text-2xl font-bold">Settings</h1>
            <p className="text-sm text-white/80">సెట్టింగ్స్</p>
          </div>
        </div>
      </div>

      <div className="px-4 -mt-4 space-y-4 pb-8">
        {/* User Profile Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.05 }}
        >
          <Card className="p-5 border-0 shadow-lg bg-gradient-to-br from-white to-gray-50 dark:from-gray-800 dark:to-gray-900">
            <div className="flex items-center gap-4">
              <div className="relative">
                <div className="w-16 h-16 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white text-2xl font-bold">
                  {userData.name.charAt(0)}
                </div>
                <button className="absolute bottom-0 right-0 w-6 h-6 bg-white dark:bg-gray-800 rounded-full flex items-center justify-center shadow-md border-2 border-primary">
                  <Camera className="h-3 w-3 text-primary" />
                </button>
              </div>
              <div className="flex-1">
                <h2 className="text-lg font-bold">{userData.name}</h2>
                <div className="flex items-center gap-2 mt-1">
                  <Badge variant="secondary" className="text-xs">
                    {userRole}
                  </Badge>
                  {userData.studentId && (
                    <Badge variant="outline" className="text-xs">
                      {userData.studentId}
                    </Badge>
                  )}
                </div>
              </div>
              <Button variant="ghost" size="icon" onClick={() => onNavigate?.("profile")}>
                <Edit2 className="h-4 w-4" />
              </Button>
            </div>

            <Separator className="my-4" />

            <div className="space-y-2 text-sm">
              <div className="flex items-center gap-2 text-muted-foreground">
                <Mail className="h-4 w-4" />
                <span>{userData.email}</span>
              </div>
              <div className="flex items-center gap-2 text-muted-foreground">
                <Phone className="h-4 w-4" />
                <span>{userData.phone}</span>
              </div>
              <div className="flex items-center gap-2 text-muted-foreground">
                <MapPin className="h-4 w-4" />
                <span>{userData.hostel}{userData.room && ` • Room ${userData.room}`}</span>
              </div>
              <div className="flex items-center gap-2 text-muted-foreground">
                <Calendar className="h-4 w-4" />
                <span>Joined {userData.joinDate}</span>
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Account Management */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-indigo-100 dark:bg-indigo-900/30 rounded-lg">
                <User className="h-5 w-5 text-indigo-600 dark:text-indigo-400" />
              </div>
              <div>
                <h3 className="font-semibold">Account Management</h3>
                <p className="text-sm text-muted-foreground">ఖాతా నిర్వహణ</p>
              </div>
            </div>

            <div className="space-y-3">
              <button
                onClick={() => setShowChangePassword(!showChangePassword)}
                className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Key className="h-5 w-5 text-muted-foreground" />
                  <div className="text-left">
                    <p className="text-sm font-medium">Change Password</p>
                    <p className="text-xs text-muted-foreground">పాస్‌వర్డ్ మార్చండి</p>
                  </div>
                </div>
                <ChevronRight className={`h-5 w-5 text-muted-foreground transition-transform ${showChangePassword ? "rotate-90" : ""}`} />
              </button>

              {showChangePassword && (
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: "auto" }}
                  exit={{ opacity: 0, height: 0 }}
                  className="pl-11 pr-3 pb-3 space-y-3"
                >
                  <div>
                    <Label htmlFor="old-password">Current Password</Label>
                    <Input
                      id="old-password"
                      type="password"
                      value={oldPassword}
                      onChange={(e) => setOldPassword(e.target.value)}
                      placeholder="Enter current password"
                      className="mt-1"
                    />
                  </div>
                  <div>
                    <Label htmlFor="new-password">New Password</Label>
                    <Input
                      id="new-password"
                      type="password"
                      value={newPassword}
                      onChange={(e) => setNewPassword(e.target.value)}
                      placeholder="Enter new password"
                      className="mt-1"
                    />
                  </div>
                  <div>
                    <Label htmlFor="confirm-password">Confirm Password</Label>
                    <Input
                      id="confirm-password"
                      type="password"
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      placeholder="Re-enter new password"
                      className="mt-1"
                    />
                  </div>
                  <div className="flex gap-2 pt-2">
                    <Button onClick={handleChangePassword} size="sm" className="flex-1">
                      Update Password
                    </Button>
                    <Button 
                      onClick={() => {
                        setShowChangePassword(false);
                        setOldPassword("");
                        setNewPassword("");
                        setConfirmPassword("");
                      }} 
                      variant="outline" 
                      size="sm"
                    >
                      Cancel
                    </Button>
                  </div>
                </motion.div>
              )}

              <Separator />

              <button
                onClick={() => onNavigate?.("id-card")}
                className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <FileText className="h-5 w-5 text-muted-foreground" />
                  <div className="text-left">
                    <p className="text-sm font-medium">Digital ID Card</p>
                    <p className="text-xs text-muted-foreground">డిజిటల్ గుర్తింపు కార్డు</p>
                  </div>
                </div>
                <ChevronRight className="h-5 w-5 text-muted-foreground" />
              </button>
            </div>
          </Card>
        </motion.div>

        {/* Appearance */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-purple-100 dark:bg-purple-900/30 rounded-lg">
                <Sun className="h-5 w-5 text-purple-600 dark:text-purple-400" />
              </div>
              <div>
                <h3 className="font-semibold">Appearance</h3>
                <p className="text-sm text-muted-foreground">రూపం</p>
              </div>
            </div>

            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  {isDarkMode ? (
                    <Moon className="h-5 w-5 text-muted-foreground" />
                  ) : (
                    <Sun className="h-5 w-5 text-muted-foreground" />
                  )}
                  <div>
                    <Label>Dark Mode</Label>
                    <p className="text-xs text-muted-foreground">డార్క్ మోడ్</p>
                  </div>
                </div>
                <Switch checked={isDarkMode} onCheckedChange={handleDarkModeToggle} />
              </div>

              <Separator />

              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Globe className="h-5 w-5 text-muted-foreground" />
                  <div>
                    <Label>Language</Label>
                    <p className="text-xs text-muted-foreground">
                      {language === "en" ? "English" : "తెలుగు"}
                    </p>
                  </div>
                </div>
                <Button
                  onClick={handleLanguageToggle}
                  variant="outline"
                  size="sm"
                  className="min-w-[80px]"
                >
                  {language === "en" ? "తెలుగు" : "English"}
                </Button>
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Security & Privacy */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-green-100 dark:bg-green-900/30 rounded-lg">
                <Shield className="h-5 w-5 text-green-600 dark:text-green-400" />
              </div>
              <div>
                <h3 className="font-semibold">Security & Privacy</h3>
                <p className="text-sm text-muted-foreground">భద్రత & గోప్యత</p>
              </div>
            </div>

            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Fingerprint className="h-5 w-5 text-muted-foreground" />
                  <div>
                    <Label>Biometric Login</Label>
                    <p className="text-xs text-muted-foreground">ఫింగర్‌ప్రింట్ లాగిన్</p>
                  </div>
                </div>
                <Switch checked={biometricEnabled} onCheckedChange={setBiometricEnabled} />
              </div>

              <Separator />

              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Shield className="h-5 w-5 text-muted-foreground" />
                  <div>
                    <Label>Share Usage Data</Label>
                    <p className="text-xs text-muted-foreground">Help improve the app</p>
                  </div>
                </div>
                <Switch checked={dataSharing} onCheckedChange={setDataSharing} />
              </div>

              <Separator />

              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <Database className="h-5 w-5 text-muted-foreground" />
                  <div>
                    <Label>Analytics</Label>
                    <p className="text-xs text-muted-foreground">Anonymous usage stats</p>
                  </div>
                </div>
                <Switch checked={analytics} onCheckedChange={setAnalytics} />
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Notifications */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.25 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-blue-100 dark:bg-blue-900/30 rounded-lg">
                <Bell className="h-5 w-5 text-blue-600 dark:text-blue-400" />
              </div>
              <div>
                <h3 className="font-semibold">Notifications</h3>
                <p className="text-sm text-muted-foreground">నోటిఫికేషన్లు</p>
              </div>
            </div>

            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <Label>Enable All Notifications</Label>
                  <p className="text-xs text-muted-foreground">అన్ని నోటిఫికేషన్లు</p>
                </div>
                <Switch
                  checked={notificationsEnabled}
                  onCheckedChange={setNotificationsEnabled}
                />
              </div>

              {notificationsEnabled && (
                <>
                  <Separator />

                  <div className="space-y-3 ml-4">
                    {userRole === "STUDENT" && (
                      <>
                        <div className="flex items-center justify-between">
                          <Label className="text-sm">Gate Pass Updates</Label>
                          <Switch
                            checked={gatePassNotif}
                            onCheckedChange={setGatePassNotif}
                          />
                        </div>

                        <div className="flex items-center justify-between">
                          <Label className="text-sm">Attendance Reminders</Label>
                          <Switch
                            checked={attendanceNotif}
                            onCheckedChange={setAttendanceNotif}
                          />
                        </div>

                        <div className="flex items-center justify-between">
                          <Label className="text-sm">Meal Updates</Label>
                          <Switch checked={mealsNotif} onCheckedChange={setMealsNotif} />
                        </div>
                      </>
                    )}

                    <div className="flex items-center justify-between">
                      <Label className="text-sm">
                        {userRole === "STUDENT" ? "Complaint Updates" : "New Complaints"}
                      </Label>
                      <Switch
                        checked={complaintsNotif}
                        onCheckedChange={setComplaintsNotif}
                      />
                    </div>
                  </div>
                </>
              )}
            </div>
          </Card>
        </motion.div>

        {/* Data & Storage */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-orange-100 dark:bg-orange-900/30 rounded-lg">
                <Database className="h-5 w-5 text-orange-600 dark:text-orange-400" />
              </div>
              <div className="flex-1">
                <h3 className="font-semibold">Data & Storage</h3>
                <p className="text-sm text-muted-foreground">డేటా & నిల్వ</p>
              </div>
              <Badge variant="secondary">12.5 MB</Badge>
            </div>

            <div className="space-y-3">
              {userRole !== "STUDENT" && (
                <>
                  <Button 
                    variant="outline" 
                    className="w-full justify-start gap-3"
                    onClick={() => alert("Export feature coming soon!")}
                  >
                    <Download className="h-4 w-4" />
                    Export Data
                  </Button>
                  <Separator />
                </>
              )}

              <Button 
                variant="outline" 
                className="w-full justify-start gap-3"
                onClick={handleClearCache}
              >
                <Trash2 className="h-4 w-4" />
                Clear Cache
              </Button>

              <Button 
                variant="outline" 
                className="w-full justify-start gap-3 text-destructive hover:text-destructive"
                onClick={handleClearData}
              >
                <AlertTriangle className="h-4 w-4" />
                Clear All Data
              </Button>
            </div>
          </Card>
        </motion.div>

        {/* About & Help */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.35 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-amber-100 dark:bg-amber-900/30 rounded-lg">
                <Info className="h-5 w-5 text-amber-600 dark:text-amber-400" />
              </div>
              <div>
                <h3 className="font-semibold">About & Help</h3>
                <p className="text-sm text-muted-foreground">సహాయం</p>
              </div>
            </div>

            <div className="space-y-3">
              <button 
                onClick={() => onNavigate?.("help-center")}
                className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <HelpCircle className="h-5 w-5 text-muted-foreground" />
                  <div className="text-left">
                    <p className="text-sm font-medium">Help & FAQs</p>
                    <p className="text-xs text-muted-foreground">సహాయం & ప్రశ్నలు</p>
                  </div>
                </div>
                <ChevronRight className="h-5 w-5 text-muted-foreground" />
              </button>

              <Separator />

              <button 
                onClick={() => alert("Privacy Policy: We value your privacy and protect your data...")}
                className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Shield className="h-5 w-5 text-muted-foreground" />
                  <div className="text-left">
                    <p className="text-sm font-medium">Privacy Policy</p>
                    <p className="text-xs text-muted-foreground">గోప్యతా విధానం</p>
                  </div>
                </div>
                <ChevronRight className="h-5 w-5 text-muted-foreground" />
              </button>

              <Separator />

              <button 
                onClick={() => alert("Terms of Service: By using this app, you agree to...")}
                className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Scale className="h-5 w-5 text-muted-foreground" />
                  <div className="text-left">
                    <p className="text-sm font-medium">Terms of Service</p>
                    <p className="text-xs text-muted-foreground">సేవా నియమాలు</p>
                  </div>
                </div>
                <ChevronRight className="h-5 w-5 text-muted-foreground" />
              </button>

              <Separator />

              <div className="p-3 bg-muted/30 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <p className="text-sm text-muted-foreground">App Version</p>
                  <Badge variant="outline">v1.0.0</Badge>
                </div>
                <p className="text-xs text-muted-foreground">
                  Built for hostels in Andhra Pradesh & Telangana 🇮🇳
                </p>
                <p className="text-xs text-muted-foreground mt-1">
                  Last updated: October 27, 2025
                </p>
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Logout Button */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
        >
          <Button
            onClick={handleLogout}
            variant="destructive"
            className="w-full gap-2 shadow-lg"
            size="lg"
          >
            <LogOut className="h-5 w-5" />
            Logout
          </Button>
        </motion.div>
      </div>
    </div>
  );
}
