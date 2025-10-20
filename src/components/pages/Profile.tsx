import { ArrowLeft, User, Mail, Phone, MapPin, Moon, Sun, LogOut, Edit, Calendar, Utensils, Bell, Users, Home, Shield, ChevronRight, AlertCircle, CheckCircle2, Clock, Settings as SettingsIcon } from "lucide-react";
import { Card } from "../ui/card";
import { Button } from "../ui/button";
import { Switch } from "../ui/switch";
import { Badge } from "../ui/badge";
import { Progress } from "../ui/progress";
import { Separator } from "../ui/separator";
import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "motion/react";
import { UpdatedTime } from "../UpdatedTime";
import { LoadingState } from "../LoadingState";
import { toast } from "sonner@2.0.3";

interface ProfileProps {
  onBack: () => void;
  onLogout: () => void;
  onNavigate?: (page: string) => void;
}

export function Profile({ onBack, onLogout, onNavigate }: ProfileProps) {
  const [darkMode, setDarkMode] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [notificationsEnabled, setNotificationsEnabled] = useState(true);
  const [selectedSection, setSelectedSection] = useState<string | null>(null);

  // Simulate data loading
  useEffect(() => {
    const timer = setTimeout(() => setIsLoading(false), 800);
    return () => clearTimeout(timer);
  }, []);

  const studentData = {
    name: "Venkat Reddy",
    firstName: "Venkat",
    lastName: "Reddy",
    nameTe: "వెంకట్ రెడ్డి",
    rollNumber: "21CS045",
    email: "venkat.reddy@university.edu.in",
    phone: "+91 98765 43210",
    phoneFormatted: "+91 98765-43210",
    hostel: "Annapurna Boys Hostel",
    hostelTe: "అన్నపూర్ణ బాయ్స్ హాస్టల్",
    room: "205",
    floor: "2nd Floor",
    block: "A Block",
    joinDate: "Jan 15, 2024",
    diet: "Pure Vegetarian",
    dietTe: "పూర్తి శాకాహారం",
    bloodGroup: "B+",
    guardianName: "Ramesh Reddy (Father)",
    guardianPhone: "+91 98760 12345",
    emergencyContact: "+91 98760 12345",
    localAddress: "Vijayawada, Andhra Pradesh",
    profileCompletion: 85,
  };

  const stats = [
    { label: "Attendance", value: "85%", color: "text-green-600", icon: CheckCircle2 },
    { label: "Gate Passes", value: "12", color: "text-blue-600", icon: Clock },
    { label: "Complaints", value: "3", color: "text-amber-600", icon: AlertCircle },
    { label: "Meal Opt-in", value: "96%", color: "text-green-600", icon: Utensils },
  ];

  // Recent notifications/announcements
  const recentNotifications = [
    {
      id: 1,
      title: "Mess Menu Updated",
      message: "New South Indian items added",
      time: "2 hours ago",
      type: "info",
      unread: true,
    },
    {
      id: 2,
      title: "Gate Pass Approved",
      message: "Your weekend pass is ready",
      time: "5 hours ago",
      type: "success",
      unread: true,
    },
    {
      id: 3,
      title: "Room Inspection",
      message: "Scheduled for Friday at 2 PM",
      time: "1 day ago",
      type: "warning",
      unread: false,
    },
  ];

  const handleEditProfile = () => {
    toast.success("Profile edit mode", {
      description: "Profile editing will be available soon",
    });
  };

  const handleToggleNotifications = (enabled: boolean) => {
    setNotificationsEnabled(enabled);
    toast.success(enabled ? "Notifications enabled 🔔" : "Notifications disabled 🔕");
  };

  if (isLoading) {
    return <LoadingState message="Loading your profile..." />;
  }

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Enhanced Header with Notifications */}
      <div className="bg-gradient-to-r from-purple-600 via-purple-600 to-purple-700 text-white p-5 shadow-lg relative overflow-hidden">
        <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-16 translate-x-16" />
        <div className="absolute bottom-0 left-0 w-24 h-24 bg-white/5 rounded-full translate-y-12 -translate-x-12" />
        
        <div className="relative flex items-center justify-between">
          <div className="flex items-center gap-3">
            <motion.button 
              onClick={onBack} 
              className="p-2 bg-white/20 rounded-xl hover:bg-white/30 transition-colors min-w-[44px] min-h-[44px] flex items-center justify-center"
              whileTap={{ scale: 0.9 }}
            >
              <ArrowLeft className="h-5 w-5" />
            </motion.button>
            <div>
              <h1 className="mb-1">My Profile</h1>
              <p className="text-xs opacity-90">మీ వ్యక్తిగత సమాచారం</p>
            </div>
          </div>
          
          {/* Notification Bell */}
          <motion.button 
            className="relative p-2 bg-white/20 rounded-xl hover:bg-white/30 transition-colors min-w-[44px] min-h-[44px] flex items-center justify-center"
            whileTap={{ scale: 0.9 }}
            onClick={() => setSelectedSection(selectedSection === "notifications" ? null : "notifications")}
          >
            <Bell className="h-5 w-5" />
            {recentNotifications.filter(n => n.unread).length > 0 && (
              <span className="absolute top-1 right-1 w-2 h-2 bg-accent rounded-full animate-pulse" />
            )}
          </motion.button>
        </div>
      </div>

      <div className="p-4 space-y-4">
        {/* Notifications Panel - Expandable */}
        <AnimatePresence>
          {selectedSection === "notifications" && (
            <motion.div
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: "auto" }}
              exit={{ opacity: 0, height: 0 }}
              transition={{ duration: 0.3 }}
            >
              <Card className="p-4 border-0 shadow-lg overflow-hidden">
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center gap-2">
                    <Bell className="h-5 w-5 text-primary" />
                    <h3>Notifications</h3>
                    {recentNotifications.filter(n => n.unread).length > 0 && (
                      <Badge className="bg-accent text-accent-foreground">
                        {recentNotifications.filter(n => n.unread).length} new
                      </Badge>
                    )}
                  </div>
                  <UpdatedTime />
                </div>

                <div className="space-y-2">
                  {recentNotifications.map((notification) => (
                    <motion.div
                      key={notification.id}
                      initial={{ x: -20, opacity: 0 }}
                      animate={{ x: 0, opacity: 1 }}
                      className={`p-3 rounded-xl border transition-all ${
                        notification.unread 
                          ? "bg-primary/5 border-primary/20" 
                          : "bg-muted/30 border-transparent"
                      }`}
                    >
                      <div className="flex items-start gap-3">
                        <div className={`p-1.5 rounded-lg ${
                          notification.type === "success" ? "bg-green-100 text-green-600" :
                          notification.type === "warning" ? "bg-amber-100 text-amber-600" :
                          "bg-blue-100 text-blue-600"
                        }`}>
                          {notification.type === "success" ? <CheckCircle2 className="h-3.5 w-3.5" /> :
                           notification.type === "warning" ? <AlertCircle className="h-3.5 w-3.5" /> :
                           <Bell className="h-3.5 w-3.5" />}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-start justify-between gap-2">
                            <p className="text-sm font-medium">{notification.title}</p>
                            {notification.unread && (
                              <div className="w-2 h-2 bg-primary rounded-full flex-shrink-0 mt-1.5" />
                            )}
                          </div>
                          <p className="text-xs text-muted-foreground mt-0.5">{notification.message}</p>
                          <p className="text-xs text-muted-foreground mt-1">{notification.time}</p>
                        </div>
                      </div>
                    </motion.div>
                  ))}
                </div>

                <Button 
                  variant="ghost" 
                  size="sm" 
                  className="w-full mt-3"
                  onClick={() => setSelectedSection(null)}
                >
                  View All Notifications
                  <ChevronRight className="h-4 w-4 ml-1" />
                </Button>
              </Card>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Profile Completion */}
        <Card className="p-4 border-0 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <p className="text-sm">Profile Completion</p>
            <p className="text-sm font-medium text-primary">{studentData.profileCompletion}%</p>
          </div>
          <Progress value={studentData.profileCompletion} className="h-2" />
          {studentData.profileCompletion < 100 && (
            <p className="text-xs text-muted-foreground mt-2">
              Add emergency contact to complete your profile
            </p>
          )}
        </Card>

        {/* Enhanced Profile Card */}
        <Card className="p-6 border-0 shadow-lg bg-gradient-to-br from-card to-muted/10">
          <div className="flex items-start justify-between mb-6">
            <div className="flex items-center gap-4">
              <div className="w-20 h-20 bg-gradient-to-br from-purple-600 to-purple-700 rounded-2xl flex items-center justify-center shadow-lg ring-4 ring-purple-100">
                <User className="h-10 w-10 text-white" />
              </div>
              <div>
                <h2 className="mb-0.5">{studentData.name}</h2>
                <p className="text-sm text-muted-foreground/80 mb-2">{studentData.nameTe}</p>
                <div className="flex items-center gap-2">
                  <Badge variant="secondary" className="text-xs">
                    {studentData.rollNumber}
                  </Badge>
                  <Badge className="text-xs bg-green-100 text-green-700 border-green-200">
                    Active ✓
                  </Badge>
                </div>
              </div>
            </div>
            <motion.div whileTap={{ scale: 0.95 }}>
              <Button 
                variant="outline" 
                size="sm" 
                className="gap-2 min-h-[44px]"
                onClick={handleEditProfile}
              >
                <Edit className="h-4 w-4" />
                Edit
              </Button>
            </motion.div>
          </div>

          {/* Contact Information Section */}
          <div>
            <h4 className="text-sm text-muted-foreground mb-3">Contact Information</h4>
            <div className="space-y-3">
              <motion.div 
                className="flex items-center gap-3 p-3 bg-muted/30 rounded-xl"
                whileTap={{ scale: 0.98 }}
              >
                <Mail className="h-5 w-5 text-primary flex-shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-xs text-muted-foreground">Email</p>
                  <p className="text-sm truncate">{studentData.email}</p>
                </div>
              </motion.div>

              <motion.div 
                className="flex items-center gap-3 p-3 bg-muted/30 rounded-xl"
                whileTap={{ scale: 0.98 }}
              >
                <Phone className="h-5 w-5 text-green-600 flex-shrink-0" />
                <div className="flex-1">
                  <p className="text-xs text-muted-foreground">Mobile</p>
                  <p className="text-sm">{studentData.phoneFormatted}</p>
                </div>
              </motion.div>

              <motion.div 
                className="flex items-center gap-3 p-3 bg-muted/30 rounded-xl"
                whileTap={{ scale: 0.98 }}
              >
                <MapPin className="h-5 w-5 text-amber-600 flex-shrink-0" />
                <div className="flex-1">
                  <p className="text-xs text-muted-foreground">Hostel Location</p>
                  <p className="text-sm">{studentData.hostel}</p>
                  <p className="text-xs text-muted-foreground mt-0.5">
                    {studentData.block}, Room {studentData.room} • {studentData.floor}
                  </p>
                </div>
              </motion.div>
            </div>
          </div>

          <Separator className="my-4" />

          {/* Additional Details */}
          <div>
            <h4 className="text-sm text-muted-foreground mb-3">Additional Details</h4>
            <div className="grid grid-cols-2 gap-3">
              <div className="p-3 bg-muted/30 rounded-xl">
                <div className="flex items-center gap-2 mb-1">
                  <Calendar className="h-4 w-4 text-blue-600" />
                  <p className="text-xs text-muted-foreground">Joined</p>
                </div>
                <p className="text-sm font-medium">{studentData.joinDate}</p>
              </div>
              
              <div className="p-3 bg-muted/30 rounded-xl">
                <div className="flex items-center gap-2 mb-1">
                  <Shield className="h-4 w-4 text-red-600" />
                  <p className="text-xs text-muted-foreground">Blood Group</p>
                </div>
                <p className="text-sm font-medium">{studentData.bloodGroup}</p>
              </div>

              <div className="p-3 bg-muted/30 rounded-xl col-span-2">
                <div className="flex items-center gap-2 mb-1">
                  <Utensils className="h-4 w-4 text-green-600" />
                  <p className="text-xs text-muted-foreground">Diet Preference</p>
                </div>
                <p className="text-sm font-medium">{studentData.diet}</p>
                <p className="text-xs text-muted-foreground mt-0.5">{studentData.dietTe}</p>
              </div>

              <div className="p-3 bg-muted/30 rounded-xl col-span-2">
                <div className="flex items-center gap-2 mb-1">
                  <Home className="h-4 w-4 text-purple-600" />
                  <p className="text-xs text-muted-foreground">Home Location</p>
                </div>
                <p className="text-sm font-medium">{studentData.localAddress}</p>
              </div>
            </div>
          </div>
        </Card>

        {/* Emergency Contact Card */}
        <Card className="p-5 border-0 shadow-sm bg-red-50/50 border-red-100">
          <div className="flex items-start gap-3">
            <div className="p-2 bg-red-100 rounded-lg">
              <Shield className="h-5 w-5 text-red-600" />
            </div>
            <div className="flex-1">
              <h4 className="text-red-900 mb-1">Emergency Contact</h4>
              <p className="text-xs text-red-700/70 mb-3">
                Contact in case of emergency • ఎమర్జెన్సీ సందర్భంలో సంప్రదించండి
              </p>
              
              <div className="space-y-2">
                <div className="flex items-center gap-2">
                  <Users className="h-4 w-4 text-red-600" />
                  <p className="text-sm text-red-900 font-medium">{studentData.guardianName}</p>
                </div>
                <div className="flex items-center gap-2">
                  <Phone className="h-4 w-4 text-red-600" />
                  <p className="text-sm text-red-900">{studentData.guardianPhone}</p>
                </div>
              </div>
            </div>
            <Button 
              variant="ghost" 
              size="sm"
              className="text-red-600 hover:text-red-700 hover:bg-red-100 min-h-[44px]"
            >
              <Edit className="h-4 w-4" />
            </Button>
          </div>
        </Card>

        {/* Stats Grid - Enhanced */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <h3>Your Activity</h3>
            <UpdatedTime />
          </div>
          <div className="grid grid-cols-2 gap-3">
            {stats.map((stat, index) => {
              const Icon = stat.icon;
              return (
                <motion.div
                  key={stat.label}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                >
                  <Card className="p-4 border-0 shadow-sm hover:shadow-md transition-shadow">
                    <div className="flex items-start justify-between mb-2">
                      <Icon className={`h-5 w-5 ${stat.color}`} />
                    </div>
                    <p className={`text-2xl ${stat.color} mb-1`}>{stat.value}</p>
                    <p className="text-xs text-muted-foreground">{stat.label}</p>
                  </Card>
                </motion.div>
              );
            })}
          </div>
        </div>



        {/* App Settings */}
        <Card className="p-5 border-0 shadow-sm">
          <h3 className="mb-4">App Settings</h3>

          <div className="space-y-4">
            {/* Notifications Toggle */}
            <motion.div 
              className="flex items-center justify-between p-3 bg-muted/30 rounded-xl"
              whileTap={{ scale: 0.98 }}
            >
              <div className="flex items-center gap-3">
                <div className={`p-2 rounded-lg ${notificationsEnabled ? "bg-primary/10" : "bg-muted"}`}>
                  <Bell className={`h-5 w-5 ${notificationsEnabled ? "text-primary" : "text-muted-foreground"}`} />
                </div>
                <div>
                  <p className="text-sm font-medium">Push Notifications</p>
                  <p className="text-xs text-muted-foreground">
                    Get updates instantly • తక్షణ నోటిఫికేషన్లు
                  </p>
                </div>
              </div>
              <Switch
                checked={notificationsEnabled}
                onCheckedChange={handleToggleNotifications}
              />
            </motion.div>

            <Separator />

            {/* Dark Mode Toggle */}
            <motion.div 
              className="flex items-center justify-between p-3 bg-muted/30 rounded-xl"
              whileTap={{ scale: 0.98 }}
            >
              <div className="flex items-center gap-3">
                <div className="p-2 bg-muted rounded-lg">
                  {darkMode ? (
                    <Moon className="h-5 w-5 text-muted-foreground" />
                  ) : (
                    <Sun className="h-5 w-5 text-muted-foreground" />
                  )}
                </div>
                <div>
                  <p className="text-sm font-medium">Dark Mode</p>
                  <p className="text-xs text-muted-foreground">
                    Switch theme appearance
                  </p>
                </div>
              </div>
              <Switch
                checked={darkMode}
                onCheckedChange={setDarkMode}
              />
            </motion.div>
          </div>
        </Card>

        {/* Quick Actions */}
        <Card className="p-5 border-0 shadow-sm">
          <h3 className="mb-4">Quick Actions</h3>
          <div className="space-y-2">
            <motion.div whileTap={{ scale: 0.98 }}>
              <Button 
                variant="outline" 
                className="w-full justify-between group hover:bg-primary/5 hover:border-primary/20 min-h-[48px]"
                onClick={() => toast.info("Password change feature coming soon")}
              >
                <div className="flex items-center gap-3">
                  <Shield className="h-5 w-5 text-primary" />
                  <span>Change Password</span>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </Button>
            </motion.div>

            <motion.div whileTap={{ scale: 0.98 }}>
              <Button 
                variant="outline" 
                className="w-full justify-between group hover:bg-primary/5 hover:border-primary/20 min-h-[48px]"
                onClick={() => toast.info("ID card download coming soon")}
              >
                <div className="flex items-center gap-3">
                  <User className="h-5 w-5 text-green-600" />
                  <span>Download ID Card</span>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </Button>
            </motion.div>

            <motion.div whileTap={{ scale: 0.98 }}>
              <Button 
                variant="outline" 
                className="w-full justify-between group hover:bg-primary/5 hover:border-primary/20 min-h-[48px]"
                onClick={() => toast.success("Calling warden... ☎️")}
              >
                <div className="flex items-center gap-3">
                  <Phone className="h-5 w-5 text-amber-600" />
                  <span>Contact Warden</span>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </Button>
            </motion.div>

            <motion.div whileTap={{ scale: 0.98 }}>
              <Button 
                variant="outline" 
                className="w-full justify-between group hover:bg-primary/5 hover:border-primary/20 min-h-[48px]"
                onClick={() => {
                  if (onNavigate) {
                    onNavigate("settings");
                  } else {
                    toast.info("Settings page");
                  }
                }}
              >
                <div className="flex items-center gap-3">
                  <SettingsIcon className="h-5 w-5 text-purple-600" />
                  <span>Settings</span>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </Button>
            </motion.div>

            <motion.div whileTap={{ scale: 0.98 }}>
              <Button 
                variant="outline" 
                className="w-full justify-between group hover:bg-primary/5 hover:border-primary/20 min-h-[48px]"
                onClick={() => toast.info("Help center coming soon")}
              >
                <div className="flex items-center gap-3">
                  <AlertCircle className="h-5 w-5 text-blue-600" />
                  <span>Help & Support</span>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </Button>
            </motion.div>
          </div>
        </Card>

        {/* Logout Button */}
        <motion.div whileTap={{ scale: 0.98 }}>
          <Button
            onClick={() => {
              toast.success("Logged out successfully! 👋");
              setTimeout(onLogout, 500);
            }}
            variant="destructive"
            className="w-full min-h-[48px] shadow-sm"
          >
            <LogOut className="h-5 w-5 mr-2" />
            Logout
          </Button>
        </motion.div>

        {/* App Info */}
        <Card className="p-4 border-0 shadow-sm text-center bg-muted/30">
          <p className="text-xs text-muted-foreground">
            HostelConnect v1.0.0
          </p>
          <p className="text-xs text-muted-foreground mt-1">
            Made with ❤️ for Andhra & Telangana Hostels
          </p>
          <p className="text-xs text-muted-foreground mt-1">
            © 2025 University Hostel Management
          </p>
        </Card>
      </div>
    </div>
  );
}
