import { motion } from "motion/react";

interface LoadingStateProps {
  text?: string;
}

export function LoadingState({ text = "Loading..." }: LoadingStateProps) {
  return (
    <div className="flex items-center justify-center p-8">
      <div className="text-center space-y-4">
        <div className="flex gap-2 justify-center">
          {[0, 1, 2].map((i) => (
            <motion.div
              key={i}
              className="w-3 h-3 bg-primary rounded-full"
              animate={{
                y: [-8, 8, -8],
              }}
              transition={{
                duration: 0.6,
                repeat: Infinity,
                delay: i * 0.15,
              }}
            />
          ))}
        </div>
        <p className="text-sm text-muted-foreground">{text}</p>
      </div>
    </div>
  );
}
