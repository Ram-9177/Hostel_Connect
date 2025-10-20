import { useEffect, useState } from "react";
import { motion } from "motion/react";
import { CheckCircle2, Clock } from "lucide-react";

interface QRCodeDisplayProps {
  passId: string;
  onExpire?: () => void;
  duration?: number;
}

export function QRCodeDisplay({ passId, onExpire, duration = 30 }: QRCodeDisplayProps) {
  const [timeLeft, setTimeLeft] = useState(duration);
  const [rotation, setRotation] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          clearInterval(timer);
          onExpire?.();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, [onExpire]);

  useEffect(() => {
    const rotationTimer = setInterval(() => {
      setRotation((prev) => (prev + 90) % 360);
    }, 5000);

    return () => clearInterval(rotationTimer);
  }, []);

  return (
    <div className="flex flex-col items-center justify-center p-8 space-y-6">
      <div className="text-center space-y-2">
        <div className="flex items-center justify-center gap-2 text-green-600">
          <CheckCircle2 className="h-6 w-6" />
          <h2>Gate Pass Approved</h2>
        </div>
        <p className="text-sm text-muted-foreground">Show this QR code at the gate</p>
      </div>

      {/* Rotating QR Code */}
      <motion.div
        animate={{ rotate: rotation }}
        transition={{ duration: 0.5 }}
        className="bg-white p-6 rounded-xl shadow-lg"
      >
        <div className="w-64 h-64 bg-gradient-to-br from-gray-100 to-gray-200 rounded-lg flex items-center justify-center">
          {/* QR Code Pattern (simplified visual representation) */}
          <div className="grid grid-cols-8 gap-1 p-4">
            {Array.from({ length: 64 }).map((_, i) => (
              <div
                key={i}
                className={`w-6 h-6 rounded-sm ${
                  Math.random() > 0.5 ? "bg-black" : "bg-white"
                }`}
              />
            ))}
          </div>
        </div>
      </motion.div>

      {/* Pass Info */}
      <div className="w-full max-w-sm space-y-3">
        <div className="bg-card rounded-xl p-4 shadow-sm space-y-2">
          <div className="flex justify-between items-center">
            <span className="text-sm text-muted-foreground">Pass ID:</span>
            <span className="font-mono">{passId}</span>
          </div>
          <div className="flex justify-between items-center">
            <span className="text-sm text-muted-foreground">Status:</span>
            <span className="text-green-600">Active</span>
          </div>
        </div>

        {/* Timer */}
        <div className="bg-destructive/10 border border-destructive/20 rounded-xl p-4 flex items-center justify-center gap-2">
          <Clock className="h-5 w-5 text-destructive" />
          <p className="text-destructive">
            Expires in <span className="font-mono">{timeLeft}s</span>
          </p>
        </div>
      </div>

      <p className="text-xs text-center text-muted-foreground max-w-xs">
        QR code rotates every 5 seconds for security. Valid for single use only.
      </p>
    </div>
  );
}
