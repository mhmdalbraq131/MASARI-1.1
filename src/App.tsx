import React, { useState, useEffect } from 'react';
import { Language, ThemeMode, UserRole } from './types';
import { MasariTopBar } from './components/MasariTopBar';
import { MasariSidebar } from './components/MasariSidebar';
import { MasariBottomNav } from './components/MasariBottomNav';
import { HomeView } from './components/views/HomeView';
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

  return (
    <div
      className={`min-h-screen ${
        themeMode === 'dark' ? 'bg-[#050914] text-[#F8FAFC]' : 'bg-[#F8FAFC] text-[#050914]'
      } font-['Cairo','Inter',sans-serif] selection:bg-[#D4AF37] selection:text-[#050914] transition-colors duration-300`}
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
          {currentPath === '/home' ? (
            <HomeView language={language} onNavigate={handleNavigate} />
          ) : (
            <GenericServiceView
              currentPath={currentPath}
              language={language}
              userRole={userRole}
              onNavigate={handleNavigate}
            />
          )}
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
