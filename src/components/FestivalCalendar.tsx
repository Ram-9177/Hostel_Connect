import { Calendar, Sparkles } from "lucide-react";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import { motion } from "motion/react";

interface Festival {
  date: string;
  name: string;
  nameTe: string;
  type: "major" | "minor";
  holiday: boolean;
}

export function FestivalCalendar() {
  // Sample festivals for 2025 (Andhra Pradesh & Telangana)
  const upcomingFestivals: Festival[] = [
    {
      date: "14 Jan 2025",
      name: "Sankranti",
      nameTe: "సంక్రాంతి",
      type: "major",
      holiday: true,
    },
    {
      date: "26 Jan 2025",
      name: "Republic Day",
      nameTe: "రిపబ్లిక్ డే",
      type: "major",
      holiday: true,
    },
    {
      date: "26 Feb 2025",
      name: "Maha Shivaratri",
      nameTe: "మహా శివరాత్రి",
      type: "major",
      holiday: true,
    },
    {
      date: "14 Mar 2025",
      name: "Holi",
      nameTe: "హోలీ",
      type: "major",
      holiday: true,
    },
    {
      date: "10 Apr 2025",
      name: "Ugadi (Telugu New Year)",
      nameTe: "ఉగాది",
      type: "major",
      holiday: true,
    },
  ];

  const today = new Date();
  const nextFestival = upcomingFestivals[0];

  return (
    <Card className="p-5 border-0 shadow-md bg-gradient-to-br from-card to-orange-50/30">
      <div className="flex items-center gap-3 mb-4">
        <div className="p-2 bg-orange-100 rounded-lg">
          <Sparkles className="h-5 w-5 text-orange-600" />
        </div>
        <div className="flex-1">
          <h3 className="font-semibold">Upcoming Festivals</h3>
          <p className="text-sm text-muted-foreground">రాబోయే పండుగలు</p>
        </div>
      </div>

      {/* Next Festival Highlight */}
      <motion.div
        className="p-4 bg-gradient-to-r from-orange-500 to-orange-600 text-white rounded-xl mb-3"
        whileHover={{ scale: 1.02 }}
        transition={{ type: "spring", stiffness: 300 }}
      >
        <div className="flex items-center justify-between mb-2">
          <div>
            <p className="text-sm opacity-90">Next Holiday</p>
            <h4 className="font-semibold">{nextFestival.name}</h4>
            <p className="text-sm opacity-90">{nextFestival.nameTe}</p>
          </div>
          <Calendar className="h-8 w-8 opacity-80" />
        </div>
        <div className="flex items-center gap-2">
          <Badge className="bg-white/20 text-white border-white/30">
            {nextFestival.date}
          </Badge>
          {nextFestival.holiday && (
            <Badge className="bg-green-500 text-white">Hostel Holiday</Badge>
          )}
        </div>
      </motion.div>

      {/* Other Festivals */}
      <div className="space-y-2">
        {upcomingFestivals.slice(1, 4).map((festival, index) => (
          <div
            key={index}
            className="flex items-center justify-between p-3 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors"
          >
            <div>
              <p className="text-sm font-medium">{festival.name}</p>
              <p className="text-xs text-muted-foreground">{festival.nameTe}</p>
            </div>
            <div className="text-right">
              <p className="text-xs text-muted-foreground">{festival.date}</p>
              {festival.holiday && (
                <Badge variant="outline" className="text-xs mt-1">
                  Holiday
                </Badge>
              )}
            </div>
          </div>
        ))}
      </div>

      <p className="text-xs text-center text-muted-foreground mt-3">
        Regional festivals for AP & Telangana
      </p>
    </Card>
  );
}
