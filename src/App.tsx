import React, { useState, useEffect } from "react";
import { Toaster } from "./components/ui/sonner";
import { BottomNav } from "./components/BottomNav";
import { QuickAccessMenu } from "./components/QuickAccessMenu";
import { OfflineIndicator } from "./components/OfflineIndicator";
import { GlobalSearch } from "./components/GlobalSearch";
import { DataPrivacyNotice } from "./components/DataPrivacyNotice";
import { KeyboardShortcuts } from "./components/KeyboardShortcuts";
import { Login } from "./components/pages/Login";
import { StudentHome } from "./components/pages/StudentHome";
import { GatePass } from "./components/pages/GatePass";
import { Attendance } from "./components/pages/Attendance";
import { Meals } from "./components/pages/Meals";
import { Rooms } from "./components/pages/Rooms";
import { WardenDashboard } from "./components/pages/WardenDashboard";
import { WardenHeadDashboard } from "./components/pages/WardenHeadDashboard";
import { SuperAdminDashboard } from "./components/pages/SuperAdminDashboard";
import { ChefBoard } from "./components/pages/ChefBoard";
import { NoticesAndComplaints } from "./components/pages/NoticesAndComplaints";
import { Profile } from "./components/pages/Profile";
import { Settings } from "./components/pages/Settings";
import { ChangePassword } from "./components/pages/ChangePassword";
import { IDCard } from "./components/pages/IDCard";
import { HelpCenter } from "./components/pages/HelpCenter";
import { Schedule } from "./components/pages/Schedule";
import { StudyRoom } from "./components/pages/StudyRoom";
import GateSecurity from "./components/GateSecurity";
import StudentInOutDashboard from "./components/StudentInOutDashboard";
import AnalyticsDashboard from "./components/AnalyticsDashboardNew";
import ManualGatePass from "./components/ManualGatePass";
import EmergencyRequests from "./components/EmergencyRequests";
import { AuthProvider, useAuth } from "./contexts/AuthContext";

function AppContent() {
  const [currentPage, setCurrentPage] = useState<string>("home");
  const { user, isAuthenticated, isLoading, logout } = useAuth();

  const handleLogin = (role: string) => {
    // Set appropriate landing page based on role
    if (role === "STUDENT") {
      setCurrentPage("home");
    } else if (role === "WARDEN") {
      setCurrentPage("warden");
    } else if (role === "WARDEN_HEAD") {
      setCurrentPage("warden-head");
    } else if (role === "ADMIN") {
      setCurrentPage("super-admin");
    } else if (role === "CHEF") {
      setCurrentPage("chef");
    } else if (role === "SECURITY") {
      setCurrentPage("gate-security");
    }
  };

  const handleLogout = async () => {
    await logout();
    setCurrentPage("home");
  };

  const handleNavigate = (page: string) => {
    setCurrentPage(page);
  };

  const handleBack = () => {
    if (user?.role === "STUDENT") {
      setCurrentPage("home");
    } else if (user?.role === "WARDEN") {
      setCurrentPage("warden");
    } else if (user?.role === "WARDEN_HEAD") {
      setCurrentPage("warden-head");
    } else if (user?.role === "ADMIN") {
      setCurrentPage("super-admin");
    } else if (user?.role === "CHEF") {
      setCurrentPage("chef");
    } else if (user?.role === "SECURITY") {
      setCurrentPage("gate-security");
    }
  };

  // Show loading spinner while checking authentication
  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Loading...</p>
        </div>
      </div>
    );
  }

  // Show login if not authenticated
  if (!isAuthenticated || !user) {
    return (
      <>
        <Login onLogin={handleLogin} />
        <Toaster position="top-center" />
      </>
    );
  }

  // Render appropriate page based on current page and role
  const renderPage = () => {
    // Student Pages
    if (user.role === "STUDENT") {
      switch (currentPage) {
        case "home":
          return <StudentHome onNavigate={handleNavigate} />;
        case "gatepass":
          return <GatePass onBack={handleBack} />;
        case "attendance":
          return <Attendance onBack={handleBack} />;
        case "meals":
          return <Meals onBack={handleBack} />;
        case "schedule":
          return <Schedule onBack={handleBack} />;
        case "study":
          return <StudyRoom onBack={handleBack} />;
        case "complaints":
        case "notices":
          return <NoticesAndComplaints onBack={handleBack} />;
        case "profile":
          return <Profile onBack={handleBack} onLogout={handleLogout} onNavigate={handleNavigate} />;
        case "change-password":
          return <ChangePassword onBack={handleBack} />;
        case "id-card":
          return <IDCard onBack={handleBack} />;
        case "help-center":
          return <HelpCenter onBack={handleBack} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <StudentHome onNavigate={handleNavigate} />;
      }
    }

    // Warden Pages
    if (user.role === "WARDEN") {
      switch (currentPage) {
        case "warden":
          return <WardenDashboard onBack={handleLogout} onNavigate={handleNavigate} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "attendance":
          return <Attendance onBack={handleBack} />;
        case "student-records":
          return <StudentInOutDashboard />;
        case "analytics":
          return <AnalyticsDashboard onBack={handleBack} />;
        case "manual-gate-pass":
          return <ManualGatePass />;
        case "emergency-requests":
          return <EmergencyRequests />;
        case "complaints":
          return <NoticesAndComplaints onBack={handleBack} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <WardenDashboard onBack={handleLogout} />;
      }
    }

    // Warden Head Pages
    if (user.role === "WARDEN_HEAD") {
      switch (currentPage) {
        case "warden-head":
          return <WardenHeadDashboard onBack={handleLogout} onNavigate={handleNavigate} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "student-records":
          return <StudentInOutDashboard />;
        case "analytics":
          return <AnalyticsDashboard onBack={handleBack} />;
        case "manual-gate-pass":
          return <ManualGatePass />;
        case "emergency-requests":
          return <EmergencyRequests />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <WardenHeadDashboard onBack={handleLogout} />;
      }
    }

    // Super Admin Pages
    if (user.role === "ADMIN") {
      switch (currentPage) {
        case "super-admin":
          return <SuperAdminDashboard onBack={handleLogout} onNavigate={handleNavigate} />;
        case "warden":
          return <WardenDashboard onBack={handleBack} onNavigate={handleNavigate} />;
        case "warden-head":
          return <WardenHeadDashboard onBack={handleBack} onNavigate={handleNavigate} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "student-records":
          return <StudentInOutDashboard />;
        case "analytics":
          return <AnalyticsDashboard onBack={handleBack} />;
        case "manual-gate-pass":
          return <ManualGatePass />;
        case "emergency-requests":
          return <EmergencyRequests />;
        case "gate-security":
          return <GateSecurity />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <SuperAdminDashboard onBack={handleLogout} />;
      }
    }

    // Chef Pages
    if (user.role === "CHEF") {
      switch (currentPage) {
        case "chef":
          return <ChefBoard onBack={handleLogout} onNavigate={handleNavigate} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <ChefBoard onBack={handleLogout} onNavigate={handleNavigate} />;
      }
    }

    // Security Pages
    if (user.role === "SECURITY") {
      switch (currentPage) {
        case "gate-security":
          return <GateSecurity onNavigate={handleNavigate} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={user.role} onNavigate={handleNavigate} onLogout={handleLogout} />;
        default:
          return <GateSecurity onNavigate={handleNavigate} />;
      }
    }

    return <StudentHome onNavigate={handleNavigate} />;
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Data Privacy Notice - First time users */}
      <DataPrivacyNotice />

      {/* Offline Indicator */}
      <OfflineIndicator />

      {/* Global Search - Only show when logged in */}
      {currentPage !== "settings" && (
        <GlobalSearch onNavigate={handleNavigate} userRole={user.role} />
      )}

      {renderPage()}
      
      {/* Show bottom nav only for students and on specific pages */}
      {user.role === "STUDENT" && currentPage !== "settings" && (
        <BottomNav currentPage={currentPage} onNavigate={handleNavigate} />
      )}
      
      {/* Quick Access Menu - Feature shortcuts based on user role */}
      {currentPage !== "settings" && (
        <QuickAccessMenu 
          onNavigate={handleNavigate} 
          userRole={user.role}
        />
      )}


      {/* Keyboard Shortcuts - Desktop only */}
      <KeyboardShortcuts />
      
      <Toaster position="top-center" />
    </div>
  );
}

export default function App() {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
}
