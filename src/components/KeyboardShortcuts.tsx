import { useState, useEffect } from "react";
import { Keyboard, X } from "lucide-react";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";
import { motion, AnimatePresence } from "motion/react";

export function KeyboardShortcuts() {
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Show shortcuts with Shift + ?
      if (e.shiftKey && e.key === "?") {
        e.preventDefault();
        setIsOpen(true);
      }
      // Close with Escape
      if (e.key === "Escape") {
        setIsOpen(false);
      }
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, []);

  const shortcuts = [
    { keys: ["⌘", "K"], description: "Open global search" },
    { keys: ["Shift", "?"], description: "Show keyboard shortcuts" },
    { keys: ["Esc"], description: "Close dialogs" },
    { keys: ["Tab"], description: "Navigate between fields" },
  ];

  return (
    <>
      {/* Keyboard Shortcut Hint - Bottom Right */}
      {!isOpen && (
        <motion.button
          onClick={() => setIsOpen(true)}
          className="fixed bottom-4 left-4 p-2 bg-muted/80 hover:bg-muted border border-border rounded-lg shadow-sm z-40 hidden md:flex items-center gap-2"
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
        >
          <Keyboard className="h-4 w-4 text-muted-foreground" />
          <span className="text-xs text-muted-foreground">Shift + ?</span>
        </motion.button>
      )}

      {/* Shortcuts Modal */}
      <AnimatePresence>
        {isOpen && (
          <>
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={() => setIsOpen(false)}
              className="fixed inset-0 bg-black/50 z-50 backdrop-blur-sm"
            />

            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.95 }}
              transition={{ type: "spring", damping: 25, stiffness: 300 }}
              className="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 z-50 w-full max-w-md px-4"
            >
              <Card className="p-6 border-0 shadow-2xl">
                <div className="flex items-center justify-between mb-6">
                  <div className="flex items-center gap-3">
                    <div className="p-2 bg-primary/10 rounded-lg">
                      <Keyboard className="h-5 w-5 text-primary" />
                    </div>
                    <h3 className="font-semibold">Keyboard Shortcuts</h3>
                  </div>
                  <Button
                    variant="ghost"
                    size="icon"
                    onClick={() => setIsOpen(false)}
                  >
                    <X className="h-5 w-5" />
                  </Button>
                </div>

                <div className="space-y-3">
                  {shortcuts.map((shortcut, index) => (
                    <div
                      key={index}
                      className="flex items-center justify-between p-3 bg-muted/30 rounded-lg"
                    >
                      <span className="text-sm text-muted-foreground">
                        {shortcut.description}
                      </span>
                      <div className="flex items-center gap-1">
                        {shortcut.keys.map((key, i) => (
                          <span key={i} className="flex items-center gap-1">
                            <Badge
                              variant="outline"
                              className="font-mono text-xs px-2"
                            >
                              {key}
                            </Badge>
                            {i < shortcut.keys.length - 1 && (
                              <span className="text-xs text-muted-foreground">
                                +
                              </span>
                            )}
                          </span>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>

                <p className="text-xs text-center text-muted-foreground mt-4">
                  Desktop only • More shortcuts coming soon
                </p>
              </Card>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
