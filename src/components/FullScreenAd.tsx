import { useEffect, useState } from "react";
import { X } from "lucide-react";
import { Button } from "./ui/button";

interface FullScreenAdProps {
  duration?: number;
  onComplete: () => void;
  onSkip?: () => void;
}

export function FullScreenAd({ duration = 20, onComplete, onSkip }: FullScreenAdProps) {
  const [countdown, setCountdown] = useState(duration);
  const [canSkip, setCanSkip] = useState(false);

  useEffect(() => {
    const timer = setInterval(() => {
      setCountdown((prev) => {
        if (prev <= 1) {
          clearInterval(timer);
          setTimeout(onComplete, 100);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    // Allow skip after 5 seconds
    const skipTimer = setTimeout(() => {
      setCanSkip(true);
    }, 5000);

    return () => {
      clearInterval(timer);
      clearTimeout(skipTimer);
    };
  }, [onComplete]);

  const handleSkip = () => {
    if (canSkip && onSkip) {
      onSkip();
    }
  };

  return (
    <div className="fixed inset-0 bg-black z-[100] flex items-center justify-center">
      {/* Ad Content */}
      <div className="relative w-full h-full flex flex-col items-center justify-center p-8 bg-gradient-to-br from-primary to-secondary">
        <div className="max-w-md text-center space-y-6">
          <div className="text-white space-y-4">
            <h1 className="text-4xl">Campus Store</h1>
            <p className="text-xl opacity-90">
              20% off on all stationery items
            </p>
            <p className="text-lg opacity-75">
              Visit Ground Floor, Block A
            </p>
            <div className="pt-8">
              <div className="inline-block bg-white/20 backdrop-blur-sm rounded-full px-6 py-3">
                <p className="text-2xl">
                  Offer ends in 3 days
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Countdown Overlay */}
        <div className="absolute top-4 right-4 bg-black/50 backdrop-blur-sm rounded-full px-4 py-2 text-white">
          <p className="text-sm">
            {countdown}s
          </p>
        </div>

        {/* Skip/Continue Button */}
        <div className="absolute bottom-8 left-0 right-0 flex justify-center">
          {canSkip ? (
            <Button
              onClick={handleSkip}
              size="lg"
              className="bg-white text-primary hover:bg-white/90 shadow-lg"
            >
              Continue
            </Button>
          ) : (
            <div className="bg-black/30 backdrop-blur-sm rounded-full px-6 py-3 text-white">
              <p className="text-sm">Please wait {Math.max(0, 5 - (duration - countdown))}s</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
