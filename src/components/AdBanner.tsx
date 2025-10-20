import { useState } from "react";
import { ChevronUp, ChevronDown, X } from "lucide-react";

interface AdBannerProps {
  content?: string;
  collapsible?: boolean;
}

export function AdBanner({ content = "Special Offer: Get 20% off on mess bills this month!", collapsible = true }: AdBannerProps) {
  const [collapsed, setCollapsed] = useState(false);

  if (collapsed && collapsible) {
    return (
      <button
        onClick={() => setCollapsed(false)}
        className="w-full bg-accent/10 border-b border-accent/20 px-4 py-2 flex items-center justify-center gap-2 text-accent-foreground"
      >
        <ChevronDown className="h-4 w-4" />
        <span className="text-sm">Show Ad</span>
      </button>
    );
  }

  return (
    <div className="w-full bg-gradient-to-r from-accent/20 to-accent/10 border-b border-accent/20 px-4 py-3">
      <div className="flex items-center justify-between gap-2">
        <p className="text-sm text-accent-foreground flex-1">{content}</p>
        {collapsible && (
          <button
            onClick={() => setCollapsed(true)}
            className="text-accent-foreground hover:text-accent transition-colors"
          >
            <ChevronUp className="h-4 w-4" />
          </button>
        )}
      </div>
    </div>
  );
}
