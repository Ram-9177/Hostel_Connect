import { useState } from "react";
import { Plus, X, FileText, QrCode, Utensils, Bell, MapPin, Clock, MessageSquare } from "lucide-react";
import { Button } from "./ui/button";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import { motion, AnimatePresence } from "motion/react";
import { toast } from "sonner@2.0.3";

interface QuickAccessMenuProps {
  onNavigate: (page: string) => void;
  userRole?: string;
}

export function QuickAccessMenu({ onNavigate, userRole = "student" }: QuickAccessMenuProps) {
  const [isOpen, setIsOpen] = useState(false);

  // Quick actions based on user role
  const getQuickActions = () => {
    if (userRole === "student") {
      return [
        { 
          id: "new-gatepass", 
          label: "New Gate Pass", 
          labelTe: "కొత్త గేట్ పాస్",
          icon: QrCode, 
          color: "bg-primary",
          page: "gatepass",
          badge: null,
        },
        { 
          id: "mark-attendance", 
          label: "Mark Attendance", 
          labelTe: "హాజరు",
          icon: Clock, 
          color: "bg-green-600",
          page: "attendance",
          badge: null,
        },
        { 
          id: "meal-optout", 
          label: "Meal Opt-out", 
          labelTe: "భోజనం",
          icon: Utensils, 
          color: "bg-orange-600",
          page: "meals",
          badge: null,
        },
        { 
          id: "new-complaint", 
          label: "File Complaint", 
          labelTe: "ఫిర్యాదు",
          icon: MessageSquare, 
          color: "bg-amber-600",
          page: "complaints",
          badge: null,
        },
        { 
          id: "notices", 
          label: "View Notices", 
          labelTe: "నోటీసులు",
          icon: Bell, 
          color: "bg-purple-600",
          page: "notices",
          badge: 2,
        },
      ];
    } else if (userRole === "warden") {
      return [
        { 
          id: "approve-passes", 
          label: "Approve Passes", 
          icon: FileText, 
          color: "bg-blue-600",
          page: "warden",
          badge: 5,
        },
        { 
          id: "view-attendance", 
          label: "View Attendance", 
          icon: Clock, 
          color: "bg-green-600",
          page: "attendance",
          badge: null,
        },
        { 
          id: "room-allotment", 
          label: "Room Allotment", 
          icon: MapPin, 
          color: "bg-purple-600",
          page: "rooms",
          badge: null,
        },
        { 
          id: "complaints", 
          label: "Resolve Complaints", 
          icon: MessageSquare, 
          color: "bg-amber-600",
          page: "complaints",
          badge: 3,
        },
      ];
    } else if (userRole === "chef") {
      return [
        { 
          id: "update-menu", 
          label: "Update Menu", 
          icon: Utensils, 
          color: "bg-orange-600",
          page: "chef",
          badge: null,
        },
        { 
          id: "meal-count", 
          label: "View Meal Count", 
          icon: Clock, 
          color: "bg-green-600",
          page: "chef",
          badge: null,
        },
      ];
    } else {
      return [
        { 
          id: "dashboard", 
          label: "Dashboard", 
          icon: FileText, 
          color: "bg-primary",
          page: userRole === "warden-head" ? "warden-head" : "super-admin",
          badge: null,
        },
      ];
    }
  };

  const quickActions = getQuickActions();

  const handleQuickAction = (action: typeof quickActions[0]) => {
    setIsOpen(false);
    
    // Simulate haptic feedback
    if (action.id === "new-gatepass") {
      toast.success("Opening gate pass form 🎫");
      onNavigate(action.page);
    } else if (action.id === "mark-attendance") {
      toast.info("Scan QR to mark attendance 📱");
      onNavigate(action.page);
    } else if (action.id === "meal-optout") {
      toast.info("Opening meal preferences 🍽️");
      onNavigate(action.page);
    } else if (action.id === "new-complaint") {
      toast.info("File a new complaint 📝");
      onNavigate(action.page);
    } else {
      onNavigate(action.page);
    }
  };

  return (
    <>
      {/* Floating Action Button - Enhanced */}
      <motion.button
        onClick={() => setIsOpen(!isOpen)}
        className="fixed bottom-24 right-4 w-14 h-14 bg-gradient-to-br from-primary to-secondary text-white rounded-full shadow-lg flex items-center justify-center z-50 hover:shadow-xl"
        whileHover={{ scale: 1.1 }}
        whileTap={{ scale: 0.95 }}
        animate={isOpen ? { rotate: 45 } : { rotate: 0 }}
      >
        {isOpen ? <X className="h-6 w-6" /> : <Plus className="h-6 w-6" />}
      </motion.button>

      {/* Menu Overlay */}
      <AnimatePresence>
        {isOpen && (
          <>
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={() => setIsOpen(false)}
              className="fixed inset-0 bg-black/50 z-40 backdrop-blur-sm"
            />

            <motion.div
              initial={{ opacity: 0, scale: 0.9, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: 20 }}
              transition={{ type: "spring", damping: 25, stiffness: 300 }}
              className="fixed bottom-44 right-4 z-50"
            >
              <Card className="p-4 space-y-2 border-0 shadow-2xl min-w-[240px] max-w-[280px]">
                <div className="flex items-center justify-between mb-3 px-2">
                  <div>
                    <p className="text-xs text-muted-foreground">Quick Actions</p>
                    {userRole === "student" && (
                      <p className="text-xs text-muted-foreground/60">త్వరిత చర్యలు</p>
                    )}
                  </div>
                  {quickActions.filter(a => a.badge).length > 0 && (
                    <Badge variant="destructive" className="text-xs">
                      {quickActions.filter(a => a.badge).reduce((sum, a) => sum + (a.badge || 0), 0)}
                    </Badge>
                  )}
                </div>
                
                <div className="space-y-2">
                  {quickActions.map((action, index) => {
                    const Icon = action.icon;
                    return (
                      <motion.div
                        key={action.id}
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: index * 0.05 }}
                      >
                        <Button
                          onClick={() => handleQuickAction(action)}
                          variant="outline"
                          className="w-full justify-start gap-3 h-12 hover:bg-primary/5 hover:border-primary/30 group"
                        >
                          <div className={`${action.color} p-2 rounded-lg text-white group-hover:scale-110 transition-transform`}>
                            <Icon className="h-4 w-4" />
                          </div>
                          <div className="flex-1 text-left">
                            <p className="text-sm font-medium">{action.label}</p>
                            {userRole === "student" && "labelTe" in action && (
                              <p className="text-xs text-muted-foreground">{action.labelTe}</p>
                            )}
                          </div>
                          {action.badge && (
                            <Badge className="bg-red-500 text-white text-xs">
                              {action.badge}
                            </Badge>
                          )}
                        </Button>
                      </motion.div>
                    );
                  })}
                </div>

                {userRole === "student" && (
                  <div className="pt-2 mt-2 border-t border-border">
                    <p className="text-xs text-center text-muted-foreground">
                      Tap + for quick actions
                    </p>
                  </div>
                )}
              </Card>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
