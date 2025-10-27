import { ArrowLeft, Users, FileText, CheckCircle, ScanLine, UserCheck, Home, UserCircle, BarChart3, ClipboardList, AlertCircle, MessageSquare, Settings } from "lucide-react";
import { Card } from "../ui/card";
import { UpdatedTime } from "../UpdatedTime";
import { AdBanner } from "../AdBanner";
import { Bar, BarChart, CartesianGrid, Cell, Legend, Pie, PieChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";

interface WardenDashboardProps {
  onBack: () => void;
  onNavigate?: (page: string) => void;
}

export function WardenDashboard({ onBack, onNavigate }: WardenDashboardProps) {
  const trendData = [
    { day: "Mon", kiosk: 145, manual: 8 },
    { day: "Tue", kiosk: 152, manual: 5 },
    { day: "Wed", kiosk: 148, manual: 7 },
    { day: "Thu", kiosk: 155, manual: 4 },
    { day: "Fri", kiosk: 142, manual: 9 },
    { day: "Sat", kiosk: 138, manual: 11 },
    { day: "Sun", kiosk: 149, manual: 6 },
  ];

  const pieData = [
    { name: "Kiosk Scan", value: 149, color: "#10B981" },
    { name: "Manual (Warden)", value: 6, color: "#F59E0B" },
  ];

  const quickActions = [
    { id: "rooms", label: "Rooms", icon: Home, color: "bg-blue-600", description: "Manage rooms" },
    { id: "attendance", label: "Attendance", icon: UserCheck, color: "bg-green-600", description: "Track attendance" },
    { id: "student-records", label: "Students", icon: UserCircle, color: "bg-purple-600", description: "Student records" },
    { id: "analytics", label: "Analytics", icon: BarChart3, color: "bg-indigo-600", description: "View reports" },
    { id: "manual-gate-pass", label: "Gate Pass", icon: ClipboardList, color: "bg-orange-600", description: "Manual approval" },
    { id: "emergency-requests", label: "Emergency", icon: AlertCircle, color: "bg-red-600", description: "Emergency requests" },
    { id: "complaints", label: "Complaints", icon: MessageSquare, color: "bg-amber-600", description: "Handle complaints" },
    { id: "settings", label: "Settings", icon: Settings, color: "bg-gray-600", description: "App settings" },
  ];

  return (
    <div className="min-h-screen bg-background pb-8">
      {/* Header */}
      <div className="bg-gradient-to-r from-purple-600 to-purple-700 text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <div className="flex-1">
          <h1 className="text-xl">Warden Dashboard</h1>
          <p className="text-xs opacity-90 mt-0.5">Phoenix Hall</p>
        </div>
      </div>

      <div className="p-4 space-y-4">
        {/* Key Metrics */}
        <div className="flex items-center justify-between">
          <h2>Today's Overview</h2>
          <UpdatedTime />
        </div>

        <div className="grid grid-cols-2 gap-3">
          <Card className="p-4 space-y-2 border-0 shadow-sm">
            <div className="flex items-center gap-2 text-muted-foreground">
              <Users className="h-4 w-4" />
              <p className="text-sm">Total Strength</p>
            </div>
            <p className="text-3xl text-primary">180</p>
          </Card>

          <Card className="p-4 space-y-2 border-0 shadow-sm">
            <div className="flex items-center gap-2 text-muted-foreground">
              <FileText className="h-4 w-4" />
              <p className="text-sm">On Outpass</p>
            </div>
            <p className="text-3xl text-blue-600">25</p>
          </Card>

          <Card className="p-4 space-y-2 border-0 shadow-sm">
            <div className="flex items-center gap-2 text-muted-foreground">
              <CheckCircle className="h-4 w-4" />
              <p className="text-sm">Present (Derived)</p>
            </div>
            <p className="text-3xl text-green-600">155</p>
            <p className="text-xs text-muted-foreground">Total - Outpass</p>
          </Card>

          <Card className="p-4 space-y-2 border-0 shadow-sm">
            <div className="flex items-center gap-2 text-muted-foreground">
              <ScanLine className="h-4 w-4" />
              <p className="text-sm">Scanned %</p>
            </div>
            <p className="text-3xl text-primary">96%</p>
            <p className="text-xs text-muted-foreground">149 of 155</p>
          </Card>

          <Card className="p-4 space-y-2 border-0 shadow-sm col-span-2">
            <div className="flex items-center gap-2 text-muted-foreground">
              <UserCheck className="h-4 w-4" />
              <p className="text-sm">Manual (Warden Verified)</p>
            </div>
            <div className="flex items-baseline gap-2">
              <p className="text-3xl text-amber-600">6</p>
              <p className="text-sm text-muted-foreground">students (4% of present)</p>
            </div>
          </Card>
        </div>

        {/* Quick Actions */}
        <div className="space-y-3">
          <h3>Quick Actions</h3>
          <div className="grid grid-cols-2 gap-3">
            {quickActions.map((action) => {
              const Icon = action.icon;
              return (
                <Card
                  key={action.id}
                  className="p-4 cursor-pointer hover:shadow-lg transition-all active:scale-95 border-0 shadow-sm"
                  onClick={() => onNavigate?.(action.id)}
                >
                  <div className="flex items-start gap-3">
                    <div className={`${action.color} w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0`}>
                      <Icon className="h-5 w-5 text-white" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <h4 className="text-sm font-semibold mb-0.5">{action.label}</h4>
                      <p className="text-xs text-muted-foreground truncate">{action.description}</p>
                    </div>
                  </div>
                </Card>
              );
            })}
          </div>
        </div>

        {/* Attendance Split Pie Chart */}
        <Card className="p-5 space-y-4 border-0 shadow-sm">
          <div className="flex items-center justify-between">
            <h3>Today's Attendance Method</h3>
            <UpdatedTime time="18:30" />
          </div>

          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={pieData}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) =>
                    `${name}: ${(percent * 100).toFixed(0)}%`
                  }
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {pieData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
                <Legend />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </Card>

        {/* Weekly Trend */}
        <Card className="p-5 space-y-4 border-0 shadow-sm">
          <div className="flex items-center justify-between">
            <h3>Weekly Attendance Trend</h3>
            <UpdatedTime time="18:30" />
          </div>

          <div className="h-72">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={trendData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="day" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="kiosk" fill="#10B981" name="Kiosk Scan" />
                <Bar dataKey="manual" fill="#F59E0B" name="Manual" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </Card>

        {/* Quick Stats */}
        <Card className="p-5 space-y-3 border-0 shadow-sm">
          <h3>Additional Stats</h3>
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Total Rooms:</span>
              <span>60</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Occupied Rooms:</span>
              <span className="text-green-600">58 (97%)</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Active Gate Passes:</span>
              <span className="text-blue-600">25</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Pending Complaints:</span>
              <span className="text-destructive">7</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Mess Opt-in (Tomorrow):</span>
              <span>172 (96%)</span>
            </div>
          </div>
        </Card>
      </div>

      {/* Bottom Ad Banner */}
      <div className="mt-4">
        <AdBanner content="Warden Portal: Access advanced reports and analytics" />
      </div>
    </div>
  );
}
