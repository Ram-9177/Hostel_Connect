import { useState } from "react";
import { Toaster } from "./components/ui/sonner";
import { BottomNav } from "./components/BottomNav";
import { QuickAccessMenu } from "./components/QuickAccessMenu";
import { DemoRoleSwitcher } from "./components/DemoRoleSwitcher";
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

export default function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [userRole, setUserRole] = useState<string>("student");
  const [currentPage, setCurrentPage] = useState<string>("home");

  const handleLogin = (role: string) => {
    setUserRole(role);
    setIsLoggedIn(true);
    
    // Set appropriate landing page based on role
    if (role === "student") {
      setCurrentPage("home");
    } else if (role === "warden") {
      setCurrentPage("warden");
    } else if (role === "warden-head") {
      setCurrentPage("warden-head");
    } else if (role === "super-admin") {
      setCurrentPage("super-admin");
    } else if (role === "chef") {
      setCurrentPage("chef");
    }
  };

  const handleLogout = () => {
    setIsLoggedIn(false);
    setCurrentPage("home");
  };

  const handleNavigate = (page: string) => {
    setCurrentPage(page);
  };

  const handleBack = () => {
    if (userRole === "student") {
      setCurrentPage("home");
    } else if (userRole === "warden") {
      setCurrentPage("warden");
    } else if (userRole === "warden-head") {
      setCurrentPage("warden-head");
    } else if (userRole === "super-admin") {
      setCurrentPage("super-admin");
    } else if (userRole === "chef") {
      setCurrentPage("chef");
    }
  };

  // Show login if not logged in
  if (!isLoggedIn) {
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
    if (userRole === "student") {
      switch (currentPage) {
        case "home":
          return <StudentHome onNavigate={handleNavigate} />;
        case "gatepass":
          return <GatePass onBack={handleBack} />;
        case "attendance":
          return <Attendance onBack={handleBack} />;
        case "meals":
          return <Meals onBack={handleBack} />;
        case "complaints":
        case "notices":
          return <NoticesAndComplaints onBack={handleBack} />;
        case "profile":
          return <Profile onBack={handleBack} onLogout={handleLogout} onNavigate={handleNavigate} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={userRole} />;
        default:
          return <StudentHome onNavigate={handleNavigate} />;
      }
    }

    // Warden Pages
    if (userRole === "warden") {
      switch (currentPage) {
        case "warden":
          return <WardenDashboard onBack={handleLogout} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "attendance":
          return <Attendance onBack={handleBack} />;
        case "complaints":
          return <NoticesAndComplaints onBack={handleBack} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={userRole} />;
        default:
          return <WardenDashboard onBack={handleLogout} />;
      }
    }

    // Warden Head Pages
    if (userRole === "warden-head") {
      switch (currentPage) {
        case "warden-head":
          return <WardenHeadDashboard onBack={handleLogout} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={userRole} />;
        default:
          return <WardenHeadDashboard onBack={handleLogout} />;
      }
    }

    // Super Admin Pages
    if (userRole === "super-admin") {
      switch (currentPage) {
        case "super-admin":
          return <SuperAdminDashboard onBack={handleLogout} />;
        case "warden":
          return <WardenDashboard onBack={handleBack} />;
        case "warden-head":
          return <WardenHeadDashboard onBack={handleBack} />;
        case "rooms":
          return <Rooms onBack={handleBack} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={userRole} />;
        default:
          return <SuperAdminDashboard onBack={handleLogout} />;
      }
    }

    // Chef Pages
    if (userRole === "chef") {
      switch (currentPage) {
        case "chef":
          return <ChefBoard onBack={handleLogout} />;
        case "settings":
          return <Settings onBack={handleBack} userRole={userRole} />;
        default:
          return <ChefBoard onBack={handleLogout} />;
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
        <GlobalSearch onNavigate={handleNavigate} userRole={userRole} />
      )}

      {renderPage()}
      
      {/* Show bottom nav only for students and on specific pages */}
      {userRole === "student" && currentPage !== "settings" && (
        <BottomNav currentPage={currentPage} onNavigate={handleNavigate} />
      )}
      
      {/* Quick Access Menu - Feature shortcuts based on user role */}
      {currentPage !== "settings" && (
        <QuickAccessMenu 
          onNavigate={handleNavigate} 
          userRole={userRole}
        />
      )}

      {/* Demo Role Switcher - For testing different user roles */}
      <DemoRoleSwitcher 
        currentRole={userRole}
        onRoleChange={(role) => {
          setUserRole(role);
          // Navigate to appropriate landing page for the role
          if (role === "student") {
            setCurrentPage("home");
          } else if (role === "warden") {
            setCurrentPage("warden");
          } else if (role === "warden-head") {
            setCurrentPage("warden-head");
          } else if (role === "super-admin") {
            setCurrentPage("super-admin");
          } else if (role === "chef") {
            setCurrentPage("chef");
          }
        }}
      />

      {/* Keyboard Shortcuts - Desktop only */}
      <KeyboardShortcuts />
      
      <Toaster position="top-center" />
    </div>
  );
}
