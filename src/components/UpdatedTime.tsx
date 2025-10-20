import { Clock } from "lucide-react";

interface UpdatedTimeProps {
  time?: string;
  className?: string;
  showIcon?: boolean;
}

export function UpdatedTime({ time, className = "", showIcon = true }: UpdatedTimeProps) {
  const displayTime = time || new Date().toLocaleTimeString('en-IN', { 
    hour: '2-digit', 
    minute: '2-digit',
    timeZone: 'Asia/Kolkata'
  });

  return (
    <div className={`flex items-center gap-1.5 text-xs text-muted-foreground ${className}`}>
      {showIcon && <Clock className="h-3 w-3" />}
      <span>Updated {displayTime} IST</span>
    </div>
  );
}
