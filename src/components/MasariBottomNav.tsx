import React from 'react';
import { LayoutDashboard, Plane, Landmark, Wallet, User } from 'lucide-react';
import { Language } from '../types';

interface MasariBottomNavProps {
  currentPath: string;
  onNavigate: (path: string) => void;
  language: Language;
}

export const MasariBottomNav: React.FC<MasariBottomNavProps> = ({
  currentPath,
  onNavigate,
  language,
}) => {
  const isArabic = language === 'ar';

  const items = [
    { path: '/home', icon: LayoutDashboard, labelAr: 'الرئيسية', labelEn: 'Home' },
    { path: '/flights', icon: Plane, labelAr: 'الطيران', labelEn: 'Flights' },
    { path: '/hajj', icon: Landmark, labelAr: 'الحج والعمرة', labelEn: 'Hajj' },
    { path: '/wallet', icon: Wallet, labelAr: 'المحفظة', labelEn: 'Wallet' },
    { path: '/profile', icon: User, labelAr: 'حسابي', labelEn: 'Profile' },
  ];

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 z-40 bg-[#050914]/95 border-t border-[#D4AF37]/20 backdrop-blur-md">
      <div className="flex justify-around items-center h-16 px-2">
        {items.map((item) => {
          const Icon = item.icon;
          const isActive = currentPath === item.path;
          return (
            <button
              key={item.path}
              onClick={() => onNavigate(item.path)}
              className={`flex flex-col items-center justify-center w-full h-full py-1 ${
                isActive ? 'text-[#D4AF37]' : 'text-[#64748B]'
              }`}
            >
              <Icon className={`h-5 w-5 ${isActive ? 'scale-110' : ''} transition-transform`} />
              <span className="text-[10px] font-semibold mt-1">
                {isArabic ? item.labelAr : item.labelEn}
              </span>
            </button>
          );
        })}
      </div>
    </nav>
  );
};
