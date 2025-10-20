import { Home, FileText, Utensils, MessageSquare, User } from "lucide-react";
import { motion } from "motion/react";

interface BottomNavProps {
  currentPage: string;
  onNavigate: (page: string) => void;
}

export function BottomNav({ currentPage, onNavigate }: BottomNavProps) {
  const navItems = [
    { id: "home", label: "Home", labelTe: "హోమ్", icon: Home },
    { id: "gatepass", label: "Pass", labelTe: "పాస్", icon: FileText },
    { id: "meals", label: "Meals", labelTe: "భోజనం", icon: Utensils },
    { id: "complaints", label: "Issues", labelTe: "సమస్యలు", icon: MessageSquare },
    { id: "profile", label: "Profile", labelTe: "ప్రొఫైల్", icon: User },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-card/95 backdrop-blur-lg border-t border-border z-50 shadow-2xl">
      <div className="max-w-md mx-auto flex justify-around items-center h-20 px-2">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = currentPage === item.id;
          
          return (
            <motion.button
              key={item.id}
              onClick={() => onNavigate(item.id)}
              whileTap={{ scale: 0.9 }}
              className={`flex flex-col items-center justify-center flex-1 h-full transition-all relative ${
                isActive ? "text-primary" : "text-muted-foreground"
              }`}
            >
              {/* Active indicator */}
              {isActive && (
                <motion.div
                  layoutId="activeTab"
                  className="absolute inset-2 bg-primary/10 rounded-2xl"
                  transition={{ type: "spring", stiffness: 300, damping: 30 }}
                />
              )}
              
              <div className="relative z-10 flex flex-col items-center gap-1">
                <div className={`p-2 rounded-xl transition-all ${
                  isActive ? "bg-primary/10" : ""
                }`}>
                  <Icon className={`transition-all ${
                    isActive ? "h-6 w-6" : "h-5 w-5"
                  }`} />
                </div>
                <span className={`text-xs transition-all ${
                  isActive ? "font-medium" : ""
                }`}>
                  {item.label}
                </span>
              </div>
            </motion.button>
          );
        })}
      </div>
    </div>
  );
}
