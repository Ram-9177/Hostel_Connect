import { useState } from "react";
import { Settings, X, Home, Shield, ChefHat, UserCog, Building2 } from "lucide-react";
import { Button } from "./ui/button";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import { motion, AnimatePresence } from "motion/react";

interface DemoRoleSwitcherProps {
  currentRole: string;
  onRoleChange: (role: string) => void;
}

export function DemoRoleSwitcher({ currentRole, onRoleChange }: DemoRoleSwitcherProps) {
  const [isOpen, setIsOpen] = useState(false);

  const roles = [
    { id: "student", label: "Student", icon: Home, color: "bg-blue-600" },
    { id: "warden", label: "Warden", icon: Shield, color: "bg-purple-600" },
    { id: "warden-head", label: "Warden Head", icon: UserCog, color: "bg-indigo-600" },
    { id: "super-admin", label: "Super Admin", icon: Building2, color: "bg-red-600" },
    { id: "chef", label: "Chef", icon: ChefHat, color: "bg-orange-600" },
  ];

  return (
    <>
      {/* Demo Mode Badge - Top Left */}
      <motion.button
        onClick={() => setIsOpen(!isOpen)}
        className="fixed top-4 left-4 px-3 py-1.5 bg-gradient-to-r from-amber-500 to-orange-500 text-white rounded-full shadow-lg flex items-center gap-2 z-50 text-xs hover:shadow-xl"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <Settings className="h-3 w-3" />
        <span className="font-medium">DEMO MODE</span>
      </motion.button>

      {/* Role Switcher Overlay */}
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
              initial={{ opacity: 0, scale: 0.9, y: -20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.9, y: -20 }}
              transition={{ type: "spring", damping: 25, stiffness: 300 }}
              className="fixed top-20 left-4 z-50"
            >
              <Card className="p-4 space-y-3 border-0 shadow-2xl min-w-[220px]">
                <div className="flex items-center justify-between mb-2">
                  <div>
                    <p className="text-sm font-medium">Switch Role</p>
                    <p className="text-xs text-muted-foreground">Demo Testing Only</p>
                  </div>
                  <button
                    onClick={() => setIsOpen(false)}
                    className="p-1 hover:bg-muted rounded"
                  >
                    <X className="h-4 w-4" />
                  </button>
                </div>

                <div className="space-y-2">
                  {roles.map((role) => {
                    const Icon = role.icon;
                    const isActive = currentRole === role.id;
                    return (
                      <Button
                        key={role.id}
                        onClick={() => {
                          onRoleChange(role.id);
                          setIsOpen(false);
                        }}
                        variant={isActive ? "default" : "outline"}
                        className={`w-full justify-start gap-3 ${
                          isActive ? "bg-primary text-primary-foreground" : ""
                        }`}
                      >
                        <div className={`${role.color} p-1.5 rounded text-white`}>
                          <Icon className="h-3.5 w-3.5" />
                        </div>
                        <span className="text-sm flex-1 text-left">{role.label}</span>
                        {isActive && (
                          <Badge variant="secondary" className="text-xs">
                            Active
                          </Badge>
                        )}
                      </Button>
                    );
                  })}
                </div>

                <div className="pt-2 border-t border-border">
                  <p className="text-xs text-center text-muted-foreground">
                    For development testing only
                  </p>
                </div>
              </Card>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
