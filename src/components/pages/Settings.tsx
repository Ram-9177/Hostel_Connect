import { useState } from "react";
import { ArrowLeft, Moon, Sun, Globe, Bell, Fingerprint, Shield, HelpCircle, Info, ChevronRight } from "lucide-react";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Switch } from "../ui/switch";
import { Label } from "../ui/label";
import { Separator } from "../ui/separator";
import { Badge } from "../ui/badge";
import { toast } from "sonner@2.0.3";
import { motion } from "motion/react";

interface SettingsProps {
  onBack: () => void;
  userRole: string;
}

export function Settings({ onBack, userRole }: SettingsProps) {
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [language, setLanguage] = useState<"en" | "te">("en");
  const [biometricEnabled, setBiometricEnabled] = useState(true);
  const [notificationsEnabled, setNotificationsEnabled] = useState(true);
  const [gatePassNotif, setGatePassNotif] = useState(true);
  const [attendanceNotif, setAttendanceNotif] = useState(true);
  const [mealsNotif, setMealsNotif] = useState(false);
  const [complaintsNotif, setComplaintsNotif] = useState(true);

  const handleDarkModeToggle = () => {
    setIsDarkMode(!isDarkMode);
    toast.success(isDarkMode ? "Light mode enabled ☀️" : "Dark mode enabled 🌙");
    // In production, this would toggle the dark class on the html element
    document.documentElement.classList.toggle("dark");
  };

  const handleLanguageToggle = () => {
    const newLang = language === "en" ? "te" : "en";
    setLanguage(newLang);
    toast.success(newLang === "te" ? "తెలుగు భాష ఎంపిక చేయబడింది 🇮🇳" : "English language selected 🇬🇧");
  };

  const handleBiometricToggle = () => {
    setBiometricEnabled(!biometricEnabled);
    toast.success(biometricEnabled ? "Biometric login disabled" : "Biometric login enabled 👆");
  };

  const handleNotificationsToggle = () => {
    setNotificationsEnabled(!notificationsEnabled);
    toast.success(notificationsEnabled ? "Notifications disabled 🔕" : "Notifications enabled 🔔");
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

      <div className="px-4 -mt-4 space-y-4">
        {/* Appearance */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-purple-100 rounded-lg">
                <Sun className="h-5 w-5 text-purple-600" />
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
              <div className="p-2 bg-green-100 rounded-lg">
                <Shield className="h-5 w-5 text-green-600" />
              </div>
              <div>
                <h3 className="font-semibold">Security & Privacy</h3>
                <p className="text-sm text-muted-foreground">భద్రత</p>
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
                <Switch checked={biometricEnabled} onCheckedChange={handleBiometricToggle} />
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Notifications */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-blue-100 rounded-lg">
                <Bell className="h-5 w-5 text-blue-600" />
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
                  onCheckedChange={handleNotificationsToggle}
                />
              </div>

              {notificationsEnabled && (
                <>
                  <Separator />

                  <div className="space-y-3 ml-4">
                    {userRole === "student" && (
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
                        {userRole === "student" ? "Complaint Updates" : "New Complaints"}
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

        {/* About & Help */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
        >
          <Card className="p-5 border-0 shadow-md">
            <div className="flex items-center gap-3 mb-4">
              <div className="p-2 bg-amber-100 rounded-lg">
                <Info className="h-5 w-5 text-amber-600" />
              </div>
              <div>
                <h3 className="font-semibold">About & Help</h3>
                <p className="text-sm text-muted-foreground">సహాయం</p>
              </div>
            </div>

            <div className="space-y-3">
              <button className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-muted/50 transition-colors">
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

              <div className="p-3">
                <div className="flex items-center justify-between mb-2">
                  <p className="text-sm text-muted-foreground">App Version</p>
                  <Badge variant="outline">v1.0.0</Badge>
                </div>
                <p className="text-xs text-muted-foreground">
                  Built for hostels in Andhra Pradesh & Telangana
                </p>
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Data & Storage */}
        {userRole !== "student" && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.5 }}
          >
            <Card className="p-5 border-0 shadow-md">
              <h3 className="font-semibold mb-4">Data Management</h3>
              <div className="space-y-3">
                <Button variant="outline" className="w-full justify-start">
                  Export Data
                </Button>
                <Button variant="outline" className="w-full justify-start">
                  Clear Cache
                </Button>
              </div>
            </Card>
          </motion.div>
        )}
      </div>
    </div>
  );
}
