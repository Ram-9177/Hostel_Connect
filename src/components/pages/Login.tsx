import { useState } from "react";
import { User, Lock, ArrowRight } from "lucide-react";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { Label } from "../ui/label";
import { Card } from "../ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../ui/select";
import { motion } from "motion/react";

interface LoginProps {
  onLogin: (role: string) => void;
}

export function Login({ onLogin }: LoginProps) {
  const [role, setRole] = useState<string>("student");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onLogin(role);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary via-secondary to-primary flex items-center justify-center p-4 relative overflow-hidden">
      {/* Decorative background elements */}
      <div className="absolute top-0 left-0 w-96 h-96 bg-white/5 rounded-full -translate-x-48 -translate-y-48" />
      <div className="absolute bottom-0 right-0 w-96 h-96 bg-white/5 rounded-full translate-x-48 translate-y-48" />
      
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="w-full max-w-md relative"
      >
        <Card className="p-8 space-y-6 border-0 shadow-2xl">
          {/* Logo and Title */}
          <div className="text-center space-y-3">
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ type: "spring", stiffness: 200, delay: 0.2 }}
              className="w-24 h-24 bg-gradient-to-br from-primary to-secondary rounded-3xl flex items-center justify-center mx-auto mb-4 shadow-2xl"
            >
              <span className="text-white text-4xl">HC</span>
            </motion.div>
            <h1 className="text-3xl">HostelConnect</h1>
            <p className="text-sm text-muted-foreground">
              Complete hostel management solution
            </p>
            <p className="text-xs text-muted-foreground/80">
              హాస్టల్ నిర్వహణ వ్యవస్థ
            </p>
          </div>

        {/* Login Form */}
        <form onSubmit={handleSubmit} className="space-y-5">
          <div className="space-y-2">
            <Label htmlFor="role">Login As</Label>
            <Select value={role} onValueChange={setRole}>
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="student">Student</SelectItem>
                <SelectItem value="warden">Warden</SelectItem>
                <SelectItem value="warden-head">Warden Head</SelectItem>
                <SelectItem value="super-admin">Super Admin</SelectItem>
                <SelectItem value="chef">Chef</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="username">Username</Label>
            <div className="relative">
              <User className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                id="username"
                placeholder="Enter your username"
                className="pl-10"
                required
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="password">Password</Label>
            <div className="relative">
              <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                id="password"
                type="password"
                placeholder="Enter your password"
                className="pl-10"
                required
              />
            </div>
          </div>

          <motion.div whileTap={{ scale: 0.98 }}>
            <Button
              type="submit"
              className="w-full bg-primary hover:bg-primary/90 h-12 shadow-lg"
            >
              Login
              <ArrowRight className="h-4 w-4 ml-2" />
            </Button>
          </motion.div>

          <div className="text-center">
            <button
              type="button"
              className="text-sm text-primary hover:underline font-medium"
            >
              Forgot Password?
            </button>
          </div>
        </form>

        {/* Demo Credentials with better design */}
        <Card className="p-4 bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-950 dark:to-blue-900 border-0">
          <p className="text-xs font-medium mb-2 text-primary">Demo Login:</p>
          <div className="text-xs space-y-1.5">
            <div className="flex justify-between items-center p-2 bg-white/50 dark:bg-black/20 rounded">
              <span className="text-muted-foreground">Student:</span>
              <span className="font-medium">student / demo123</span>
            </div>
            <div className="flex justify-between items-center p-2 bg-white/50 dark:bg-black/20 rounded">
              <span className="text-muted-foreground">Warden:</span>
              <span className="font-medium">warden / demo123</span>
            </div>
            <div className="flex justify-between items-center p-2 bg-white/50 dark:bg-black/20 rounded">
              <span className="text-muted-foreground">Admin:</span>
              <span className="font-medium">admin / demo123</span>
            </div>
          </div>
        </Card>

        {/* Footer with regional context */}
        <div className="text-center text-xs text-muted-foreground pt-4 border-t border-border">
          <p>Trusted by hostels across Andhra & Telangana</p>
          <p className="mt-1">© 2025 HostelConnect. All rights reserved.</p>
        </div>
        </Card>
      </motion.div>
    </div>
  );
}
