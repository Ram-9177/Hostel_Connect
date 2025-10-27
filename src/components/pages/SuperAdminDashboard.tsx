import { ArrowLeft, Building2, TrendingUp, Users, DollarSign, ShieldCheck, Home, UserCircle, BarChart3, ClipboardList, AlertCircle, Shield, Settings, Eye } from "lucide-react";
import { Card } from "../ui/card";
import { UpdatedTime } from "../UpdatedTime";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Badge } from "../ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "../ui/table";
import { Area, AreaChart, Bar, BarChart, CartesianGrid, Cell, Legend, Line, LineChart, Pie, PieChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";

interface SuperAdminDashboardProps {
  onBack: () => void;
  onNavigate?: (page: string) => void;
}

export function SuperAdminDashboard({ onBack, onNavigate }: SuperAdminDashboardProps) {
  const quickActions = [
    { id: "warden", label: "Warden View", icon: Eye, color: "bg-blue-600", description: "View warden dashboard" },
    { id: "warden-head", label: "Warden Head", icon: Eye, color: "bg-indigo-600", description: "View warden head dashboard" },
    { id: "rooms", label: "Rooms", icon: Home, color: "bg-green-600", description: "Manage all rooms" },
    { id: "student-records", label: "Students", icon: UserCircle, color: "bg-purple-600", description: "Student management" },
    { id: "analytics", label: "Analytics", icon: BarChart3, color: "bg-cyan-600", description: "View analytics" },
    { id: "manual-gate-pass", label: "Gate Pass", icon: ClipboardList, color: "bg-orange-600", description: "Manage gate passes" },
    { id: "emergency-requests", label: "Emergency", icon: AlertCircle, color: "bg-red-600", description: "Emergency requests" },
    { id: "gate-security", label: "Security", icon: Shield, color: "bg-rose-600", description: "Gate security view" },
    { id: "settings", label: "Settings", icon: Settings, color: "bg-gray-600", description: "System settings" },
  ];

  const hostels = [
    { name: "Phoenix Hall", students: 180, attendance: 86, occupancy: 97 },
    { name: "Aurora Block", students: 200, attendance: 91, occupancy: 95 },
    { name: "Zenith Tower", students: 150, attendance: 88, occupancy: 100 },
    { name: "Horizon Wing", students: 175, attendance: 84, occupancy: 92 },
  ];

  const attendanceTrend = [
    { date: "Oct 1", phoenix: 85, aurora: 90, zenith: 87, horizon: 83 },
    { date: "Oct 5", phoenix: 87, aurora: 92, zenith: 89, horizon: 85 },
    { date: "Oct 10", phoenix: 84, aurora: 89, zenith: 86, horizon: 82 },
    { date: "Oct 15", phoenix: 86, aurora: 91, zenith: 88, horizon: 84 },
    { date: "Oct 19", phoenix: 86, aurora: 91, zenith: 88, horizon: 84 },
  ];

  const genderSplit = [
    { name: "Male", value: 425, color: "#3B82F6" },
    { name: "Female", value: 280, color: "#EC4899" },
  ];

  const roomOccupancy = [
    { hostel: "Phoenix", occupied: 58, vacant: 2, blocked: 0 },
    { hostel: "Aurora", occupied: 65, vacant: 3, blocked: 2 },
    { hostel: "Zenith", occupied: 50, vacant: 0, blocked: 0 },
    { hostel: "Horizon", occupied: 54, vacant: 4, blocked: 2 },
  ];

  const devices = [
    { id: "KSK-001", hostel: "Phoenix", location: "Floor 1", status: "Online", lastSync: "2 min ago" },
    { id: "KSK-002", hostel: "Phoenix", location: "Floor 2", status: "Online", lastSync: "1 min ago" },
    { id: "KSK-003", hostel: "Aurora", location: "Floor 1", status: "Offline", lastSync: "2 hours ago" },
    { id: "KSK-004", hostel: "Zenith", location: "Gate", status: "Online", lastSync: "5 min ago" },
  ];

  return (
    <div className="min-h-screen bg-background pb-8">
      {/* Header */}
      <div className="bg-gradient-to-r from-red-600 to-red-700 text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <div className="flex-1">
          <h1 className="text-xl">Super Admin</h1>
          <p className="text-xs opacity-90 mt-0.5">Central Management Portal</p>
        </div>
      </div>

      <div className="p-4">
        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-4">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="analytics">Analytics</TabsTrigger>
            <TabsTrigger value="devices">Devices</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4">
            {/* Quick Actions Section */}
            <div className="space-y-3">
              <h3 className="text-base font-semibold">Quick Actions</h3>
              <div className="grid grid-cols-3 gap-3">
                {quickActions.map((action) => {
                  const Icon = action.icon;
                  return (
                    <Card
                      key={action.id}
                      className="p-3 cursor-pointer hover:shadow-lg transition-shadow border-0"
                      onClick={() => onNavigate?.(action.id)}
                    >
                      <div className="flex flex-col items-center gap-2 text-center">
                        <div className={`${action.color} w-10 h-10 rounded-lg flex items-center justify-center`}>
                          <Icon className="h-5 w-5 text-white" />
                        </div>
                        <div>
                          <h4 className="font-medium text-xs">{action.label}</h4>
                        </div>
                      </div>
                    </Card>
                  );
                })}
              </div>
            </div>

            <div className="flex items-center justify-between">
              <h3>Multi-Hostel Overview</h3>
              <UpdatedTime />
            </div>

            {/* Total Stats */}
            <div className="grid grid-cols-2 gap-3">
              <Card className="p-4 space-y-2 border-0 shadow-sm">
                <div className="flex items-center gap-2 text-muted-foreground">
                  <Building2 className="h-4 w-4" />
                  <p className="text-sm">Total Hostels</p>
                </div>
                <p className="text-3xl text-primary">4</p>
              </Card>

              <Card className="p-4 space-y-2 border-0 shadow-sm">
                <div className="flex items-center gap-2 text-muted-foreground">
                  <Users className="h-4 w-4" />
                  <p className="text-sm">Total Students</p>
                </div>
                <p className="text-3xl text-primary">705</p>
              </Card>

              <Card className="p-4 space-y-2 border-0 shadow-sm">
                <div className="flex items-center gap-2 text-muted-foreground">
                  <TrendingUp className="h-4 w-4" />
                  <p className="text-sm">Avg Attendance</p>
                </div>
                <p className="text-3xl text-green-600">87%</p>
              </Card>

              <Card className="p-4 space-y-2 border-0 shadow-sm">
                <div className="flex items-center gap-2 text-muted-foreground">
                  <ShieldCheck className="h-4 w-4" />
                  <p className="text-sm">System Health</p>
                </div>
                <p className="text-3xl text-green-600">98%</p>
              </Card>
            </div>

            {/* Hostel Cards */}
            <div className="space-y-3">
              {hostels.map((hostel) => (
                <Card key={hostel.name} className="p-4 border-0 shadow-sm">
                  <div className="flex items-center justify-between mb-3">
                    <div>
                      <h4>{hostel.name}</h4>
                      <p className="text-sm text-muted-foreground">
                        {hostel.students} students
                      </p>
                    </div>
                    <Building2 className="h-8 w-8 text-muted-foreground" />
                  </div>

                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div className="flex justify-between">
                      <span className="text-muted-foreground">Attendance:</span>
                      <span className="text-green-600">{hostel.attendance}%</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-muted-foreground">Occupancy:</span>
                      <span className="text-blue-600">{hostel.occupancy}%</span>
                    </div>
                  </div>
                </Card>
              ))}
            </div>

            {/* Gender Distribution */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <h4>Gender Distribution</h4>
              <div className="h-64">
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={genderSplit}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ name, value, percent }) =>
                        `${name}: ${value} (${(percent * 100).toFixed(0)}%)`
                      }
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="value"
                    >
                      {genderSplit.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={entry.color} />
                      ))}
                    </Pie>
                    <Tooltip />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </Card>
          </TabsContent>

          <TabsContent value="analytics" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Monthly Analytics</h3>
              <UpdatedTime />
            </div>

            {/* 30-Day Attendance Trend */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <h4>Attendance Trend (Last 30 Days)</h4>
              <div className="h-72">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={attendanceTrend}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="date" />
                    <YAxis domain={[70, 100]} />
                    <Tooltip />
                    <Legend />
                    <Line type="monotone" dataKey="phoenix" stroke="#F59E0B" strokeWidth={2} name="Phoenix" />
                    <Line type="monotone" dataKey="aurora" stroke="#10B981" strokeWidth={2} name="Aurora" />
                    <Line type="monotone" dataKey="zenith" stroke="#3B82F6" strokeWidth={2} name="Zenith" />
                    <Line type="monotone" dataKey="horizon" stroke="#EC4899" strokeWidth={2} name="Horizon" />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </Card>

            {/* Room Occupancy Bar Chart */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <h4>Room Occupancy by Hostel</h4>
              <div className="h-72">
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={roomOccupancy}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="hostel" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="occupied" fill="#10B981" name="Occupied" />
                    <Bar dataKey="vacant" fill="#3B82F6" name="Vacant" />
                    <Bar dataKey="blocked" fill="#EF4444" name="Blocked" />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </Card>

            {/* Financial Summary */}
            <Card className="p-5 space-y-4 border-0 shadow-sm bg-green-50 dark:bg-green-950">
              <div className="flex items-center gap-2">
                <DollarSign className="h-5 w-5 text-green-600" />
                <h4>Finance Overview</h4>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">Monthly Revenue</p>
                  <p className="text-2xl text-green-600">₹52.5L</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Mess Collection</p>
                  <p className="text-2xl text-green-600">₹18.2L</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Pending Dues</p>
                  <p className="text-2xl text-amber-600">₹2.8L</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Collection Rate</p>
                  <p className="text-2xl text-green-600">94.7%</p>
                </div>
              </div>
            </Card>

            {/* Integrity Metrics */}
            <Card className="p-5 space-y-3 border-0 shadow-sm">
              <div className="flex items-center gap-2">
                <ShieldCheck className="h-5 w-5 text-primary" />
                <h4>System Integrity</h4>
              </div>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Manual Attendance %:</span>
                  <span className="text-green-600">4.2% ✓</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Gate Pass Misuse:</span>
                  <span className="text-green-600">0 incidents ✓</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Meal Wastage:</span>
                  <span className="text-amber-600">8.5%</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Data Sync Issues:</span>
                  <span className="text-green-600">0 ✓</span>
                </div>
              </div>
            </Card>
          </TabsContent>

          <TabsContent value="devices" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Device Status</h3>
              <UpdatedTime />
            </div>

            {/* Device Stats */}
            <div className="grid grid-cols-3 gap-3">
              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-green-600">12</p>
                <p className="text-xs text-muted-foreground mt-1">Online</p>
              </Card>

              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-destructive">1</p>
                <p className="text-xs text-muted-foreground mt-1">Offline</p>
              </Card>

              <Card className="p-4 text-center border-0 shadow-sm">
                <p className="text-2xl text-primary">13</p>
                <p className="text-xs text-muted-foreground mt-1">Total</p>
              </Card>
            </div>

            {/* Device Table */}
            <Card className="border-0 shadow-sm overflow-hidden">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Device ID</TableHead>
                    <TableHead>Hostel</TableHead>
                    <TableHead>Status</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {devices.map((device) => (
                    <TableRow key={device.id}>
                      <TableCell className="font-mono text-sm">{device.id}</TableCell>
                      <TableCell>
                        <div className="text-sm">
                          <p>{device.hostel}</p>
                          <p className="text-xs text-muted-foreground">
                            {device.location}
                          </p>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="space-y-1">
                          <Badge
                            variant={device.status === "Online" ? "default" : "destructive"}
                            className={
                              device.status === "Online"
                                ? "bg-green-600"
                                : ""
                            }
                          >
                            {device.status}
                          </Badge>
                          <p className="text-xs text-muted-foreground">
                            {device.lastSync}
                          </p>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
