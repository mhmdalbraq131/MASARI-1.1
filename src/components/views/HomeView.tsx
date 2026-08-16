import React, { useState } from 'react';
import {
  Plane,
  Hotel,
  Bus,
  Car,
  Compass,
  Palmtree,
  Landmark,
  Moon,
  FileCheck,
  Search,
  Sparkles,
  Star,
  MapPin,
  Calendar,
  Users,
  ShieldCheck,
  ArrowRight,
  ChevronRight,
  Clock,
  Check
} from 'lucide-react';
import { Language, UserRole } from '../../types';
import { TOURISM_PACKAGES, HAJJ_UMRAH_PACKAGES, HOTELS_LIST } from '../../data/travelData';
import { SafeImage } from '../SafeImage';

interface HomeViewProps {
  language: Language;
  userRole: UserRole;
  onNavigate: (path: string) => void;
}

export const HomeView: React.FC<HomeViewProps> = ({
  language,
  userRole,
  onNavigate,
}) => {
  const isArabic = language === 'ar';
  const [activeSearchTab, setActiveSearchTab] = useState<'flights' | 'hotels' | 'tourism' | 'hajj'>('flights');
  const [searchQuery, setSearchQuery] = useState('');

  const services = [
    { 
      path: '/flights', 
      titleAr: 'رحلات الطيران', 
      titleEn: 'Flights Booking', 
      descAr: 'طيران محلي ودولي وأجنحة خاصة',
      descEn: 'Domestic, international & private aviation',
      icon: Plane, 
      color: '#008DDA', 
      badge: isArabic ? 'طيران' : 'Flights' 
    },
    { 
      path: '/hotels', 
      titleAr: 'الفنادق والإقامة', 
      titleEn: 'Hotels & Resorts', 
      descAr: 'فنادق مكة، المدينة وكافة الوجهات',
      descEn: 'Makkah, Madinah & luxury resorts',
      icon: Hotel, 
      color: '#00D4FF', 
      badge: isArabic ? 'فنادق' : 'Hotels' 
    },
    { 
      path: '/hajj', 
      titleAr: 'باقات الحج الملكية', 
      titleEn: 'Royal Hajj Packages', 
      descAr: 'مخيمات VIP مطورة وإرشاد شامل',
      descEn: 'VIP Mina camps & complete guidance',
      icon: Landmark, 
      color: '#FF6500', 
      badge: isArabic ? 'حج VIP' : 'Hajj VIP' 
    },
    { 
      path: '/umrah', 
      titleAr: 'خدمات العمرة', 
      titleEn: 'Umrah Services', 
      descAr: 'برامج عمرة ميسرة وتأشيرات فورية',
      descEn: 'Tailored Umrah & instant e-Visas',
      icon: Moon, 
      color: '#008DDA', 
      badge: isArabic ? 'عمرة' : 'Umrah' 
    },
    { 
      path: '/tourism', 
      titleAr: 'الباقات السياحية', 
      titleEn: 'Tourism Tours', 
      descAr: 'رحلات العلا، الرياض وسفاري التراث',
      descEn: 'AlUla, Riyadh & heritage safaris',
      icon: Palmtree, 
      color: '#00D4FF', 
      badge: isArabic ? 'سياحة' : 'Tours' 
    },
    { 
      path: '/cars', 
      titleAr: 'تأجير السيارات الفاخرة', 
      titleEn: 'Luxury Car Rental', 
      descAr: 'مايباخ، يوكون وخدمات السائق الخاص',
      descEn: 'Maybach, Yukon with private chauffeur',
      icon: Car, 
      color: '#1E3E62', 
      badge: isArabic ? 'سيارات' : 'Cars' 
    },
    { 
      path: '/bus', 
      titleAr: 'حافلات النقل VIP', 
      titleEn: 'VIP Coach Transport', 
      descAr: 'حافلات سياحية حديثة ومكيفة',
      descEn: 'Modern air-conditioned tourist coaches',
      icon: Bus, 
      color: '#FF6500', 
      badge: isArabic ? 'حافلات' : 'Buses' 
    },
    { 
      path: '/visa', 
      titleAr: 'التأشيرات والفيزا', 
      titleEn: 'Visa & Entry Permits', 
      descAr: 'تأشيرات سياحية وتصاريح نسك',
      descEn: 'Instant e-Visa & Nusuk permits',
      icon: FileCheck, 
      color: '#008DDA', 
      badge: isArabic ? 'تأشيرات' : 'Visas' 
    },
  ];

  const featuredTours = TOURISM_PACKAGES.slice(0, 3);
  const featuredPilgrimage = HAJJ_UMRAH_PACKAGES.slice(0, 2);

  return (
    <div className="p-4 sm:p-6 md:p-8 space-y-8 md:space-y-10 max-w-7xl mx-auto w-full transition-colors overflow-hidden">
      {/* Hero Welcome Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-5 sm:p-8 md:p-12 shadow-2xl">
        <div className="absolute top-0 right-0 -mr-20 -mt-20 w-80 sm:w-96 h-80 sm:h-96 bg-[#00D4FF]/20 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-4 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/30 text-xs font-bold text-[#00D4FF] whitespace-nowrap">
            <Sparkles className="h-4 w-4 shrink-0" />
            <span className="truncate">{isArabic ? 'منصة مساري الملكية للسفر والسياحة والحج والعمرة' : 'MASARI — Royal Travel & Pilgrimage Platform'}</span>
          </div>

          <h1 className="text-xl sm:text-3xl md:text-5xl font-black tracking-tight text-white leading-tight">
            {isArabic ? 'بوابتك إلى أروع الرحلات والمناسك الروحانية' : 'Your Gateway to Extraordinary Journeys'}
          </h1>

          <p className="text-xs sm:text-sm md:text-base text-slate-200 leading-relaxed max-w-2xl">
            {isArabic
              ? 'وجهتك الشاملة لحجز رحلات الطيران الفاخرة، أرقى فنادق الحرمين والوجهات السياحية، باقات الحج والعمرة الملكية، وأسطول النقل الخاص.'
              : 'Complete travel ecosystem for booking flights, luxury 5-star Haramain hotels, royal pilgrimage packages, and VIP chauffeur transfers.'}
          </p>

          <div className="flex flex-col sm:flex-row gap-3 pt-2">
            <button
              onClick={() => onNavigate('/tourism')}
              className="h-11 px-6 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-extrabold text-xs shadow-lg transition-all active:scale-95 flex items-center justify-center gap-2"
            >
              <Palmtree className="h-4 w-4 shrink-0" />
              <span>{isArabic ? 'استكشف الباقات السياحية' : 'Explore Tours'}</span>
            </button>
            <button
              onClick={() => onNavigate('/hajj')}
              className="h-11 px-6 rounded-xl bg-[#00D4FF] hover:bg-[#00B4D8] text-[#050914] font-extrabold text-xs shadow-lg transition-all active:scale-95 flex items-center justify-center gap-2"
            >
              <Landmark className="h-4 w-4 shrink-0" />
              <span>{isArabic ? 'باقات الحج والعمرة' : 'Hajj & Umrah'}</span>
            </button>
          </div>
        </div>
      </div>

      {/* Quick Search Widget */}
      <div className="rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-4 sm:p-6 shadow-sm space-y-4 sm:space-y-5">
        {/* Tabs */}
        <div className="flex items-center gap-2 overflow-x-auto border-b border-slate-100 dark:border-slate-800 pb-3 scrollbar-none">
          {[
            { key: 'flights', labelAr: 'طيران', labelEn: 'Flights', icon: Plane },
            { key: 'hotels', labelAr: 'فنادق', labelEn: 'Hotels', icon: Hotel },
            { key: 'tourism', labelAr: 'سياحة', labelEn: 'Tours', icon: Palmtree },
            { key: 'hajj', labelAr: 'حج وعمرة', labelEn: 'Hajj/Umrah', icon: Landmark },
          ].map((tab) => {
            const Icon = tab.icon;
            const isActive = activeSearchTab === tab.key;
            return (
              <button
                key={tab.key}
                onClick={() => setActiveSearchTab(tab.key as any)}
                className={`flex items-center gap-2 px-4 sm:px-5 py-2.5 rounded-xl text-xs font-extrabold transition-all whitespace-nowrap shrink-0 ${
                  isActive
                    ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
                    : 'bg-slate-50 dark:bg-slate-800 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-700'
                }`}
              >
                <Icon className="h-4 w-4" />
                <span>{isArabic ? tab.labelAr : tab.labelEn}</span>
              </button>
            );
          })}
        </div>

        {/* Input Bar */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-3 sm:gap-4">
          <div className="md:col-span-3 relative">
            <Search className={`absolute ${isArabic ? 'right-4' : 'left-4'} top-1/2 -translate-y-1/2 h-5 w-5 text-slate-400`} />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder={
                activeSearchTab === 'flights'
                  ? (isArabic ? 'ابحث عن وجهات الطيران (مثال: الرياض، جدة، دبي، لندن)...' : 'Search flights (e.g. Riyadh, Jeddah, Dubai)...')
                  : activeSearchTab === 'hotels'
                  ? (isArabic ? 'ابحث عن الفنادق المطلة على الحرمين أو المنتجعات...' : 'Search luxury hotels or resorts...')
                  : activeSearchTab === 'tourism'
                  ? (isArabic ? 'ابحث عن جولات العلا، الرياض، أبها، التراث...' : 'Search tours in AlUla, Riyadh, Abha...')
                  : (isArabic ? 'ابحث عن باقات الحج والعمرة وتصاريح نسك...' : 'Search Hajj & Umrah packages...')
              }
              className={`w-full h-12 rounded-2xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 ${
                isArabic ? 'pr-12 pl-4' : 'pl-12 pr-4'
              } text-xs sm:text-sm font-bold text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-[#00D4FF]`}
            />
          </div>

          <button
            onClick={() => onNavigate(`/${activeSearchTab}`)}
            className="h-12 w-full rounded-2xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-extrabold text-xs flex items-center justify-center gap-2 shadow-md transition-all active:scale-95"
          >
            <Search className="h-4 w-4" />
            <span>{isArabic ? 'ابحث الآن' : 'Search Now'}</span>
          </button>
        </div>
      </div>

      {/* Services Grid Section */}
      <div className="space-y-4">
        <div>
          <h2 className="text-lg sm:text-xl md:text-2xl font-extrabold text-[#0B192C] dark:text-white">
            {isArabic ? 'قطاعات السفر والخدمات' : 'Travel Services & Sectors'}
          </h2>
          <p className="text-xs text-slate-500">
            {isArabic ? 'اختر الخدمة لحجز رحلتك أو إقامتك بأعلى درجات الرفاهية' : 'Choose a sector to book your journey'}
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
          {services.map((item) => {
            const Icon = item.icon;
            return (
              <div
                key={item.path}
                onClick={() => onNavigate(item.path)}
                className="group cursor-pointer rounded-2xl sm:rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] hover:border-[#00D4FF]/60 p-4 sm:p-5 transition-all duration-300 hover:-translate-y-1 shadow-sm hover:shadow-lg dark:shadow-none flex flex-col justify-between space-y-3 w-full min-w-0"
              >
                <div className="flex items-center justify-between gap-2">
                  <div
                    className="p-2.5 sm:p-3 rounded-xl sm:rounded-2xl transition-transform group-hover:scale-110 shrink-0"
                    style={{ backgroundColor: `${item.color}15`, color: item.color }}
                  >
                    <Icon className="h-5 sm:h-6 w-5 sm:w-6 stroke-[2]" />
                  </div>
                  <span className="px-2.5 py-1 rounded-full bg-slate-100 dark:bg-slate-800 text-[10px] sm:text-[11px] font-bold text-slate-600 dark:text-slate-400 whitespace-nowrap">
                    {item.badge}
                  </span>
                </div>

                <div className="min-w-0 space-y-1">
                  <h3 className="text-sm sm:text-base font-extrabold text-[#0B192C] dark:text-white group-hover:text-[#008DDA] dark:group-hover:text-[#00D4FF] transition-colors">
                    {isArabic ? item.titleAr : item.titleEn}
                  </h3>
                  <p className="text-xs text-slate-500 dark:text-slate-400 leading-relaxed">
                    {isArabic ? item.descAr : item.descEn}
                  </p>
                </div>

                <div className="flex items-center gap-1 text-xs font-bold text-[#008DDA] dark:text-[#00D4FF] pt-1">
                  <span>{isArabic ? 'حجز فوري' : 'Book Direct'}</span>
                  <ArrowRight className={`h-3.5 w-3.5 ${isArabic ? 'rotate-180 group-hover:-translate-x-1' : 'group-hover:translate-x-1'} transition-transform`} />
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Featured Tourism Packages Section */}
      <div className="space-y-4">
        <div className="flex items-center justify-between gap-2">
          <div>
            <h2 className="text-lg sm:text-xl md:text-2xl font-extrabold text-[#0B192C] dark:text-white">
              {isArabic ? 'أبرز الجولات والباقات السياحية' : 'Featured Tourism Packages'}
            </h2>
            <p className="text-xs text-slate-500">
              {isArabic ? 'برامج مصممة بعناية لاستكشاف أجمل معالم المملكة' : 'Curated authentic experiences across the Kingdom'}
            </p>
          </div>
          <button
            onClick={() => onNavigate('/tourism')}
            className="text-xs font-bold text-[#008DDA] dark:text-[#00D4FF] hover:underline flex items-center gap-1 whitespace-nowrap"
          >
            <span>{isArabic ? 'عرض كافة البرامج' : 'View All Tours'}</span>
            <ArrowRight className={`h-3.5 w-3.5 ${isArabic ? 'rotate-180' : ''}`} />
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-5 sm:gap-6">
          {featuredTours.map((tour) => (
            <div
              key={tour.id}
              onClick={() => onNavigate('/tourism')}
              className="group cursor-pointer rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all duration-300 flex flex-col justify-between w-full min-w-0"
            >
              {/* Card Image Container with Badges */}
              <div className="relative aspect-[16/10] sm:h-52 w-full overflow-hidden bg-slate-200 dark:bg-slate-800 shrink-0">
                <SafeImage
                  src={tour.image}
                  alt={isArabic ? tour.titleAr : tour.titleEn}
                  className="h-full w-full object-cover group-hover:scale-105 transition-transform duration-500"
                  fallbackIcon={<Palmtree className="h-8 w-8 text-[#00D4FF]" />}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-black/20 pointer-events-none"></div>

                <div className="absolute top-3 right-3 px-2.5 py-1 rounded-xl bg-black/70 backdrop-blur-md text-white text-xs font-bold flex items-center gap-1 border border-white/10">
                  <Star className="h-3 w-3 text-[#FF6500] fill-[#FF6500]" />
                  <span>{tour.rating}</span>
                </div>
                <div className="absolute bottom-3 right-3 left-3 text-white text-xs flex items-center gap-1">
                  <MapPin className="h-3.5 w-3.5 text-[#00D4FF] shrink-0" />
                  <span className="truncate">{isArabic ? tour.locationAr : tour.locationEn}</span>
                </div>
              </div>

              {/* Card Body */}
              <div className="p-4 sm:p-5 space-y-3 flex-1 flex flex-col justify-between">
                <div className="space-y-1.5">
                  <h3 className="text-base font-extrabold text-[#0B192C] dark:text-white leading-snug group-hover:text-[#008DDA] dark:group-hover:text-[#00D4FF] transition-colors">
                    {isArabic ? tour.titleAr : tour.titleEn}
                  </h3>
                  <p className="text-xs text-slate-600 dark:text-slate-400 leading-relaxed line-clamp-2">
                    {isArabic ? tour.descriptionAr : tour.descriptionEn}
                  </p>
                </div>

                <div className="pt-3 border-t border-slate-100 dark:border-slate-800 flex flex-col xs:flex-row sm:flex-row items-stretch xs:items-center sm:items-center justify-between gap-3">
                  <div>
                    <span className="text-[10px] text-slate-400 block">{isArabic ? 'السعر للشخص' : 'From'}</span>
                    <span className="text-base sm:text-lg font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {tour.price.toLocaleString()} {isArabic ? tour.currencyAr : tour.currencyEn}
                    </span>
                  </div>
                  <button className="w-full xs:w-auto sm:w-auto h-10 px-5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-sm transition-all active:scale-95 text-center">
                    {isArabic ? 'احجز الآن' : 'Book'}
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Featured Royal Pilgrimage Section */}
      <div className="space-y-4">
        <div className="flex items-center justify-between gap-2">
          <div>
            <h2 className="text-lg sm:text-xl md:text-2xl font-extrabold text-[#0B192C] dark:text-white">
              {isArabic ? 'باقات ضيوف الرحمن الملكية (الحج والعمرة)' : 'Royal Hajj & Umrah Pilgrimage'}
            </h2>
            <p className="text-xs text-slate-500">
              {isArabic ? 'سكينة، فخامة، وأعلى مستويات الخدمة المعتمدة' : 'Spiritual sanctuary with VIP accommodation'}
            </p>
          </div>
          <button
            onClick={() => onNavigate('/hajj')}
            className="text-xs font-bold text-[#008DDA] dark:text-[#00D4FF] hover:underline flex items-center gap-1 whitespace-nowrap"
          >
            <span>{isArabic ? 'عرض باقات الحج والعمرة' : 'View All Pilgrimage'}</span>
            <ArrowRight className={`h-3.5 w-3.5 ${isArabic ? 'rotate-180' : ''}`} />
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-5 sm:gap-6">
          {featuredPilgrimage.map((pkg) => (
            <div
              key={pkg.id}
              onClick={() => onNavigate(pkg.type === 'hajj' ? '/hajj' : '/umrah')}
              className="group cursor-pointer flex flex-col md:flex-row rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all w-full min-w-0"
            >
              {/* Image at TOP on mobile, side on desktop */}
              <div className="relative aspect-[16/10] md:aspect-auto md:w-2/5 h-48 sm:h-56 md:h-auto overflow-hidden bg-slate-200 dark:bg-slate-800 shrink-0">
                <SafeImage
                  src={pkg.image}
                  alt={isArabic ? pkg.titleAr : pkg.titleEn}
                  className="h-full w-full object-cover group-hover:scale-105 transition-transform duration-500"
                  fallbackIcon={<Landmark className="h-8 w-8 text-[#00D4FF]" />}
                />
                <div className="absolute top-3 right-3 px-2.5 py-1 rounded-xl bg-[#00D4FF] text-[#050914] text-xs font-black shadow-md">
                  {isArabic ? pkg.badgeAr : pkg.badgeEn}
                </div>
              </div>

              <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between space-y-4">
                <div className="space-y-2">
                  <h3 className="text-base sm:text-lg font-extrabold text-[#0B192C] dark:text-white leading-snug group-hover:text-[#008DDA] dark:group-hover:text-[#00D4FF] transition-colors">
                    {isArabic ? pkg.titleAr : pkg.titleEn}
                  </h3>
                  <div className="space-y-1.5 text-xs text-slate-600 dark:text-slate-400">
                    <div className="flex items-center gap-2">
                      <Hotel className="h-4 w-4 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                      <span className="font-semibold">{isArabic ? pkg.hotelMakkahAr : pkg.hotelMakkahEn}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Clock className="h-4 w-4 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                      <span>{pkg.durationDays} {isArabic ? 'يوماً من الراحة والسكينة' : 'Days Pilgrimage'}</span>
                    </div>
                  </div>
                </div>

                <div className="pt-3 border-t border-slate-100 dark:border-slate-800 flex flex-col xs:flex-row sm:flex-row items-stretch xs:items-center sm:items-center justify-between gap-3">
                  <div>
                    <span className="text-[10px] text-slate-400 block">{isArabic ? 'سعر الباقة الشاملة' : 'Total Package'}</span>
                    <div className="text-lg sm:text-xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {pkg.price.toLocaleString()} {isArabic ? 'ر.س' : 'SAR'}
                    </div>
                  </div>
                  <button className="w-full xs:w-auto sm:w-auto h-10 px-6 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-sm transition-all active:scale-95 text-center">
                    {isArabic ? 'طلب الباقة' : 'Reserve'}
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Why Choose MASARI Guarantee Bar */}
      <div className="rounded-3xl bg-slate-100 dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-5 sm:p-6 md:p-8 space-y-4">
        <h3 className="text-center text-base md:text-lg font-extrabold text-[#0B192C] dark:text-white">
          {isArabic ? 'لماذا يختار النخبة منصة مساري؟' : 'Why Elite Travelers Choose MASARI'}
        </h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 pt-2">
          {[
            {
              titleAr: 'أرقى معايير الفخامة والضيافة',
              titleEn: '5-Star Luxury Standards',
              descAr: 'شراكات مع أفخم الفنادق والخطوط الجوية وخدمات الكونسيرج الخاصة.',
              descEn: 'Exclusive partnerships with top 5-star hotels and private aviation.',
            },
            {
              titleAr: 'مرشدون وخبراء محليون معتمدون',
              titleEn: 'Certified Local Guides & Scholars',
              descAr: 'كادر إرشادي متخصص يضمن جولات سياحية ومناسك دقيقة ومريحة.',
              descEn: 'Dedicated experts ensuring rich heritage tours and seamless rituals.',
            },
            {
              titleAr: 'تأكيد فوري ودفع إلكتروني آمن',
              titleEn: 'Instant Confirmation & Secure Pay',
              descAr: 'حجوزات فورية مباشرة مع دعم العملاء على مدار 24 ساعة طوال الأسبوع.',
              descEn: 'Direct ticket issuance with 24/7 priority concierge support.',
            },
          ].map((item, idx) => (
            <div key={idx} className="p-4 rounded-2xl bg-white dark:bg-[#050914] border border-slate-200 dark:border-slate-800 space-y-2">
              <div className="flex items-center gap-2 text-xs font-extrabold text-[#008DDA] dark:text-[#00D4FF]">
                <ShieldCheck className="h-4 w-4 shrink-0" />
                <span>{isArabic ? item.titleAr : item.titleEn}</span>
              </div>
              <p className="text-xs text-slate-600 dark:text-slate-400 leading-relaxed">
                {isArabic ? item.descAr : item.descEn}
              </p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
