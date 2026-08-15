import React, { useState, useEffect } from 'react';
import { Language, ThemeMode, UserRole } from './types';
import { MasariTopBar } from './components/MasariTopBar';
import { MasariSidebar } from './components/MasariSidebar';
import { MasariBottomNav } from './components/MasariBottomNav';
import { HomeView } from './components/views/HomeView';
import { TourismView } from './components/views/TourismView';
import { FlightsView } from './components/views/FlightsView';
import { HotelsView } from './components/views/HotelsView';
import { HajjUmrahView } from './components/views/HajjUmrahView';
import { TransportationView } from './components/views/TransportationView';
import { VisaView } from './components/views/VisaView';
import { AdminView } from './components/views/AdminView';
import { UserAccountViews } from './components/views/UserAccountViews';
import { GenericServiceView } from './components/views/GenericServiceView';

export default function App() {
  const [language, setLanguage] = useState<Language>('ar');
  const [themeMode, setThemeMode] = useState<ThemeMode>('dark');
  const [userRole, setUserRole] = useState<UserRole>('guest');
  const [currentPath, setCurrentPath] = useState<string>('/home');
  const [isSidebarCollapsed, setIsSidebarCollapsed] = useState<boolean>(false);

  // Sync RTL / LTR document attributes
  useEffect(() => {
    document.documentElement.dir = language === 'ar' ? 'rtl' : 'ltr';
    document.documentElement.lang = language;
  }, [language]);

  // Sync Theme mode class
  useEffect(() => {
    if (themeMode === 'dark') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [themeMode]);

  const handleToggleLanguage = () => {
    setLanguage((prev) => (prev === 'ar' ? 'en' : 'ar'));
  };

  const handleToggleTheme = () => {
    setThemeMode((prev) => (prev === 'dark' ? 'light' : 'dark'));
  };

  const handleNavigate = (path: string) => {
    setCurrentPath(path);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const renderCurrentView = () => {
    switch (currentPath) {
      case '/home':
        return <HomeView language={language} userRole={userRole} onNavigate={handleNavigate} />;
      case '/tourism':
        return <TourismView language={language} onNavigate={handleNavigate} />;
      case '/flights':
        return <FlightsView language={language} onNavigate={handleNavigate} />;
      case '/hotels':
        return <HotelsView language={language} onNavigate={handleNavigate} />;
      case '/hajj':
        return <HajjUmrahView language={language} currentType="hajj" onNavigate={handleNavigate} />;
      case '/umrah':
        return <HajjUmrahView language={language} currentType="umrah" onNavigate={handleNavigate} />;
      case '/cars':
        return <TransportationView language={language} initialType="cars" onNavigate={handleNavigate} />;
      case '/bus':
        return <TransportationView language={language} initialType="bus" onNavigate={handleNavigate} />;
      case '/transfers':
        return <TransportationView language={language} initialType="transfers" onNavigate={handleNavigate} />;
      case '/visa':
        return <VisaView language={language} onNavigate={handleNavigate} />;
      case '/admin':
        return <AdminView language={language} userRole={userRole} onNavigate={handleNavigate} />;
      case '/wallet':
      case '/bookings':
      case '/travelers':
      case '/passports':
      case '/ai':
      case '/profile':
      case '/settings':
        return (
          <UserAccountViews
            language={language}
            currentPath={currentPath}
            userRole={userRole}
            onNavigate={handleNavigate}
          />
        );
      default:
        return (
          <GenericServiceView
            currentPath={currentPath}
            language={language}
            userRole={userRole}
            onNavigate={handleNavigate}
          />
        );
    }
  };

  return (
    <div
      className={`min-h-screen ${
        themeMode === 'dark' ? 'bg-[#050914] text-[#F8FAFC]' : 'bg-[#F8FAFC] text-[#0B192C]'
      } font-['Cairo','Inter',sans-serif] selection:bg-[#00D4FF] selection:text-[#050914] transition-colors duration-300`}
    >
      {/* Top Bar Header */}
      <MasariTopBar
        language={language}
        onToggleLanguage={handleToggleLanguage}
        themeMode={themeMode}
        onToggleTheme={handleToggleTheme}
        userRole={userRole}
        onChangeUserRole={setUserRole}
        onNavigate={handleNavigate}
      />

      {/* Main Body Layout with Sidebar */}
      <div className="flex relative pb-16 md:pb-0">
        <MasariSidebar
          currentPath={currentPath}
          onNavigate={handleNavigate}
          language={language}
          userRole={userRole}
          isCollapsed={isSidebarCollapsed}
          onToggleCollapse={() => setIsSidebarCollapsed(!isSidebarCollapsed)}
        />

        {/* Dynamic Route Content */}
        <main className="flex-1 overflow-x-hidden min-h-[calc(100vh-4rem)]">
          {renderCurrentView()}
        </main>
      </div>

      {/* Mobile Bottom Navigation */}
      <MasariBottomNav
        currentPath={currentPath}
        onNavigate={handleNavigate}
        language={language}
      />
    </div>
  );
}

