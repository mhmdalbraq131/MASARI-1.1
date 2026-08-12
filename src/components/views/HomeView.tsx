import React from 'react';
import {
  Sparkles,
  Search,
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
  UserCheck,
  ShieldAlert,
  ArrowRight,
  Star,
  CheckCircle2
} from 'lucide-react';
import { Language } from '../../types';

interface HomeViewProps {
  language: Language;
  onNavigate: (path: string) => void;
}

export const HomeView: React.FC<HomeViewProps> = ({ language, onNavigate }) => {
  const isArabic = language === 'ar';

  const services = [
    { path: '/flights', titleAr: 'رحلات الطيران', titleEn: 'Flights Route', icon: Plane, color: '#00D4FF', badge: 'الطيران' },
    { path: '/hotels', titleAr: 'الفنادق والإقامة', titleEn: 'Hotels Route', icon: Hotel, color: '#D4AF37', badge: 'فنادق' },
    { path: '/bus', titleAr: 'حجوزات الحافلات', titleEn: 'Bus Route', icon: Bus, color: '#FF7F50', badge: 'حافلات' },
    { path: '/cars', titleAr: 'تأجير السيارات', titleEn: 'Cars Route', icon: Car, color: '#38BDF8', badge: 'سيارات' },
    { path: '/transfers', titleAr: 'النقل الخاص', titleEn: 'Transfers Route', icon: Compass, color: '#3B82F6', badge: 'توصيل' },
    { path: '/tourism', titleAr: 'الباقات السياحية', titleEn: 'Tourism Route', icon: Palmtree, color: '#10B981', badge: 'سياحة' },
    { path: '/hajj', titleAr: 'باقات الحج', titleEn: 'Hajj Route', icon: Landmark, color: '#B8860B', badge: 'حج' },
    { path: '/umrah', titleAr: 'خدمات العمرة', titleEn: 'Umrah Route', icon: Moon, color: '#050914', badge: 'عمرة' },
  ];

  const quickRoutes = [
    { path: '/wallet', titleAr: 'محفظة مساري', titleEn: 'Wallet Route', icon: Wallet },
    { path: '/bookings', titleAr: 'سجل الحجوزات', titleEn: 'Bookings Route', icon: Ticket },
    { path: '/travelers', titleAr: 'إدارة المسافرين', titleEn: 'Travelers Route', icon: Users },
    { path: '/passports', titleAr: 'مركز الجوازات', titleEn: 'Passports Route', icon: Shield },
    { path: '/ai', titleAr: 'مساعد AI الذكي', titleEn: 'AI Assistant Route', icon: Sparkles },
    { path: '/admin', titleAr: 'بوابة الإدارة', titleEn: 'Admin Portal Route', icon: ShieldAlert },
  ];

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-7xl mx-auto">
      {/* Luxury Welcome Banner */}
      <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-[#0A1631] via-[#050914] to-[#0A1631] border border-[#D4AF37]/30 p-6 md:p-8 shadow-2xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 bg-[#D4AF37]/10 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-4">
          <div className="flex items-center justify-between">
            <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#D4AF37]/15 border border-[#D4AF37]/30 text-xs font-bold text-[#D4AF37]">
              <Star className="h-3.5 w-3.5 fill-[#D4AF37]" />
              {isArabic ? 'منصة مساري الملكية' : 'MASARI Royal Platform'}
            </span>
            <Sparkles className="h-6 w-6 text-[#D4AF37] animate-pulse" />
          </div>

          <h1 className="text-2xl md:text-4xl font-extrabold text-[#D4AF37] tracking-tight">
            {isArabic ? 'أهلاً بك في مساري (MASARI)' : 'Welcome to MASARI'}
          </h1>

          <p className="text-sm md:text-base text-[#94A3B8] max-w-2xl leading-relaxed">
            {isArabic
              ? 'الأساس الهندسي والجاهزية الفنية المتكاملة لكافة قطاعات السفر، السياحة، والحج والعمرة.'
              : 'Architectural foundation & complete operational readiness for Travel, Tourism, Hajj & Umrah.'}
          </p>

          <div className="flex flex-wrap gap-2 pt-2">
            <span className="px-2.5 py-1 rounded-lg bg-[#D4AF37] text-[#050914] text-xs font-bold">
              Riverpod
            </span>
            <span className="px-2.5 py-1 rounded-lg bg-[#0A1631] border border-[#1E293B] text-[#F8FAFC] text-xs font-semibold">
              GoRouter
            </span>
            <span className="px-2.5 py-1 rounded-lg bg-[#00D4FF]/20 border border-[#00D4FF]/30 text-[#00D4FF] text-xs font-semibold">
              Clean Architecture
            </span>
            <span className="px-2.5 py-1 rounded-lg bg-[#FF7F50]/20 border border-[#FF7F50]/30 text-[#FF7F50] text-xs font-semibold">
              Firebase Architecture
            </span>
          </div>
        </div>
      </div>

      {/* Global Search Bar */}
      <div className="relative">
        <Search className={`absolute ${isArabic ? 'right-4' : 'left-4'} top-1/2 -translate-y-1/2 h-5 w-5 text-[#D4AF37]`} />
        <input
          type="text"
          placeholder={
            isArabic
              ? 'ابحث عن الرحلات، الفنادق، أو باقات الحج والعمرة...'
              : 'Search flights, hotels, or Hajj & Umrah packages...'
          }
          className={`w-full h-14 rounded-2xl bg-[#0A1631] border border-[#1E293B] ${
            isArabic ? 'pr-12 pl-4' : 'pl-12 pr-4'
          } text-sm text-[#F8FAFC] placeholder-[#64748B] focus:outline-none focus:border-[#D4AF37] transition-all shadow-inner`}
        />
      </div>

      {/* Primary Travel Services Section */}
      <div className="space-y-4">
        <div>
          <h2 className="text-lg md:text-xl font-bold text-[#F8FAFC]">
            {isArabic ? 'قطاعات السفر والخدمات' : 'Travel Sectors & Services'}
          </h2>
          <p className="text-xs text-[#64748B]">
            {isArabic ? 'اختر الخدمة للتوجه إلى معمارية التوجيه الخاصة بها' : 'Select a service route to inspect architecture'}
          </p>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
          {services.map((item) => {
            const Icon = item.icon;
            return (
              <div
                key={item.path}
                onClick={() => onNavigate(item.path)}
                className="group cursor-pointer rounded-2xl bg-[#0A1631] border border-[#1E293B] hover:border-[#D4AF37]/50 p-5 transition-all duration-300 hover:-translate-y-1 shadow-lg hover:shadow-[#D4AF37]/10 flex flex-col items-center text-center justify-center space-y-3"
              >
                <div
                  className="p-3.5 rounded-2xl transition-transform group-hover:scale-110"
                  style={{ backgroundColor: `${item.color}20`, color: item.color }}
                >
                  <Icon className="h-6 w-6 stroke-[2]" />
                </div>
                <div>
                  <div className="text-sm font-bold text-[#F8FAFC] group-hover:text-[#D4AF37] transition-colors">
                    {isArabic ? item.titleAr : item.titleEn}
                  </div>
                  <div className="text-[11px] text-[#64748B] font-mono mt-0.5">
                    {item.path}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Account & Management Section */}
      <div className="space-y-4">
        <div>
          <h2 className="text-lg md:text-xl font-bold text-[#F8FAFC]">
            {isArabic ? 'إدارة الحساب والمسافرين' : 'Account & Traveler Center'}
          </h2>
          <p className="text-xs text-[#64748B]">
            {isArabic ? 'بنية المسارات المحمية والمحفظة الملكية' : 'Protected routes architecture'}
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {quickRoutes.map((route) => {
            const Icon = route.icon;
            return (
              <div
                key={route.path}
                onClick={() => onNavigate(route.path)}
                className="group cursor-pointer rounded-2xl bg-[#0A1631] border border-[#1E293B] hover:border-[#D4AF37]/50 p-4 transition-all duration-200 flex items-center gap-4"
              >
                <div className="p-3 rounded-xl bg-[#D4AF37]/15 text-[#D4AF37] group-hover:bg-[#D4AF37] group-hover:text-[#050914] transition-colors">
                  <Icon className="h-5 w-5" />
                </div>
                <div className="flex-1">
                  <div className="text-sm font-bold text-[#F8FAFC] group-hover:text-[#D4AF37] transition-colors">
                    {isArabic ? route.titleAr : route.titleEn}
                  </div>
                  <div className="text-[11px] text-[#64748B] font-mono">
                    {route.path}
                  </div>
                </div>
                <ArrowRight className={`h-4 w-4 text-[#64748B] ${isArabic ? 'rotate-180 group-hover:-translate-x-1' : 'group-hover:translate-x-1'} transition-transform`} />
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};
