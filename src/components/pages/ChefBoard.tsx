import { ArrowLeft, Download, Lock, Unlock, PieChart, Settings } from "lucide-react";
import { Card } from "../ui/card";
import { UpdatedTime } from "../UpdatedTime";
import { Button } from "../ui/button";
import { Badge } from "../ui/badge";
import { Cell, Legend, Pie, PieChart as RechartsPie, ResponsiveContainer, Tooltip } from "recharts";

interface ChefBoardProps {
  onBack: () => void;
  onNavigate?: (page: string) => void;
}

export function ChefBoard({ onBack, onNavigate }: ChefBoardProps) {
  const isLocked = new Date().getHours() >= 23; // Locked after 11 PM

  const meals = [
    { name: "Breakfast", yes: 165, buffer: 17, total: 182, color: "#F59E0B" },
    { name: "Lunch", yes: 172, buffer: 18, total: 190, color: "#10B981" },
    { name: "Snacks", yes: 142, buffer: 15, total: 157, color: "#8B5CF6" },
    { name: "Dinner", yes: 168, buffer: 17, total: 185, color: "#3B82F6" },
  ];

  const dietSplit = [
    { name: "Vegetarian", value: 520, color: "#10B981" },
    { name: "Non-Vegetarian", value: 127, color: "#EF4444" },
  ];

  const handleExportCSV = () => {
    // Mock CSV export
    const csvContent = "Meal,Student Count,Buffer,Total\n" +
      meals.map(m => `${m.name},${m.yes},${m.buffer},${m.total}`).join("\n");
    
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `meal-forecast-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
  };

  return (
    <div className="min-h-screen bg-background pb-8">
      {/* Header */}
      <div className="bg-gradient-to-r from-orange-600 to-orange-700 text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <div className="flex-1">
          <h1 className="text-xl">Chef Board</h1>
          <p className="text-xs opacity-90 mt-0.5">Meal Planning Dashboard</p>
        </div>
        <button onClick={() => onNavigate?.('settings')} className="p-2 hover:bg-white/10 rounded-lg transition-colors">
          <Settings className="h-5 w-5" />
        </button>
      </div>

      <div className="p-4 space-y-4">
        {/* Date and Status */}
        <Card className="p-4 border-0 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <h3>Tomorrow's Forecast</h3>
              <p className="text-sm text-muted-foreground mt-1">
                Monday, October 20, 2025
              </p>
            </div>
            <div className="flex items-center gap-2">
              {isLocked ? (
                <>
                  <Lock className="h-5 w-5 text-destructive" />
                  <Badge variant="destructive">Locked</Badge>
                </>
              ) : (
                <>
                  <Unlock className="h-5 w-5 text-green-600" />
                  <Badge className="bg-green-600">Open</Badge>
                </>
              )}
            </div>
          </div>
        </Card>

        {/* Lock Status Info */}
        {isLocked ? (
          <Card className="p-4 border-0 shadow-sm bg-red-50 dark:bg-red-950">
            <div className="flex items-start gap-3">
              <Lock className="h-5 w-5 text-destructive mt-0.5" />
              <div className="flex-1">
                <h4 className="text-destructive">Data Locked</h4>
                <p className="text-sm text-muted-foreground mt-1">
                  Meal selection cutoff passed. Data is now frozen for preparation.
                </p>
              </div>
            </div>
          </Card>
        ) : (
          <Card className="p-4 border-0 shadow-sm bg-amber-50 dark:bg-amber-950">
            <div className="flex items-start gap-3">
              <Unlock className="h-5 w-5 text-amber-600 mt-0.5" />
              <div className="flex-1">
                <h4 className="text-amber-600">Selection Open</h4>
                <p className="text-sm text-muted-foreground mt-1">
                  Students can still modify preferences. Locks at 11:00 PM tonight.
                </p>
              </div>
            </div>
          </Card>
        )}

        {/* Forecast Summary with Update Time */}
        <div className="flex items-center justify-between">
          <h3>Meal Count Summary</h3>
          <UpdatedTime />
        </div>

        {/* Meal Cards */}
        <div className="space-y-3">
          {meals.map((meal) => (
            <Card key={meal.name} className="p-5 border-0 shadow-sm">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h4>{meal.name}</h4>
                  <div
                    className="w-3 h-3 rounded-full"
                    style={{ backgroundColor: meal.color }}
                  />
                </div>

                <div className="grid grid-cols-3 gap-4 text-center">
                  <div>
                    <p className="text-2xl" style={{ color: meal.color }}>
                      {meal.yes}
                    </p>
                    <p className="text-xs text-muted-foreground mt-1">
                      Student Count
                    </p>
                  </div>

                  <div>
                    <p className="text-2xl text-accent">+{meal.buffer}</p>
                    <p className="text-xs text-muted-foreground mt-1">
                      Buffer (10%)
                    </p>
                  </div>

                  <div>
                    <p className="text-2xl text-primary">{meal.total}</p>
                    <p className="text-xs text-muted-foreground mt-1">
                      Total to Prepare
                    </p>
                  </div>
                </div>

                {/* Progress Bar */}
                <div className="h-2 bg-muted rounded-full overflow-hidden">
                  <div
                    className="h-full transition-all"
                    style={{
                      width: `${(meal.yes / 180) * 100}%`,
                      backgroundColor: meal.color,
                    }}
                  />
                </div>
                <p className="text-xs text-muted-foreground text-right">
                  {Math.round((meal.yes / 180) * 100)}% of total students
                </p>
              </div>
            </Card>
          ))}
        </div>

        {/* Diet Split */}
        <Card className="p-5 space-y-4 border-0 shadow-sm">
          <div className="flex items-center gap-2">
            <PieChart className="h-5 w-5 text-primary" />
            <h4>Diet Preference Split</h4>
          </div>

          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <RechartsPie>
                <Pie
                  data={dietSplit}
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
                  {dietSplit.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
                <Legend />
              </RechartsPie>
            </ResponsiveContainer>
          </div>
        </Card>

        {/* Additional Metrics */}
        <Card className="p-5 space-y-3 border-0 shadow-sm">
          <h4>Planning Metrics</h4>
          <div className="space-y-2 text-sm">
            <div className="flex justify-between">
              <span className="text-muted-foreground">Total Hostel Strength:</span>
              <span>180 students</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Current Response Rate:</span>
              <span className="text-green-600">96% (173 responses)</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Buffer Percentage:</span>
              <span className="text-accent">10%</span>
            </div>
            <div className="flex justify-between">
              <span className="text-muted-foreground">Manual Overrides:</span>
              <span className="text-blue-600">2 adjustments</span>
            </div>
          </div>
        </Card>

        {/* Override Delta Info */}
        <Card className="p-4 border-0 shadow-sm bg-blue-50 dark:bg-blue-950">
          <div className="flex items-start gap-3">
            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
            <div className="flex-1">
              <p className="text-sm">
                <span className="font-medium">Override Delta:</span> +5 for lunch
                (Warden Head adjustment for special event)
              </p>
            </div>
          </div>
        </Card>

        {/* Export Button */}
        <Button
          onClick={handleExportCSV}
          className="w-full bg-primary hover:bg-primary/90"
        >
          <Download className="h-4 w-4 mr-2" />
          Export as CSV
        </Button>

        {/* Historical Note */}
        <Card className="p-4 border-0 shadow-sm">
          <div className="text-xs text-muted-foreground space-y-1">
            <p>• Last week average wastage: 8.5%</p>
            <p>• Most popular meal: Lunch (96% opt-in)</p>
            <p>• Least popular meal: Snacks (79% opt-in)</p>
          </div>
        </Card>
      </div>
    </div>
  );
}
