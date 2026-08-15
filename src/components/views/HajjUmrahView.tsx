import React, { useState } from 'react';
import { 
  Landmark, 
  Moon, 
  MapPin, 
  Check, 
  ShieldCheck, 
  Star, 
  Clock, 
  Hotel, 
  Sparkles,
  Calendar,
  ChevronRight
} from 'lucide-react';
import { Language } from '../../types';
import { HAJJ_UMRAH_PACKAGES, HajjUmrahPackage } from '../../data/travelData';

interface HajjUmrahViewProps {
  language: Language;
  currentType: 'hajj' | 'umrah';
  onNavigate: (path: string) => void;
}

export const HajjUmrahView: React.FC<HajjUmrahViewProps> = ({ language, currentType, onNavigate }) => {
  const isArabic = language === 'ar';
  const [activeTab, setActiveTab] = useState<'hajj' | 'umrah'>(currentType);
  const [bookedPkg, setBookedPkg] = useState<HajjUmrahPackage | null>(null);

  const packages = HAJJ_UMRAH_PACKAGES.filter((p) => p.type === activeTab);

  const handleBook = (pkg: HajjUmrahPackage) => {
    setBookedPkg(pkg);
    setTimeout(() => {
      setBookedPkg(null);
    }, 4000);
  };

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-7xl mx-auto w-full transition-colors">
      {/* Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-6 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-72 h-72 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            {activeTab === 'hajj' ? <Landmark className="h-4 w-4" /> : <Moon className="h-4 w-4" />}
            <span>{isArabic ? 'خدمات ضيوف الرحمن الملكية' : 'Royal Pilgrimage Services'}</span>
          </div>
          <h1 className="text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {activeTab === 'hajj' 
              ? (isArabic ? 'باقات الحج الملكية الشاملة' : 'Exclusive Royal Hajj Packages')
              : (isArabic ? 'خدمات وباقات العمرة الميسرة' : 'Premium Umrah Journeys & Sanctuary Stays')}
          </h1>
          <p className="text-sm md:text-base text-slate-200 leading-relaxed">
            {isArabic
              ? 'رحلة روحانية متكاملة تشمل الإقامة بأرقى فنادق الحرمين، قطار الحرمين السريع، مخيمات VIP المطورة، وإرشاد شرعي وطبي على مدار الساعة.'
              : 'Complete spiritual journey featuring luxury 5-star hotels near Haramain, high-speed train transit, VIP hospitality, and 24/7 medical & guidance assistance.'}
          </p>
        </div>
      </div>

      {/* Booking Alert */}
      {bookedPkg && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex items-center justify-between shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-sm font-bold">
              {isArabic
                ? `تم استلام طلب باقة "${bookedPkg.titleAr}". سيتواصل معك مستشار الحج والعمرة لاستكمال التصاريح.`
                : `Booking registered for "${bookedPkg.titleEn}". Our pilgrimage advisor will contact you.`}
            </div>
          </div>
          <button
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs"
          >
            {isArabic ? 'متابعة الطلب' : 'Track Order'}
          </button>
        </div>
      )}

      {/* Mode Switcher */}
      <div className="flex items-center gap-3">
        <button
          onClick={() => setActiveTab('hajj')}
          className={`flex items-center gap-2 px-6 py-3 rounded-2xl text-xs font-extrabold transition-all ${
            activeTab === 'hajj'
              ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
              : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B]'
          }`}
        >
          <Landmark className="h-4 w-4" />
          <span>{isArabic ? 'باقات الحج (VIP)' : 'Hajj Packages'}</span>
        </button>

        <button
          onClick={() => setActiveTab('umrah')}
          className={`flex items-center gap-2 px-6 py-3 rounded-2xl text-xs font-extrabold transition-all ${
            activeTab === 'umrah'
              ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
              : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B]'
          }`}
        >
          <Moon className="h-4 w-4" />
          <span>{isArabic ? 'باقات وبرامج العمرة' : 'Umrah Packages'}</span>
        </button>
      </div>

      {/* Packages Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {packages.map((pkg) => (
          <div
            key={pkg.id}
            className="flex flex-col rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all duration-300"
          >
            {/* Header Image */}
            <div className="relative h-56 w-full overflow-hidden bg-slate-200 dark:bg-slate-800">
              <img
                src={pkg.image}
                alt={isArabic ? pkg.titleAr : pkg.titleEn}
                className="h-full w-full object-cover"
                loading="lazy"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-black/30"></div>

              <div className="absolute top-4 right-4 px-3 py-1 rounded-xl bg-[#00D4FF] text-[#050914] text-xs font-black shadow-lg">
                {isArabic ? pkg.badgeAr : pkg.badgeEn}
              </div>

              <div className="absolute bottom-4 right-4 left-4 text-white">
                <div className="flex items-center gap-2 text-xs text-[#00D4FF] font-bold mb-1">
                  <Clock className="h-3.5 w-3.5" />
                  <span>
                    {pkg.durationDays} {isArabic ? 'يوماً من السكينة والطمأنينة' : 'Days Pilgrimage'}
                  </span>
                </div>
                <h3 className="text-lg md:text-xl font-extrabold leading-snug">
                  {isArabic ? pkg.titleAr : pkg.titleEn}
                </h3>
              </div>
            </div>

            {/* Content Details */}
            <div className="p-6 space-y-5 flex-1 flex flex-col justify-between">
              {/* Hotels Section */}
              <div className="space-y-2.5">
                <div className="p-3 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-100 dark:border-slate-800 flex items-center gap-3">
                  <div className="p-2 rounded-xl bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF]">
                    <Hotel className="h-4 w-4" />
                  </div>
                  <div className="flex-1 text-xs">
                    <span className="font-bold text-slate-500 block">
                      {isArabic ? 'فندق مكة المكرمة:' : 'Makkah Hotel:'}
                    </span>
                    <span className="font-extrabold text-[#0B192C] dark:text-white">
                      {isArabic ? pkg.hotelMakkahAr : pkg.hotelMakkahEn}
                    </span>
                  </div>
                </div>

                <div className="p-3 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-100 dark:border-slate-800 flex items-center gap-3">
                  <div className="p-2 rounded-xl bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF]">
                    <Hotel className="h-4 w-4" />
                  </div>
                  <div className="flex-1 text-xs">
                    <span className="font-bold text-slate-500 block">
                      {isArabic ? 'فندق المدينة المنورة:' : 'Madinah Hotel:'}
                    </span>
                    <span className="font-extrabold text-[#0B192C] dark:text-white">
                      {isArabic ? pkg.hotelMadinahAr : pkg.hotelMadinahEn}
                    </span>
                  </div>
                </div>
              </div>

              {/* Inclusions List */}
              <div className="space-y-2">
                <div className="text-xs font-bold text-slate-700 dark:text-slate-300">
                  {isArabic ? 'الخدمات والمزايا المشمولة:' : 'Included Privileges:'}
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
                  {(isArabic ? pkg.inclusionsAr : pkg.inclusionsEn).map((inc, i) => (
                    <div key={i} className="flex items-center gap-2 text-xs text-slate-700 dark:text-slate-300">
                      <div className="h-4 w-4 rounded-full bg-[#10B981]/15 text-[#10B981] flex items-center justify-center shrink-0">
                        <Check className="h-2.5 w-2.5 stroke-[3]" />
                      </div>
                      <span className="truncate">{inc}</span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Price & Action Button */}
              <div className="pt-4 border-t border-slate-100 dark:border-slate-800 flex items-center justify-between">
                <div>
                  <div className="text-[10px] text-slate-500 font-medium">
                    {isArabic ? 'سعر الباقة الشاملة' : 'All-Inclusive Price'}
                  </div>
                  <div className="flex items-baseline gap-1">
                    <span className="text-2xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {pkg.price.toLocaleString()}
                    </span>
                    <span className="text-xs font-bold text-slate-500">
                      {isArabic ? 'ر.س' : 'SAR'}
                    </span>
                  </div>
                </div>

                <button
                  onClick={() => handleBook(pkg)}
                  className="px-6 py-3 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-extrabold text-xs shadow-md transition-all active:scale-95"
                >
                  {isArabic ? 'طلب حجز الباقة' : 'Reserve Package'}
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
