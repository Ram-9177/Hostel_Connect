import { ArrowLeft, Users, FileText, CheckCircle, ScanLine, UserCheck, Home, UserCircle, BarChart3, ClipboardList, AlertCircle, MessageSquare, Settings } from "lucide-react";
import { Card } from "../ui/card";
import { UpdatedTime } from "../UpdatedTime";
import { AdBanner } from "../AdBanner";
import { Bar, BarChart, CartesianGrid, Cell, Legend, Pie, PieChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { premiumColors, roleColors, premiumShadows } from "../../styles/premium-design-tokens";

interface WardenDashboardProps {
  onBack: () => void;
  onNavigate?: (page: string) => void;
}

export function WardenDashboard({ onBack, onNavigate }: WardenDashboardProps) {
  const wardenColors = roleColors.WARDEN;
  
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
    { name: "Kiosk Scan", value: 149, color: premiumColors.success[600] },
    { name: "Manual (Warden)", value: 6, color: premiumColors.warning[600] },
  ];

  const quickActions = [
    { id: "rooms", label: "Rooms", icon: Home, color: premiumColors.primary[700], description: "Manage rooms" },
    { id: "attendance", label: "Attendance", icon: UserCheck, color: premiumColors.success[600], description: "Track attendance" },
    { id: "student-records", label: "Students", icon: UserCircle, color: premiumColors.secondary[600], description: "Student records" },
    { id: "analytics", label: "Analytics", icon: BarChart3, color: "#4F46E5", description: "View reports" },
    { id: "manual-gate-pass", label: "Gate Pass", icon: ClipboardList, color: premiumColors.warning[600], description: "Manual approval" },
    { id: "emergency-requests", label: "Emergency", icon: AlertCircle, color: premiumColors.error[600], description: "Emergency requests" },
    { id: "complaints", label: "Complaints", icon: MessageSquare, color: "#D97706", description: "Handle complaints" },
    { id: "settings", label: "Settings", icon: Settings, color: premiumColors.neutral[600], description: "App settings" },
  ];

  return (
    <div className="min-h-screen bg-background pb-8">
      {/* Premium Header */}
      <div 
        className="text-white p-4 flex items-center gap-3"
        style={{
          background: wardenColors.gradient,
          boxShadow: premiumShadows.primaryGlow,
        }}
      >
        <button onClick={onBack} className="p-1 hover:bg-white/10 rounded-lg transition-colors">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <div className="flex-1">
          <h1 className="text-xl font-semibold">Warden Dashboard</h1>
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
          <Card 
            className="p-4 space-y-2 border-0"
            style={{ boxShadow: premiumShadows.md }}
          >
            <div className="flex items-center gap-2 text-muted-foreground">
              <Users className="h-4 w-4" />
              <p className="text-sm">Total Strength</p>
            </div>
            <p className="text-3xl font-bold" style={{ color: premiumColors.primary[700] }}>180</p>
          </Card>

          <Card 
            className="p-4 space-y-2 border-0"
            style={{ boxShadow: premiumShadows.md }}
          >
            <div className="flex items-center gap-2 text-muted-foreground">
              <FileText className="h-4 w-4" />
              <p className="text-sm">On Outpass</p>
            </div>
            <p className="text-3xl font-bold" style={{ color: premiumColors.secondary[600] }}>25</p>
          </Card>

          <Card 
            className="p-4 space-y-2 border-0"
            style={{ boxShadow: premiumShadows.md }}
          >
            <div className="flex items-center gap-2 text-muted-foreground">
              <CheckCircle className="h-4 w-4" />
              <p className="text-sm">Present (Derived)</p>
            </div>
            <p className="text-3xl font-bold" style={{ color: premiumColors.success[600] }}>155</p>
            <p className="text-xs text-muted-foreground">Total - Outpass</p>
          </Card>

          <Card 
            className="p-4 space-y-2 border-0"
            style={{ boxShadow: premiumShadows.md }}
          >
            <div className="flex items-center gap-2 text-muted-foreground">
              <ScanLine className="h-4 w-4" />
              <p className="text-sm">Scanned %</p>
            </div>
            <p className="text-3xl font-bold" style={{ color: premiumColors.primary[700] }}>96%</p>
            <p className="text-xs text-muted-foreground">149 of 155</p>
          </Card>

          <Card 
            className="p-4 space-y-2 border-0 col-span-2"
            style={{ boxShadow: premiumShadows.md }}
          >
            <div className="flex items-center gap-2 text-muted-foreground">
              <UserCheck className="h-4 w-4" />
              <p className="text-sm">Manual (Warden Verified)</p>
            </div>
            <div className="flex items-baseline gap-2">
              <p className="text-3xl font-bold" style={{ color: premiumColors.warning[600] }}>6</p>
              <p className="text-sm text-muted-foreground">students (4% of present)</p>
            </div>
          </Card>
        </div>

        {/* Quick Actions */}
        <div className="space-y-3">
          <h3 className="font-semibold">Quick Actions</h3>
          <div className="grid grid-cols-2 gap-3">
            {quickActions.map((action) => {
              const Icon = action.icon;
              return (
                <Card
                  key={action.id}
                  className="p-4 cursor-pointer hover:shadow-2xl transition-all active:scale-95 border-0"
                  style={{ boxShadow: premiumShadows.md }}
                  onClick={() => onNavigate?.(action.id)}
                >
                  <div className="flex items-start gap-3">
                    <div 
                      className="w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0"
                      style={{ 
                        backgroundColor: action.color,
                        boxShadow: premiumShadows.sm,
                      }}
                    >
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
