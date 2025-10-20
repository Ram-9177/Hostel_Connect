import { Bell, QrCode, ClipboardCheck, Utensils, Megaphone } from "lucide-react";
import { AdBanner } from "../AdBanner";
import { UpdatedTime } from "../UpdatedTime";
import { Card } from "../ui/card";
import { Badge } from "../ui/badge";
import { motion } from "motion/react";

interface StudentHomeProps {
  onNavigate: (page: string) => void;
  studentName?: string;
  hostelName?: string;
}

// Get greeting based on time of day
const getGreeting = () => {
  const hour = new Date().getHours();
  if (hour < 12) return { en: "Good Morning", te: "శుభోదయం" };
  if (hour < 17) return { en: "Good Afternoon", te: "శుభ మధ్యాహ్నం" };
  return { en: "Good Evening", te: "శుభ సాయంత్రం" };
};

export function StudentHome({ 
  onNavigate, 
  studentName = "Venkat Reddy",
  hostelName = "Annapurna Boys Hostel" 
}: StudentHomeProps) {
  const greeting = getGreeting();
  
  const quickActions = [
    {
      id: "gatepass",
      title: "Gate Pass",
      titleTe: "గేట్ పాస్",
      description: "Request outpass",
      icon: QrCode,
      color: "bg-primary",
      count: "2 Active",
      gradient: "from-primary to-primary/80",
    },
    {
      id: "attendance",
      title: "Attendance",
      titleTe: "హాజరు",
      description: "Mark your presence",
      icon: ClipboardCheck,
      color: "bg-green-600",
      count: "85% This Month",
      gradient: "from-green-600 to-green-700",
    },
    {
      id: "meals",
      title: "Meals",
      titleTe: "భోజనం",
      description: "Set preferences",
      icon: Utensils,
      color: "bg-accent",
      count: "3 Pending",
      gradient: "from-accent to-amber-500",
    },
    {
      id: "notices",
      title: "Notices",
      titleTe: "ప్రకటనలు",
      description: "Latest updates",
      icon: Megaphone,
      color: "bg-secondary",
      count: "5 New",
      gradient: "from-secondary to-blue-700",
    },
  ];

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Enhanced Header with gradient and better spacing */}
      <div className="bg-gradient-to-br from-primary via-primary to-secondary text-white p-6 pb-10 rounded-b-[2rem] shadow-lg relative overflow-hidden">
        {/* Decorative background elements */}
        <div className="absolute top-0 right-0 w-32 h-32 bg-white/5 rounded-full -translate-y-16 translate-x-16" />
        <div className="absolute bottom-0 left-0 w-24 h-24 bg-white/5 rounded-full translate-y-12 -translate-x-12" />
        
        <div className="relative">
          <div className="flex items-start justify-between mb-6">
            <div className="flex-1">
              <motion.div
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3 }}
              >
                <p className="text-sm opacity-90 mb-1">{greeting.en} 🙏</p>
                <h1 className="text-2xl mt-1 mb-1">{studentName}</h1>
                <p className="text-xs opacity-75">{hostelName}</p>
              </motion.div>
            </div>
            <motion.button 
              whileTap={{ scale: 0.95 }}
              className="p-3 bg-white/20 rounded-2xl hover:bg-white/30 transition-colors relative"
            >
              <Bell className="h-5 w-5" />
              <span className="absolute top-1 right-1 w-2 h-2 bg-accent rounded-full" />
            </motion.button>
          </div>
          
          {/* Quick Stats Bar */}
          <div className="grid grid-cols-3 gap-3 bg-white/10 backdrop-blur-sm rounded-2xl p-4">
            <div className="text-center">
              <p className="text-2xl mb-1">✓</p>
              <p className="text-xs opacity-90">Present</p>
            </div>
            <div className="text-center border-x border-white/20">
              <p className="text-2xl mb-1">2</p>
              <p className="text-xs opacity-90">Active Passes</p>
            </div>
            <div className="text-center">
              <p className="text-2xl mb-1">4</p>
              <p className="text-xs opacity-90">Meals Set</p>
            </div>
          </div>
        </div>
      </div>

      {/* Collapsible Ad Banner */}
      <AdBanner />

      {/* Quick Actions Grid */}
      <div className="p-4 space-y-5">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="mb-1">Quick Actions</h2>
            <p className="text-xs text-muted-foreground">Tap to access services</p>
          </div>
          <UpdatedTime />
        </div>

        <div className="grid grid-cols-2 gap-4">
          {quickActions.map((action, index) => {
            const Icon = action.icon;
            return (
              <motion.div
                key={action.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                <Card
                  className="p-5 cursor-pointer hover:shadow-xl transition-all active:scale-95 border-0 shadow-md relative overflow-hidden group"
                  onClick={() => onNavigate(action.id)}
                >
                  {/* Gradient background on hover */}
                  <div className={`absolute inset-0 bg-gradient-to-br ${action.gradient} opacity-0 group-hover:opacity-5 transition-opacity`} />
                  
                  <div className="relative space-y-4">
                    <div className="flex items-start justify-between">
                      <div className={`${action.color} w-14 h-14 rounded-2xl flex items-center justify-center shadow-lg`}>
                        <Icon className="h-7 w-7 text-white" />
                      </div>
                      {action.count.includes("New") && (
                        <Badge variant="destructive" className="text-xs px-2 py-0">New</Badge>
                      )}
                    </div>
                    <div>
                      <h3 className="text-base mb-1">{action.title}</h3>
                      <p className="text-xs text-muted-foreground">
                        {action.description}
                      </p>
                    </div>
                    <div className="pt-2 border-t border-border/50">
                      <p className="text-xs text-primary font-medium">{action.count}</p>
                    </div>
                  </div>
                </Card>
              </motion.div>
            );
          })}
        </div>

        {/* Today's Summary Card with enhanced design */}
        <Card className="p-6 space-y-4 border-0 shadow-md bg-gradient-to-br from-card to-muted/10">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="mb-1">Today's Activity</h3>
              <p className="text-xs text-muted-foreground">Sunday, 19 Oct 2025</p>
            </div>
            <UpdatedTime time="09:15" />
          </div>
          <div className="grid grid-cols-3 gap-4">
            <div className="text-center p-3 bg-card rounded-xl">
              <div className="w-10 h-10 bg-green-100 dark:bg-green-950 rounded-full flex items-center justify-center mx-auto mb-2">
                <p className="text-xl">✓</p>
              </div>
              <p className="text-xs text-muted-foreground">Attendance</p>
              <p className="text-xs text-green-600 mt-1">Marked</p>
            </div>
            <div className="text-center p-3 bg-card rounded-xl">
              <div className="w-10 h-10 bg-amber-100 dark:bg-amber-950 rounded-full flex items-center justify-center mx-auto mb-2">
                <p className="text-xl">4</p>
              </div>
              <p className="text-xs text-muted-foreground">Meals</p>
              <p className="text-xs text-accent mt-1">Set</p>
            </div>
            <div className="text-center p-3 bg-card rounded-xl">
              <div className="w-10 h-10 bg-blue-100 dark:bg-blue-950 rounded-full flex items-center justify-center mx-auto mb-2">
                <p className="text-xl">2</p>
              </div>
              <p className="text-xs text-muted-foreground">Passes</p>
              <p className="text-xs text-primary mt-1">Active</p>
            </div>
          </div>
        </Card>

        {/* Recent Notices Preview with better visual hierarchy */}
        <Card className="p-5 space-y-4 border-0 shadow-md">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Megaphone className="h-5 w-5 text-primary" />
              <h3>Latest Notices</h3>
            </div>
            <button
              onClick={() => onNavigate("notices")}
              className="text-xs text-primary hover:underline font-medium"
            >
              View All →
            </button>
          </div>
          <div className="space-y-2">
            {[
              { title: "Mess Menu Updated - South Indian Special", time: "2 hours ago", priority: "high" },
              { title: "Dussehra Holiday Announcement", time: "5 hours ago", priority: "medium" },
              { title: "Room Inspection Schedule", time: "1 day ago", priority: "low" },
            ].map((notice, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 + 0.4 }}
                className="flex items-start gap-3 p-4 bg-muted/20 hover:bg-muted/40 rounded-xl cursor-pointer transition-colors border border-transparent hover:border-primary/20"
                onClick={() => onNavigate("notices")}
              >
                <div className={`w-2 h-2 rounded-full mt-2 ${
                  notice.priority === "high" ? "bg-destructive" : 
                  notice.priority === "medium" ? "bg-accent" : 
                  "bg-primary"
                }`} />
                <div className="flex-1">
                  <p className="text-sm mb-1">{notice.title}</p>
                  <p className="text-xs text-muted-foreground">
                    {notice.time}
                  </p>
                </div>
              </motion.div>
            ))}
          </div>
        </Card>
      </div>
    </div>
  );
}
