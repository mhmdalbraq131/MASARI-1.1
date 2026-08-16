import React from 'react';
import {
  LayoutDashboard,
  Plane,
  Hotel,
  Bus,
  Car,
  Compass,
  Palmtree,
  FileCheck,
  Landmark,
  Moon,
  Wallet,
  Ticket,
  Users,
  Shield,
  Sparkles,
  User,
  Settings,
  ShieldAlert,
  ChevronRight,
  ChevronLeft
} from 'lucide-react';
import { MASARI_ROUTES } from '../data/routesData';
import { Language, UserRole } from '../types';

interface MasariSidebarProps {
  currentPath: string;
  onNavigate: (path: string) => void;
  language: Language;
  userRole: UserRole;
  isCollapsed: boolean;
  onToggleCollapse: () => void;
}

const getIcon = (iconName: string) => {
  switch (iconName) {
    case 'LayoutDashboard': return <LayoutDashboard className="h-4 w-4" />;
    case 'Plane': return <Plane className="h-4 w-4" />;
    case 'Hotel': return <Hotel className="h-4 w-4" />;
    case 'Bus': return <Bus className="h-4 w-4" />;
    case 'Car': return <Car className="h-4 w-4" />;
    case 'Compass': return <Compass className="h-4 w-4" />;
    case 'Palmtree': return <Palmtree className="h-4 w-4" />;
    case 'FileCheck': return <FileCheck className="h-4 w-4" />;
    case 'Landmark': return <Landmark className="h-4 w-4" />;
    case 'Moon': return <Moon className="h-4 w-4" />;
    case 'Wallet': return <Wallet className="h-4 w-4" />;
    case 'Ticket': return <Ticket className="h-4 w-4" />;
    case 'Users': return <Users className="h-4 w-4" />;
    case 'Shield': return <Shield className="h-4 w-4" />;
    case 'Sparkles': return <Sparkles className="h-4 w-4" />;
    case 'User': return <User className="h-4 w-4" />;
    case 'Settings': return <Settings className="h-4 w-4" />;
    case 'ShieldAlert': return <ShieldAlert className="h-4 w-4" />;
    default: return <LayoutDashboard className="h-4 w-4" />;
  }
};

export const MasariSidebar: React.FC<MasariSidebarProps> = ({
  currentPath,
  onNavigate,
  language,
  userRole,
  isCollapsed,
  onToggleCollapse,
}) => {
  const isArabic = language === 'ar';

  const categories = [
    { key: 'travel', nameAr: 'خدمات السفر والقطاعات', nameEn: 'Travel Sectors' },
    { key: 'spiritual', nameAr: 'باقات الحج والعمرة', nameEn: 'Hajj & Umrah' },
    { key: 'account', nameAr: 'المحفظة والحساب', nameEn: 'Account & Services' },
  ];

  return (
    <aside
      className={`hidden md:flex flex-col border-l border-slate-200 dark:border-[#00D4FF]/20 bg-white dark:bg-[#050914] text-slate-900 dark:text-[#F8FAFC] transition-all duration-300 ${
        isCollapsed ? 'w-20' : 'w-64'
      } h-[calc(100vh-4rem)] sticky top-16 z-30`}
    >
      {/* Collapse Toggle Header */}
      <div className="flex items-center justify-between p-4 border-b border-slate-200 dark:border-[#1E293B]">
        {!isCollapsed && (
          <span className="text-xs font-bold text-[#008DDA] dark:text-[#00D4FF] tracking-wider uppercase">
            {isArabic ? 'دليل الخدمات' : 'Service Directory'}
          </span>
        )}
        <button
          onClick={onToggleCollapse}
          className="p-1.5 rounded-lg bg-slate-100 dark:bg-[#0A1631] text-slate-500 hover:text-[#008DDA] dark:text-[#94A3B8] dark:hover:text-[#00D4FF] hover:bg-slate-200 dark:hover:bg-[#0A1631]/80 transition-colors"
        >
          {isCollapsed ? (
            isArabic ? <ChevronLeft className="h-4 w-4" /> : <ChevronRight className="h-4 w-4" />
          ) : (
            isArabic ? <ChevronRight className="h-4 w-4" /> : <ChevronLeft className="h-4 w-4" />
          )}
        </button>
      </div>

      {/* Navigation List */}
      <div className="flex-1 overflow-y-auto p-3 space-y-6 custom-scrollbar">
        {categories.map((cat) => {
          const catRoutes = MASARI_ROUTES.filter((r) => r.category === cat.key);
          return (
            <div key={cat.key} className="space-y-1">
              {!isCollapsed && (
                <div className="px-3 py-1 text-[11px] font-semibold text-slate-400 dark:text-[#64748B] uppercase tracking-wider">
                  {isArabic ? cat.nameAr : cat.nameEn}
                </div>
              )}
              {catRoutes.map((route) => {
                const isActive = currentPath === route.path;
                const isProtected = route.protectedRole && route.protectedRole !== 'guest' && userRole === 'guest';

                return (
                  <button
                    key={route.id}
                    onClick={() => onNavigate(route.path)}
                    className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-xl text-xs font-medium transition-all ${
                      isActive
                        ? 'bg-gradient-to-r from-[#008DDA] to-[#0B192C] text-white font-bold shadow-md shadow-[#008DDA]/25 dark:from-[#00D4FF] dark:to-[#008DDA] dark:text-[#050914]'
                        : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-[#94A3B8] dark:hover:bg-[#0A1631] dark:hover:text-[#F8FAFC]'
                    } ${isProtected ? 'opacity-60' : ''}`}
                    title={isArabic ? route.titleAr : route.titleEn}
                  >
                    <span className={isActive ? 'text-white dark:text-[#050914]' : 'text-[#008DDA] dark:text-[#00D4FF]'}>
                      {getIcon(route.icon)}
                    </span>
                    {!isCollapsed && (
                      <div className="flex-1 flex items-center justify-between text-right">
                        <span>{isArabic ? route.titleAr : route.titleEn}</span>
                        {route.badge && (
                          <span
                            className={`px-1.5 py-0.5 rounded text-[9px] font-bold ${
                              isActive
                                ? 'bg-white/20 text-white dark:bg-[#050914] dark:text-[#00D4FF]'
                                : 'bg-[#00D4FF]/15 text-[#008DDA] dark:bg-[#00D4FF]/20 dark:text-[#00D4FF]'
                            }`}
                          >
                            {route.badge}
                          </span>
                        )}
                      </div>
                    )}
                  </button>
                );
              })}
            </div>
          );
        })}
      </div>

      {/* Footer / Trust Guarantee Indicator */}
      {!isCollapsed && (
        <div className="p-4 border-t border-slate-200 dark:border-[#1E293B] bg-slate-50 dark:bg-[#0A1631]/50 text-center">
          <div className="flex items-center justify-center gap-2 text-[10px] text-[#008DDA] dark:text-[#00D4FF] font-bold">
            <span className="h-2 w-2 rounded-full bg-[#10B981] animate-pulse"></span>
            <span>{isArabic ? 'خدمة معتمدة ودفع آمن 100%' : 'Certified & 100% Secure'}</span>
          </div>
        </div>
      )}
    </aside>
  );
};
