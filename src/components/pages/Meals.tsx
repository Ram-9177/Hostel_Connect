import { useState } from "react";
import { ArrowLeft, Coffee, Utensils, Cookie, Moon, Check, X, Clock } from "lucide-react";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Switch } from "../ui/switch";
import { UpdatedTime } from "../UpdatedTime";
import { toast } from "sonner@2.0.3";
import { motion } from "motion/react";

interface MealsProps {
  onBack: () => void;
}

export function Meals({ onBack }: MealsProps) {
  const [meals, setMeals] = useState({
    breakfast: true,
    lunch: true,
    snacks: false,
    dinner: true,
  });

  const handleToggle = (meal: keyof typeof meals) => {
    setMeals((prev) => ({ ...prev, [meal]: !prev[meal] }));
  };

  const handleAllYes = () => {
    setMeals({ breakfast: true, lunch: true, snacks: true, dinner: true });
    toast.success("All meals selected");
  };

  const handleAllNo = () => {
    setMeals({ breakfast: false, lunch: false, snacks: false, dinner: false });
    toast.success("All meals deselected");
  };

  const handleSameAsYesterday = () => {
    // Simulate yesterday's data
    setMeals({ breakfast: true, lunch: true, snacks: true, dinner: false });
    toast.success("Set to yesterday's preference");
  };

  const handleSave = () => {
    toast.success("Meal preferences saved successfully!");
  };

  const mealOptions = [
    {
      id: "breakfast",
      name: "Breakfast",
      nameTe: "ఉదయం టిఫిన్",
      icon: Coffee,
      time: "07:00 - 09:00 AM",
      menu: "Idli, Dosa, Upma",
      color: "text-amber-600",
      bgColor: "bg-amber-50 dark:bg-amber-950",
    },
    {
      id: "lunch",
      name: "Lunch",
      nameTe: "మధ్యాహ్నం భోజనం",
      icon: Utensils,
      time: "12:00 - 02:00 PM",
      menu: "Rice, Dal, Curry",
      color: "text-green-600",
      bgColor: "bg-green-50 dark:bg-green-950",
    },
    {
      id: "snacks",
      name: "Evening Snacks",
      nameTe: "సాయంత్రం టిఫిన్",
      icon: Cookie,
      time: "04:00 - 05:00 PM",
      menu: "Tea, Biscuits",
      color: "text-purple-600",
      bgColor: "bg-purple-50 dark:bg-purple-950",
    },
    {
      id: "dinner",
      name: "Dinner",
      nameTe: "రాత్రి భోజనం",
      icon: Moon,
      time: "07:00 - 09:00 PM",
      menu: "Rice, Roti, Dal",
      color: "text-blue-600",
      bgColor: "bg-blue-50 dark:bg-blue-950",
    },
  ];

  const yesCount = Object.values(meals).filter(Boolean).length;

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Enhanced Header */}
      <div className="bg-gradient-to-r from-accent via-amber-500 to-amber-600 text-white p-5 shadow-lg relative overflow-hidden">
        <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-16 translate-x-16" />
        <div className="relative flex items-center gap-3">
          <motion.button 
            onClick={onBack} 
            className="p-2 bg-white/20 rounded-xl hover:bg-white/30 transition-colors"
            whileTap={{ scale: 0.9 }}
          >
            <ArrowLeft className="h-5 w-5" />
          </motion.button>
          <div>
            <h1 className="text-xl mb-1">Meal Preferences</h1>
            <p className="text-xs opacity-90">Set your daily meal choices</p>
          </div>
        </div>
      </div>

      <div className="p-4 space-y-4">
        {/* Enhanced Date Card */}
        <Card className="p-5 border-0 shadow-md bg-gradient-to-br from-card to-muted/10">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="mb-1">Today's Meals</h3>
              <p className="text-sm text-muted-foreground">
                Sunday, 19 Oct 2025
              </p>
              <p className="text-xs text-muted-foreground mt-1">
                Cutoff: 11:00 PM IST
              </p>
            </div>
            <UpdatedTime />
          </div>
        </Card>

        {/* Enhanced Quick Actions */}
        <Card className="p-5 space-y-3 border-0 shadow-md">
          <h4 className="mb-1">Quick Actions</h4>
          <p className="text-xs text-muted-foreground mb-3">Set preferences for all meals at once</p>
          <div className="grid grid-cols-3 gap-3">
            <motion.div whileTap={{ scale: 0.95 }}>
              <Button
                onClick={handleAllYes}
                variant="outline"
                size="sm"
                className="flex flex-col items-center gap-2 h-auto py-3 w-full border-2 hover:border-green-600 hover:bg-green-50 dark:hover:bg-green-950"
              >
                <Check className="h-5 w-5 text-green-600" />
                <span className="text-xs">All Yes</span>
              </Button>
            </motion.div>
            <motion.div whileTap={{ scale: 0.95 }}>
              <Button
                onClick={handleAllNo}
                variant="outline"
                size="sm"
                className="flex flex-col items-center gap-2 h-auto py-3 w-full border-2 hover:border-red-600 hover:bg-red-50 dark:hover:bg-red-950"
              >
                <X className="h-5 w-5 text-red-600" />
                <span className="text-xs">All No</span>
              </Button>
            </motion.div>
            <motion.div whileTap={{ scale: 0.95 }}>
              <Button
                onClick={handleSameAsYesterday}
                variant="outline"
                size="sm"
                className="flex flex-col items-center gap-2 h-auto py-3 w-full border-2 hover:border-primary hover:bg-blue-50 dark:hover:bg-blue-950"
              >
                <Clock className="h-5 w-5 text-primary" />
                <span className="text-xs">Yesterday</span>
              </Button>
            </motion.div>
          </div>
        </Card>

        {/* Enhanced Meal Toggles */}
        <div className="space-y-3">
          <div className="flex items-center justify-between mb-2">
            <h4>Select Meals</h4>
            <span className="text-xs text-muted-foreground">{yesCount} of 4 selected</span>
          </div>
          {mealOptions.map((meal, index) => {
            const Icon = meal.icon;
            const isSelected = meals[meal.id as keyof typeof meals];

            return (
              <motion.div
                key={meal.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                <Card
                  className={`p-5 border-2 transition-all cursor-pointer ${
                    isSelected
                      ? "border-primary shadow-lg bg-primary/5"
                      : "border-transparent shadow-md hover:shadow-lg"
                  }`}
                  onClick={() => handleToggle(meal.id as keyof typeof meals)}
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4 flex-1">
                      <div className={`${meal.bgColor} p-4 rounded-2xl shadow-sm`}>
                        <Icon className={`h-7 w-7 ${meal.color}`} />
                      </div>
                      <div className="flex-1">
                        <h4 className="mb-1">{meal.name}</h4>
                        <p className="text-sm text-muted-foreground">
                          {meal.time}
                        </p>
                        <p className="text-xs text-muted-foreground/80 mt-1">
                          {meal.menu}
                        </p>
                      </div>
                    </div>
                    <Switch
                      checked={isSelected}
                      onCheckedChange={(checked) => {
                        handleToggle(meal.id as keyof typeof meals);
                      }}
                      onClick={(e) => e.stopPropagation()}
                    />
                  </div>
                </Card>
              </motion.div>
            );
          })}
        </div>

        {/* Summary Card */}
        <Card className="p-5 space-y-3 border-0 shadow-sm bg-primary/5">
          <h4>Summary</h4>
          <div className="flex items-center justify-between text-sm">
            <span className="text-muted-foreground">Meals Selected:</span>
            <span className="text-primary">{yesCount} of 4</span>
          </div>
          <div className="flex items-center justify-between text-sm">
            <span className="text-muted-foreground">Cutoff Time:</span>
            <span className="text-destructive">11:00 PM Tonight</span>
          </div>
        </Card>

        {/* Chef Board Preview */}
        <Card className="p-5 space-y-3 border-0 shadow-sm">
          <h4>Expected Count (Preview)</h4>
          <p className="text-xs text-muted-foreground">
            Based on current responses from all students
          </p>
          <div className="grid grid-cols-2 gap-3 pt-2">
            {mealOptions.map((meal) => (
              <div key={meal.id} className="text-center p-3 bg-muted/30 rounded-lg">
                <p className="text-2xl text-primary">
                  {Math.floor(Math.random() * 50) + 120}
                </p>
                <p className="text-xs text-muted-foreground mt-1">
                  {meal.name}
                </p>
              </div>
            ))}
          </div>
        </Card>

        {/* Enhanced Diet Preference Note */}
        <Card className="p-5 border-0 shadow-md bg-gradient-to-br from-green-50 to-green-100 dark:from-green-950 dark:to-green-900">
          <div className="flex items-start gap-3">
            <div className="w-3 h-3 rounded-full bg-green-600 mt-1.5 flex-shrink-0" />
            <div className="flex-1">
              <p className="text-sm mb-1">
                Your diet: <span className="font-medium text-green-700 dark:text-green-400">Pure Vegetarian 🥗</span>
              </p>
              <p className="text-xs text-muted-foreground">
                All meals prepared in separate veg kitchen • Change in Profile
              </p>
            </div>
          </div>
        </Card>

        {/* Enhanced Save Button */}
        <motion.div whileTap={{ scale: 0.98 }}>
          <Button
            onClick={handleSave}
            className="w-full bg-gradient-to-r from-primary to-secondary hover:from-primary/90 hover:to-secondary/90 h-14 shadow-lg text-base"
          >
            Save Meal Preferences
          </Button>
        </motion.div>
        
        {/* Help text */}
        <p className="text-xs text-center text-muted-foreground">
          Changes will be reflected in tomorrow's meal count
        </p>
      </div>
    </div>
  );
}
