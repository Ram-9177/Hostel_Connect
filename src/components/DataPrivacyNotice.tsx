import { Shield, X } from "lucide-react";
import { useState, useEffect } from "react";
import { Button } from "./ui/button";
import { Card } from "./ui/card";
import { motion, AnimatePresence } from "motion/react";

export function DataPrivacyNotice() {
  const [showNotice, setShowNotice] = useState(false);

  useEffect(() => {
    // Check if user has already seen the notice
    const hasSeenNotice = localStorage.getItem("hasSeenPrivacyNotice");
    if (!hasSeenNotice) {
      // Show after 2 seconds
      setTimeout(() => setShowNotice(true), 2000);
    }
  }, []);

  const handleAccept = () => {
    localStorage.setItem("hasSeenPrivacyNotice", "true");
    setShowNotice(false);
  };

  return (
    <AnimatePresence>
      {showNotice && (
        <>
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 z-50 backdrop-blur-sm"
          />

          <motion.div
            initial={{ opacity: 0, y: 100 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 100 }}
            className="fixed bottom-4 left-4 right-4 z-50 max-w-md mx-auto"
          >
            <Card className="p-5 border-0 shadow-2xl">
              <div className="flex items-start gap-3 mb-4">
                <div className="p-2 bg-green-100 rounded-lg flex-shrink-0">
                  <Shield className="h-5 w-5 text-green-600" />
                </div>
                <div className="flex-1">
                  <h3 className="font-semibold mb-1">Your Privacy Matters</h3>
                  <p className="text-sm text-muted-foreground">
                    మీ గోప్యత ముఖ్యం
                  </p>
                </div>
                <button
                  onClick={handleAccept}
                  className="p-1 hover:bg-muted rounded flex-shrink-0"
                >
                  <X className="h-4 w-4" />
                </button>
              </div>

              <div className="space-y-2 text-sm text-muted-foreground mb-4">
                <p>
                  HostelConnect is designed for hostel management operations only.
                </p>
                <p>
                  We do <strong>not</strong> collect PII (Personally Identifiable Information) for commercial purposes.
                </p>
                <p>
                  All data is stored securely and used solely for hostel administration in compliance with Indian data protection guidelines.
                </p>
              </div>

              <Button onClick={handleAccept} className="w-full">
                I Understand
              </Button>
            </Card>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
