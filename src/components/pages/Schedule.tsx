import { ArrowLeft, Calendar, Clock, Book, MapPin, User, ChevronLeft, ChevronRight } from "lucide-react";
import { Card } from "../ui/card";
import { Badge } from "../ui/badge";
import { useState } from "react";
import { premiumColors, roleColors, premiumShadows } from "../../styles/premium-design-tokens";

interface ScheduleProps {
  onBack: () => void;
}

type DayName = "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday";

const DAYS: DayName[] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
const TIME_SLOTS = [
  "08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", 
  "12:00 PM", "01:00 PM", "02:00 PM", "03:00 PM", 
  "04:00 PM", "05:00 PM", "06:00 PM"
];

interface ClassItem {
  time: string;
  subject: string;
  room: string;
  instructor: string;
  color: string;
}

// Mock schedule data - Replace with API
const SCHEDULE_DATA: Record<DayName, ClassItem[]> = {
  Monday: [
    { time: "09:00 AM", subject: "Data Structures", room: "CS-101", instructor: "Dr. Sharma", color: premiumColors.primary[600] },
    { time: "11:00 AM", subject: "Database Management", room: "CS-203", instructor: "Prof. Kumar", color: premiumColors.secondary[600] },
    { time: "02:00 PM", subject: "Web Development", room: "CS-305", instructor: "Dr. Patel", color: premiumColors.success[600] },
  ],
  Tuesday: [
    { time: "10:00 AM", subject: "Operating Systems", room: "CS-102", instructor: "Dr. Reddy", color: premiumColors.warning[600] },
    { time: "01:00 PM", subject: "Computer Networks", room: "CS-204", instructor: "Prof. Rao", color: premiumColors.error[600] },
    { time: "04:00 PM", subject: "Software Engineering", room: "CS-306", instructor: "Dr. Singh", color: "#4F46E5" },
  ],
  Wednesday: [
    { time: "09:00 AM", subject: "Data Structures", room: "CS-101", instructor: "Dr. Sharma", color: premiumColors.primary[600] },
    { time: "12:00 PM", subject: "Algorithm Analysis", room: "CS-205", instructor: "Prof. Gupta", color: premiumColors.secondary[500] },
  ],
  Thursday: [
    { time: "10:00 AM", subject: "Operating Systems", room: "CS-102", instructor: "Dr. Reddy", color: premiumColors.warning[600] },
    { time: "02:00 PM", subject: "Web Development", room: "CS-305", instructor: "Dr. Patel", color: premiumColors.success[600] },
  ],
  Friday: [
    { time: "11:00 AM", subject: "Database Management", room: "CS-203", instructor: "Prof. Kumar", color: premiumColors.secondary[600] },
    { time: "03:00 PM", subject: "Software Engineering", room: "CS-306", instructor: "Dr. Singh", color: "#4F46E5" },
  ],
  Saturday: [
    { time: "10:00 AM", subject: "Lab - Data Structures", room: "CS-Lab-1", instructor: "Dr. Sharma", color: premiumColors.primary[700] },
    { time: "02:00 PM", subject: "Lab - Web Development", room: "CS-Lab-2", instructor: "Dr. Patel", color: premiumColors.success[700] },
  ],
};

export function Schedule({ onBack }: ScheduleProps) {
  const [selectedDay, setSelectedDay] = useState<DayName>(DAYS[new Date().getDay() - 1] || DAYS[0]);
  const studentColors = roleColors.STUDENT;
  
  const todaysClasses: ClassItem[] = SCHEDULE_DATA[selectedDay] || [];

  const handlePreviousDay = () => {
    const currentIndex = DAYS.indexOf(selectedDay);
    const newIndex = currentIndex === 0 ? DAYS.length - 1 : currentIndex - 1;
    setSelectedDay(DAYS[newIndex]);
  };

  const handleNextDay = () => {
    const currentIndex = DAYS.indexOf(selectedDay);
    const newIndex = currentIndex === DAYS.length - 1 ? 0 : currentIndex + 1;
    setSelectedDay(DAYS[newIndex]);
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Premium Header */}
      <div 
        className="text-white p-4 pb-8"
        style={{
          background: studentColors.gradient,
          boxShadow: premiumShadows.primaryGlow,
        }}
      >
        <div className="flex items-center gap-3 mb-6">
          <button 
            onClick={onBack} 
            className="p-2 hover:bg-white/10 rounded-lg transition-colors"
          >
            <ArrowLeft className="h-5 w-5" />
          </button>
          <div className="flex-1">
            <h1 className="text-xl font-semibold">Class Schedule</h1>
            <p className="text-xs opacity-90 mt-0.5">Academic Timetable</p>
          </div>
        </div>

        {/* Day Navigator */}
        <div className="flex items-center justify-between gap-3 bg-white/10 backdrop-blur-sm rounded-2xl p-3">
          <button
            onClick={handlePreviousDay}
            className="p-2 hover:bg-white/10 rounded-lg transition-colors"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
          <div className="flex-1 text-center">
            <p className="text-lg font-semibold">{selectedDay}</p>
            <p className="text-xs opacity-75">{todaysClasses.length} Classes Today</p>
          </div>
          <button
            onClick={handleNextDay}
            className="p-2 hover:bg-white/10 rounded-lg transition-colors"
          >
            <ChevronRight className="h-5 w-5" />
          </button>
        </div>
      </div>

      <div className="p-4 space-y-4">
        {/* Quick Stats */}
        <div className="grid grid-cols-3 gap-3">
          <Card 
            className="p-3 text-center border-0"
            style={{ boxShadow: premiumShadows.sm }}
          >
            <div className="flex items-center justify-center w-10 h-10 rounded-full bg-blue-100 dark:bg-blue-950 mx-auto mb-2">
              <Calendar className="h-5 w-5" style={{ color: premiumColors.primary[600] }} />
            </div>
            <p className="text-xs text-muted-foreground mb-1">This Week</p>
            <p className="text-lg font-bold" style={{ color: premiumColors.primary[700] }}>24</p>
            <p className="text-xs text-muted-foreground">Classes</p>
          </Card>

          <Card 
            className="p-3 text-center border-0"
            style={{ boxShadow: premiumShadows.sm }}
          >
            <div className="flex items-center justify-center w-10 h-10 rounded-full bg-green-100 dark:bg-green-950 mx-auto mb-2">
              <Clock className="h-5 w-5" style={{ color: premiumColors.success[600] }} />
            </div>
            <p className="text-xs text-muted-foreground mb-1">Total</p>
            <p className="text-lg font-bold" style={{ color: premiumColors.success[600] }}>30</p>
            <p className="text-xs text-muted-foreground">Hours/Week</p>
          </Card>

          <Card 
            className="p-3 text-center border-0"
            style={{ boxShadow: premiumShadows.sm }}
          >
            <div className="flex items-center justify-center w-10 h-10 rounded-full bg-purple-100 dark:bg-purple-950 mx-auto mb-2">
              <Book className="h-5 w-5" style={{ color: premiumColors.secondary[600] }} />
            </div>
            <p className="text-xs text-muted-foreground mb-1">Subjects</p>
            <p className="text-lg font-bold" style={{ color: premiumColors.secondary[600] }}>8</p>
            <p className="text-xs text-muted-foreground">Courses</p>
          </Card>
        </div>

        {/* Day Tabs */}
        <div className="flex overflow-x-auto gap-2 pb-2 scrollbar-hide">
          {DAYS.map((day) => (
            <button
              key={day}
              onClick={() => setSelectedDay(day)}
              className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all flex-shrink-0 ${
                selectedDay === day
                  ? 'text-white shadow-lg'
                  : 'bg-muted/50 hover:bg-muted'
              }`}
              style={selectedDay === day ? {
                background: studentColors.gradient,
                boxShadow: premiumShadows.sm,
              } : {}}
            >
              <p className="text-sm font-semibold">{day.substring(0, 3)}</p>
            </button>
          ))}
        </div>

        {/* Class List */}
        <div className="space-y-3">
          <h2 className="font-semibold">Today's Classes</h2>
          
          {todaysClasses.length === 0 ? (
            <Card 
              className="p-8 text-center border-0"
              style={{ boxShadow: premiumShadows.md }}
            >
              <Calendar className="h-16 w-16 mx-auto mb-4 text-muted-foreground opacity-50" />
              <h3 className="text-lg font-semibold mb-2">No Classes Today</h3>
              <p className="text-sm text-muted-foreground">
                Enjoy your free day! Use this time to catch up on assignments or relax.
              </p>
            </Card>
          ) : (
            todaysClasses.map((classItem: ClassItem, index: number) => (
              <Card
                key={index}
                className="p-4 border-0 hover:shadow-xl transition-all cursor-pointer"
                style={{ 
                  boxShadow: premiumShadows.md,
                  borderLeft: `4px solid ${classItem.color}`,
                }}
              >
                <div className="flex items-start gap-3">
                  <div 
                    className="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
                    style={{ 
                      backgroundColor: classItem.color,
                      boxShadow: premiumShadows.sm,
                    }}
                  >
                    <Book className="h-6 w-6 text-white" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between gap-2 mb-2">
                      <h3 className="font-semibold text-base">{classItem.subject}</h3>
                      <Badge 
                        variant="secondary" 
                        className="text-xs whitespace-nowrap"
                        style={{ color: classItem.color }}
                      >
                        {classItem.time}
                      </Badge>
                    </div>
                    <div className="space-y-1.5">
                      <div className="flex items-center gap-2 text-sm text-muted-foreground">
                        <User className="h-4 w-4" />
                        <span>{classItem.instructor}</span>
                      </div>
                      <div className="flex items-center gap-2 text-sm text-muted-foreground">
                        <MapPin className="h-4 w-4" />
                        <span>{classItem.room}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </Card>
            ))
          )}
        </div>

        {/* Weekly Overview */}
        <Card 
          className="p-4 border-0"
          style={{ boxShadow: premiumShadows.md }}
        >
          <h3 className="font-semibold mb-3">Week at a Glance</h3>
          <div className="grid grid-cols-6 gap-2">
            {DAYS.map((day: DayName) => {
              const dayClasses: ClassItem[] = SCHEDULE_DATA[day] || [];
              return (
                <div key={day} className="text-center">
                  <p className="text-xs font-semibold mb-2">{day.substring(0, 3)}</p>
                  <div className="space-y-1">
                    {dayClasses.length > 0 ? (
                      dayClasses.slice(0, 3).map((_: ClassItem, idx: number) => (
                        <div 
                          key={idx} 
                          className="h-1.5 rounded-full"
                          style={{ backgroundColor: premiumColors.primary[400] }}
                        />
                      ))
                    ) : (
                      <div className="h-1.5 rounded-full bg-muted" />
                    )}
                  </div>
                  <p className="text-xs text-muted-foreground mt-1">
                    {dayClasses.length}
                  </p>
                </div>
              );
            })}
          </div>
        </Card>
      </div>
    </div>
  );
}
