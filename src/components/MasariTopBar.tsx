import React from 'react';
import {
  Globe,
  Sun,
  MoonStar,
  Bell,
  Search,
  UserCheck,
  ShieldCheck,
  User,
  Sparkles
} from 'lucide-react';
import { Language, ThemeMode, UserRole } from '../types';

interface MasariTopBarProps {
  language: Language;
  onToggleLanguage: () => void;
  themeMode: ThemeMode;
  onToggleTheme: () => void;
  userRole: UserRole;
  onChangeUserRole: (role: UserRole) => void;
  onNavigate: (path: string) => void;
}

export const MasariTopBar: React.FC<MasariTopBarProps> = ({
  language,
  onToggleLanguage,
  themeMode,
  onToggleTheme,
  userRole,
  onChangeUserRole,
  onNavigate,
}) => {
  const isArabic = language === 'ar';

  return (
    <header className="sticky top-0 z-40 w-full border-b border-[#D4AF37]/20 bg-[#050914]/90 backdrop-blur-md text-[#F8FAFC]">
      <div className="flex h-16 items-center justify-between px-4 md:px-6">
        {/* Brand & Logo */}
        <div className="flex items-center gap-3 cursor-pointer" onClick={() => onNavigate('/home')}>
          <div className="flex h-10 w-10 items-center justify-center rounded-full bg-gradient-to-br from-[#D4AF37] via-[#E5C358] to-[#B8860B] text-[#050914] shadow-lg shadow-[#D4AF37]/20">
            <Sparkles className="h-5 w-5 stroke-[2.5]" />
          </div>
          <div className="flex flex-col">
            <span className="text-xl font-extrabold tracking-tight text-[#D4AF37]">
              {isArabic ? 'مساري' : 'MASARI'}
            </span>
            <span className="text-[10px] font-medium text-[#64748B] tracking-wider uppercase">
              {isArabic ? 'منصة السفر الفاخر' : 'Luxury Platform'}
            </span>
          </div>
        </div>

        {/* Global Search Bar (Desktop) */}
        <div className="hidden md:flex items-center flex-1 max-w-md mx-8">
          <div className="relative w-full">
            <Search className={`absolute ${isArabic ? 'right-3' : 'left-3'} top-1/2 -translate-y-1/2 h-4 w-4 text-[#64748B]`} />
            <input
              type="text"
              placeholder={isArabic ? 'ابحث عن الرحلات، الفنادق، أو باقات الحج والعمرة...' : 'Search flights, hotels, or Hajj & Umrah...'}
              className={`w-full h-10 rounded-xl bg-[#0A1631] border border-[#1E293B] ${isArabic ? 'pr-10 pl-4' : 'pl-10 pr-4'} text-sm text-[#F8FAFC] placeholder-[#64748B] focus:outline-none focus:border-[#D4AF37] transition-all`}
            />
          </div>
        </div>

        {/* Action Controls */}
        <div className="flex items-center gap-2 md:gap-3">
          {/* User Role Switcher */}
          <div className="flex items-center bg-[#0A1631] border border-[#1E293B] rounded-xl p-1 text-xs">
            <button
              onClick={() => onChangeUserRole('guest')}
              className={`px-2 py-1 rounded-lg transition-colors ${userRole === 'guest' ? 'bg-[#D4AF37] text-[#050914] font-bold' : 'text-[#64748B] hover:text-white'}`}
              title="Guest Role"
            >
              زائر
            </button>
            <button
              onClick={() => onChangeUserRole('user')}
              className={`px-2 py-1 rounded-lg transition-colors ${userRole === 'user' ? 'bg-[#D4AF37] text-[#050914] font-bold' : 'text-[#64748B] hover:text-white'}`}
              title="User Role"
            >
              عضو
            </button>
            <button
              onClick={() => onChangeUserRole('admin')}
              className={`px-2 py-1 rounded-lg transition-colors ${userRole === 'admin' ? 'bg-[#D4AF37] text-[#050914] font-bold' : 'text-[#64748B] hover:text-white'}`}
              title="Admin Role"
            >
              مشرف
            </button>
          </div>

          {/* Language Switcher */}
          <button
            onClick={onToggleLanguage}
            className="flex items-center gap-1.5 px-3 py-2 rounded-xl bg-[#0A1631] border border-[#1E293B] hover:border-[#D4AF37]/50 text-xs font-semibold text-[#F8FAFC] transition-colors"
            title="Toggle Language"
          >
            <Globe className="h-4 w-4 text-[#D4AF37]" />
            <span>{language.toUpperCase()}</span>
          </button>

          {/* Theme Switcher */}
          <button
            onClick={onToggleTheme}
            className="p-2 rounded-xl bg-[#0A1631] border border-[#1E293B] hover:border-[#D4AF37]/50 text-[#D4AF37] transition-colors"
            title="Toggle Theme"
          >
            {themeMode === 'dark' ? <Sun className="h-4 w-4" /> : <MoonStar className="h-4 w-4" />}
          </button>

          {/* Notifications */}
          <button
            onClick={() => onNavigate('/notifications')}
            className="relative p-2 rounded-xl bg-[#0A1631] border border-[#1E293B] hover:border-[#D4AF37]/50 text-[#F8FAFC] transition-colors"
          >
            <Bell className="h-4 w-4 text-[#94A3B8]" />
            <span className="absolute top-1 right-1 h-2 w-2 rounded-full bg-[#00D4FF]"></span>
          </button>

          {/* User Profile Avatar */}
          <button
            onClick={() => onNavigate('/profile')}
            className="flex items-center gap-2 p-1.5 rounded-xl bg-[#0A1631] border border-[#D4AF37]/30 hover:border-[#D4AF37] transition-colors"
          >
            <div className="h-7 w-7 rounded-lg bg-[#D4AF37]/20 flex items-center justify-center text-[#D4AF37] font-bold text-xs">
              {userRole === 'admin' ? 'AD' : userRole === 'user' ? 'MR' : 'GS'}
            </div>
          </button>
        </div>
      </div>
    </header>
  );
};
