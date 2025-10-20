import { useState, useRef, ReactNode } from "react";
import { RefreshCw } from "lucide-react";
import { motion, useMotionValue, useTransform, PanInfo } from "motion/react";
import { toast } from "sonner@2.0.3";

interface PullToRefreshProps {
  onRefresh: () => Promise<void>;
  children: ReactNode;
}

export function PullToRefresh({ onRefresh, children }: PullToRefreshProps) {
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [isPulling, setIsPulling] = useState(false);
  const y = useMotionValue(0);
  const containerRef = useRef<HTMLDivElement>(null);

  const PULL_THRESHOLD = 80;
  const MAX_PULL = 120;

  // Transform values for smooth animation
  const pullProgress = useTransform(y, [0, PULL_THRESHOLD], [0, 1]);
  const iconRotate = useTransform(y, [0, MAX_PULL], [0, 360]);
  const iconScale = useTransform(y, [0, PULL_THRESHOLD, MAX_PULL], [0.5, 1, 1.2]);

  const handleDragStart = () => {
    const container = containerRef.current;
    if (container && container.scrollTop === 0 && !isRefreshing) {
      setIsPulling(true);
    }
  };

  const handleDrag = (_: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
    if (!isPulling || isRefreshing) return;

    const dragY = Math.max(0, Math.min(info.offset.y, MAX_PULL));
    y.set(dragY);
  };

  const handleDragEnd = async () => {
    if (!isPulling || isRefreshing) return;

    setIsPulling(false);

    if (y.get() >= PULL_THRESHOLD) {
      setIsRefreshing(true);
      y.set(PULL_THRESHOLD);

      try {
        await onRefresh();
        toast.success("Refreshed successfully! ✨", {
          description: "Latest data loaded",
        });
      } catch (error) {
        toast.error("Failed to refresh", {
          description: "Please try again",
        });
      } finally {
        setIsRefreshing(false);
        y.set(0);
      }
    } else {
      y.set(0);
    }
  };

  return (
    <div ref={containerRef} className="relative h-full overflow-auto">
      {/* Pull Indicator */}
      <motion.div
        style={{ height: y }}
        className="absolute top-0 left-0 right-0 flex items-end justify-center pb-2 bg-gradient-to-b from-primary/5 to-transparent overflow-hidden z-10"
      >
        <motion.div
          style={{
            rotate: isRefreshing ? 0 : iconRotate,
            scale: iconScale,
          }}
          animate={isRefreshing ? { rotate: 360 } : {}}
          transition={isRefreshing ? { duration: 1, repeat: Infinity, ease: "linear" } : {}}
          className="flex flex-col items-center"
        >
          <div className="p-2 bg-white rounded-full shadow-md">
            <RefreshCw className="h-5 w-5 text-primary" />
          </div>
          {!isRefreshing && y.get() > 20 && (
            <motion.p
              initial={{ opacity: 0 }}
              animate={{ opacity: pullProgress.get() }}
              className="text-xs text-primary font-medium mt-2"
            >
              {y.get() >= PULL_THRESHOLD ? "Release to refresh" : "Pull to refresh"}
            </motion.p>
          )}
          {isRefreshing && (
            <p className="text-xs text-primary font-medium mt-2">Refreshing...</p>
          )}
        </motion.div>
      </motion.div>

      {/* Content */}
      <motion.div
        drag="y"
        dragConstraints={{ top: 0, bottom: 0 }}
        dragElastic={0.2}
        onDragStart={handleDragStart}
        onDrag={handleDrag}
        onDragEnd={handleDragEnd}
        style={{ y }}
        className="min-h-full"
      >
        {children}
      </motion.div>
    </div>
  );
}
