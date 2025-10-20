import { useEffect, useState } from "react";
import { WifiOff, Wifi } from "lucide-react";
import { motion, AnimatePresence } from "motion/react";
import { toast } from "sonner@2.0.3";

export function OfflineIndicator() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [showBanner, setShowBanner] = useState(!navigator.onLine);

  useEffect(() => {
    const handleOnline = () => {
      setIsOnline(true);
      setShowBanner(false);
      toast.success("Back online! 🌐", {
        description: "Internet connection restored",
      });
    };

    const handleOffline = () => {
      setIsOnline(false);
      setShowBanner(true);
      toast.error("No internet connection 📡", {
        description: "Some features may be limited",
      });
    };

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, []);

  return (
    <AnimatePresence>
      {showBanner && (
        <motion.div
          initial={{ y: -100, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          exit={{ y: -100, opacity: 0 }}
          className="fixed top-0 left-0 right-0 z-50 bg-gradient-to-r from-amber-500 to-orange-500 text-white py-2 px-4 shadow-lg"
        >
          <div className="flex items-center justify-center gap-2 text-sm">
            <WifiOff className="h-4 w-4" />
            <span className="font-medium">Offline Mode</span>
            <span className="hidden sm:inline text-white/90">
              • Limited functionality
            </span>
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
