import { useState, useEffect } from "react";
import { Search, X, FileText, Clock, Utensils, MapPin, MessageSquare, ArrowRight } from "lucide-react";
import { Button } from "./ui/button";
import { Card } from "./ui/card";
import { Input } from "./ui/input";
import { Badge } from "./ui/badge";
import { motion, AnimatePresence } from "motion/react";
import { toast } from "sonner@2.0.3";

interface GlobalSearchProps {
  onNavigate: (page: string) => void;
  userRole: string;
}

interface SearchResult {
  id: string;
  title: string;
  subtitle: string;
  category: string;
  icon: typeof FileText;
  page: string;
  color: string;
}

export function GlobalSearch({ onNavigate, userRole }: GlobalSearchProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResults, setSearchResults] = useState<SearchResult[]>([]);

  // Mock search data
  const allData: SearchResult[] = [
    // Gate Passes
    { id: "gp1", title: "Home Visit Pass", subtitle: "Approved • 12 Dec 2024", category: "Gate Pass", icon: FileText, page: "gatepass", color: "bg-blue-500" },
    { id: "gp2", title: "Medical Emergency", subtitle: "Pending • 18 Dec 2024", category: "Gate Pass", icon: FileText, page: "gatepass", color: "bg-blue-500" },
    { id: "gp3", title: "Family Function", subtitle: "Rejected • 10 Dec 2024", category: "Gate Pass", icon: FileText, page: "gatepass", color: "bg-blue-500" },
    
    // Attendance
    { id: "at1", title: "Morning Roll Call", subtitle: "Present • Today 07:00 AM", category: "Attendance", icon: Clock, page: "attendance", color: "bg-green-500" },
    { id: "at2", title: "Evening Roll Call", subtitle: "Present • Yesterday 06:30 PM", category: "Attendance", icon: Clock, page: "attendance", color: "bg-green-500" },
    
    // Meals
    { id: "ml1", title: "Breakfast Opt-out", subtitle: "Tomorrow", category: "Meals", icon: Utensils, page: "meals", color: "bg-orange-500" },
    { id: "ml2", title: "Lunch Menu", subtitle: "Rice, Sambar, Curd", category: "Meals", icon: Utensils, page: "meals", color: "bg-orange-500" },
    { id: "ml3", title: "Dinner Menu", subtitle: "Chapati, Dal, Sabzi", category: "Meals", icon: Utensils, page: "meals", color: "bg-orange-500" },
    
    // Rooms
    { id: "rm1", title: "Room A-201", subtitle: "Block A • 2nd Floor", category: "Room", icon: MapPin, page: "rooms", color: "bg-purple-500" },
    { id: "rm2", title: "Room B-105", subtitle: "Block B • 1st Floor", category: "Room", icon: MapPin, page: "rooms", color: "bg-purple-500" },
    
    // Complaints
    { id: "cp1", title: "AC Not Working", subtitle: "In Progress • Room A-201", category: "Complaint", icon: MessageSquare, page: "complaints", color: "bg-amber-500" },
    { id: "cp2", title: "Water Supply Issue", subtitle: "Resolved • Block B", category: "Complaint", icon: MessageSquare, page: "complaints", color: "bg-amber-500" },
  ];

  useEffect(() => {
    if (searchQuery.trim() === "") {
      setSearchResults([]);
      return;
    }

    const query = searchQuery.toLowerCase();
    const filtered = allData.filter(
      (item) =>
        item.title.toLowerCase().includes(query) ||
        item.subtitle.toLowerCase().includes(query) ||
        item.category.toLowerCase().includes(query)
    );
    setSearchResults(filtered.slice(0, 8)); // Limit to 8 results
  }, [searchQuery]);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Open search with Ctrl+K or Cmd+K
      if ((e.ctrlKey || e.metaKey) && e.key === "k") {
        e.preventDefault();
        setIsOpen(true);
      }
      // Close search with Escape
      if (e.key === "Escape") {
        setIsOpen(false);
      }
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, []);

  const handleResultClick = (result: SearchResult) => {
    setIsOpen(false);
    setSearchQuery("");
    onNavigate(result.page);
    toast.success(`Opening ${result.title}`);
  };

  return (
    <>
      {/* Search Button - Floating */}
      <motion.button
        onClick={() => setIsOpen(true)}
        className="fixed top-4 right-4 p-2.5 bg-white border border-border rounded-full shadow-md hover:shadow-lg z-40"
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <Search className="h-5 w-5 text-muted-foreground" />
      </motion.button>

      {/* Search Modal */}
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
              initial={{ opacity: 0, scale: 0.95, y: -20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: -20 }}
              transition={{ type: "spring", damping: 25, stiffness: 300 }}
              className="fixed top-20 left-4 right-4 z-50 max-w-2xl mx-auto"
            >
              <Card className="border-0 shadow-2xl overflow-hidden">
                {/* Search Input */}
                <div className="p-4 border-b border-border bg-white">
                  <div className="flex items-center gap-3">
                    <Search className="h-5 w-5 text-muted-foreground flex-shrink-0" />
                    <Input
                      autoFocus
                      placeholder="Search gate passes, attendance, meals, rooms..."
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      className="border-0 focus-visible:ring-0 focus-visible:ring-offset-0 text-base"
                    />
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => setIsOpen(false)}
                      className="flex-shrink-0"
                    >
                      <X className="h-5 w-5" />
                    </Button>
                  </div>
                  <div className="flex items-center gap-2 mt-2">
                    <p className="text-xs text-muted-foreground">Quick search</p>
                    <Badge variant="outline" className="text-xs">
                      ⌘K
                    </Badge>
                  </div>
                </div>

                {/* Search Results */}
                <div className="max-h-[60vh] overflow-y-auto bg-white">
                  {searchQuery === "" ? (
                    <div className="p-8 text-center">
                      <Search className="h-12 w-12 text-muted-foreground/30 mx-auto mb-3" />
                      <p className="text-sm text-muted-foreground">
                        Start typing to search across all features
                      </p>
                      <p className="text-xs text-muted-foreground/60 mt-1">
                        గేట్ పాస్, హాజరు, భోజనం, రూములు మరియు ఫిర్యాదులు
                      </p>
                    </div>
                  ) : searchResults.length === 0 ? (
                    <div className="p-8 text-center">
                      <p className="text-sm text-muted-foreground">
                        No results found for "{searchQuery}"
                      </p>
                      <p className="text-xs text-muted-foreground/60 mt-1">
                        Try different keywords
                      </p>
                    </div>
                  ) : (
                    <div className="divide-y divide-border">
                      {searchResults.map((result, index) => {
                        const Icon = result.icon;
                        return (
                          <motion.button
                            key={result.id}
                            initial={{ opacity: 0, x: -20 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ delay: index * 0.05 }}
                            onClick={() => handleResultClick(result)}
                            className="w-full p-4 flex items-center gap-4 hover:bg-muted/50 transition-colors group"
                          >
                            <div className={`${result.color} p-2.5 rounded-lg text-white flex-shrink-0`}>
                              <Icon className="h-4 w-4" />
                            </div>
                            <div className="flex-1 text-left">
                              <p className="text-sm font-medium group-hover:text-primary transition-colors">
                                {result.title}
                              </p>
                              <p className="text-xs text-muted-foreground">
                                {result.subtitle}
                              </p>
                            </div>
                            <div className="flex items-center gap-2 flex-shrink-0">
                              <Badge variant="secondary" className="text-xs">
                                {result.category}
                              </Badge>
                              <ArrowRight className="h-4 w-4 text-muted-foreground group-hover:text-primary transition-colors" />
                            </div>
                          </motion.button>
                        );
                      })}
                    </div>
                  )}
                </div>

                {/* Footer */}
                {searchResults.length > 0 && (
                  <div className="p-3 border-t border-border bg-muted/30">
                    <p className="text-xs text-center text-muted-foreground">
                      {searchResults.length} result{searchResults.length !== 1 ? "s" : ""} found
                    </p>
                  </div>
                )}
              </Card>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
