import { ArrowLeft, Settings, TrendingUp, Thermometer, Home, UserCircle, BarChart3, ClipboardList, AlertCircle } from "lucide-react";
import { Card } from "../ui/card";
import { UpdatedTime } from "../UpdatedTime";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { Label } from "../ui/label";
import { Area, AreaChart, CartesianGrid, Legend, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";

interface WardenHeadDashboardProps {
  onBack: () => void;
  onNavigate?: (page: string) => void;
}

export function WardenHeadDashboard({ onBack, onNavigate }: WardenHeadDashboardProps) {
  const quickActions = [
    { id: "rooms", label: "Rooms", icon: Home, color: "bg-blue-600", description: "Manage all hostel rooms" },
    { id: "student-records", label: "Students", icon: UserCircle, color: "bg-purple-600", description: "View all student records" },
    { id: "analytics", label: "Analytics", icon: BarChart3, color: "bg-indigo-600", description: "View detailed analytics" },
    { id: "manual-gate-pass", label: "Gate Pass", icon: ClipboardList, color: "bg-orange-600", description: "Manage gate passes" },
    { id: "emergency-requests", label: "Emergency", icon: AlertCircle, color: "bg-red-600", description: "View emergency requests" },
    { id: "settings", label: "Settings", icon: Settings, color: "bg-gray-600", description: "Dashboard settings" },
  ];

  const floorHeatmap = [
    { floor: "Floor 1", attendance: 95, occupancy: 98 },
    { floor: "Floor 2", attendance: 88, occupancy: 95 },
    { floor: "Floor 3", attendance: 92, occupancy: 100 },
  ];

  const mealForecast = [
    { day: "Mon", breakfast: 165, lunch: 172, dinner: 168 },
    { day: "Tue", breakfast: 168, lunch: 175, dinner: 170 },
    { day: "Wed", breakfast: 162, lunch: 170, dinner: 165 },
    { day: "Thu", breakfast: 170, lunch: 178, dinner: 172 },
    { day: "Fri", breakfast: 158, lunch: 168, dinner: 160 },
    { day: "Sat", breakfast: 155, lunch: 165, dinner: 158 },
    { day: "Sun", breakfast: 160, lunch: 170, dinner: 162 },
  ];

  const getHeatColor = (value: number) => {
    if (value >= 95) return "bg-green-500";
    if (value >= 85) return "bg-yellow-500";
    if (value >= 75) return "bg-orange-500";
    return "bg-red-500";
  };

  return (
    <div className="min-h-screen bg-background pb-8">
      {/* Header */}
      <div className="bg-gradient-to-r from-indigo-600 to-indigo-700 text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <div className="flex-1">
          <h1 className="text-xl">Warden Head Dashboard</h1>
          <p className="text-xs opacity-90 mt-0.5">All Hostels Overview</p>
        </div>
      </div>

      <div className="p-4">
        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-4">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="forecast">Forecast</TabsTrigger>
            <TabsTrigger value="policy">Policy</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4">
            {/* Quick Actions Section */}
            <div className="space-y-3">
              <h3 className="text-base font-semibold">Quick Actions</h3>
              <div className="grid grid-cols-2 gap-3">
                {quickActions.map((action) => {
                  const Icon = action.icon;
                  return (
                    <Card
                      key={action.id}
                      className="p-4 cursor-pointer hover:shadow-lg transition-shadow border-0"
                      onClick={() => onNavigate?.(action.id)}
                    >
                      <div className="flex items-start gap-3">
                        <div className={`${action.color} w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0`}>
                          <Icon className="h-5 w-5 text-white" />
                        </div>
                        <div className="flex-1 min-w-0">
                          <h4 className="font-medium text-sm">{action.label}</h4>
                          <p className="text-xs text-muted-foreground mt-0.5">{action.description}</p>
                        </div>
                      </div>
                    </Card>
                  );
                })}
              </div>
            </div>

            <div className="flex items-center justify-between">
              <h3>Floor-wise Heatmap</h3>
              <UpdatedTime />
            </div>

            {/* Attendance Heatmap */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <div className="flex items-center gap-2">
                <Thermometer className="h-5 w-5 text-primary" />
                <h4>Attendance % by Floor</h4>
              </div>

              <div className="space-y-3">
                {floorHeatmap.map((floor) => (
                  <div key={floor.floor} className="space-y-2">
                    <div className="flex items-center justify-between text-sm">
                      <span>{floor.floor}</span>
                      <span>{floor.attendance}%</span>
                    </div>
                    <div className="h-8 bg-muted rounded-full overflow-hidden">
                      <div
                        className={`h-full ${getHeatColor(floor.attendance)} transition-all`}
                        style={{ width: `${floor.attendance}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </Card>

            {/* Occupancy Heatmap */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <h4>Room Occupancy % by Floor</h4>

              <div className="space-y-3">
                {floorHeatmap.map((floor) => (
                  <div key={floor.floor} className="space-y-2">
                    <div className="flex items-center justify-between text-sm">
                      <span>{floor.floor}</span>
                      <span>{floor.occupancy}%</span>
                    </div>
                    <div className="h-8 bg-muted rounded-full overflow-hidden">
                      <div
                        className={`h-full ${getHeatColor(floor.occupancy)} transition-all`}
                        style={{ width: `${floor.occupancy}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </Card>

            {/* Override Panel */}
            <Card className="p-5 space-y-4 border-0 shadow-sm bg-amber-50 dark:bg-amber-950">
              <div className="flex items-center gap-2">
                <Settings className="h-5 w-5 text-amber-600" />
                <h4>Override Panel</h4>
              </div>

              <div className="space-y-3">
                <Button variant="outline" className="w-full justify-start">
                  Force Mark Attendance (Emergency)
                </Button>
                <Button variant="outline" className="w-full justify-start">
                  Bulk Gate Pass Approval
                </Button>
                <Button variant="outline" className="w-full justify-start">
                  Override Meal Cutoff
                </Button>
              </div>
            </Card>
          </TabsContent>

          <TabsContent value="forecast" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Weekly Meal Forecast</h3>
              <UpdatedTime />
            </div>

            {/* Meal Trend Graph */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <div className="flex items-center gap-2">
                <TrendingUp className="h-5 w-5 text-primary" />
                <h4>Meal Count Trends</h4>
              </div>

              <div className="h-72">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={mealForecast}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="day" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Line
                      type="monotone"
                      dataKey="breakfast"
                      stroke="#F59E0B"
                      strokeWidth={2}
                      name="Breakfast"
                    />
                    <Line
                      type="monotone"
                      dataKey="lunch"
                      stroke="#10B981"
                      strokeWidth={2}
                      name="Lunch"
                    />
                    <Line
                      type="monotone"
                      dataKey="dinner"
                      stroke="#3B82F6"
                      strokeWidth={2}
                      name="Dinner"
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </Card>

            {/* Forecast Summary */}
            <div className="grid grid-cols-3 gap-3">
              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-amber-600">165</p>
                <p className="text-xs text-muted-foreground mt-1">Avg Breakfast</p>
              </Card>

              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-green-600">172</p>
                <p className="text-xs text-muted-foreground mt-1">Avg Lunch</p>
              </Card>

              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-blue-600">167</p>
                <p className="text-xs text-muted-foreground mt-1">Avg Dinner</p>
              </Card>
            </div>

            {/* Buffer Analysis */}
            <Card className="p-5 space-y-3 border-0 shadow-sm">
              <h4>Buffer Recommendations</h4>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Current Buffer:</span>
                  <span>10%</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Suggested for Tomorrow:</span>
                  <span className="text-green-600">8%</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Wastage Last Week:</span>
                  <span className="text-destructive">12%</span>
                </div>
              </div>
            </Card>
          </TabsContent>

          <TabsContent value="policy" className="space-y-4">
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <h3>Policy Settings</h3>

              <div className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="curfew">Curfew Time</Label>
                  <Input id="curfew" type="time" defaultValue="22:00" />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="meal-cutoff">Meal Selection Cutoff</Label>
                  <Input id="meal-cutoff" type="time" defaultValue="23:00" />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="min-attendance">Minimum Attendance %</Label>
                  <Input
                    id="min-attendance"
                    type="number"
                    defaultValue="75"
                    min="0"
                    max="100"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="buffer">Meal Buffer %</Label>
                  <Input
                    id="buffer"
                    type="number"
                    defaultValue="10"
                    min="0"
                    max="50"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="manual-limit">Manual Attendance Limit</Label>
                  <Input
                    id="manual-limit"
                    type="number"
                    defaultValue="5"
                    min="0"
                    max="20"
                  />
                  <p className="text-xs text-muted-foreground">
                    Maximum % of manual attendance allowed
                  </p>
                </div>

                <Button className="w-full bg-primary hover:bg-primary/90">
                  Save Policy Changes
                </Button>
              </div>
            </Card>

            {/* Recent Changes */}
            <Card className="p-5 space-y-3 border-0 shadow-sm">
              <h4>Recent Policy Changes</h4>
              <div className="space-y-2">
                {[
                  { change: "Curfew extended to 23:00", date: "Oct 15" },
                  { change: "Buffer reduced to 10%", date: "Oct 10" },
                  { change: "Min attendance set to 75%", date: "Oct 1" },
                ].map((item, i) => (
                  <div
                    key={i}
                    className="flex justify-between items-center text-sm p-2 bg-muted/30 rounded-lg"
                  >
                    <span>{item.change}</span>
                    <span className="text-muted-foreground">{item.date}</span>
                  </div>
                ))}
              </div>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
