import React, { useState } from 'react';
import { 
  Palmtree, 
  MapPin, 
  Clock, 
  Users, 
  Star, 
  Check, 
  Search, 
  Filter, 
  Sparkles, 
  Calendar,
  ChevronRight,
  ShieldCheck,
  X
} from 'lucide-react';
import { Language } from '../../types';
import { TOURISM_PACKAGES, TourPackage } from '../../data/travelData';
import { SafeImage } from '../SafeImage';

interface TourismViewProps {
  language: Language;
  onNavigate: (path: string) => void;
}

export const TourismView: React.FC<TourismViewProps> = ({ language, onNavigate }) => {
  const isArabic = language === 'ar';
  const [selectedCategory, setSelectedCategory] = useState<'all' | 'history' | 'daily' | 'family' | 'custom'>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedTour, setSelectedTour] = useState<TourPackage | null>(null);
  const [bookingSuccess, setBookingSuccess] = useState(false);

  const categories = [
    { key: 'all', labelAr: 'كافة البرامج', labelEn: 'All Tours' },
    { key: 'history', labelAr: 'جولات تاريخية وتراثية', labelEn: 'Heritage & History' },
    { key: 'daily', labelAr: 'برامج سياحية يومية', labelEn: 'Daily Excursions' },
    { key: 'family', labelAr: 'جولات عائلية وترفيهية', labelEn: 'Family & Leisure' },
    { key: 'custom', labelAr: 'سفاري وبرامج مخصصة', labelEn: 'Custom & Safari' },
  ];

  const filteredPackages = TOURISM_PACKAGES.filter((item) => {
    const matchesCat = selectedCategory === 'all' || item.category === selectedCategory;
    const matchesSearch = 
      item.titleAr.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.titleEn.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.locationAr.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.locationEn.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCat && matchesSearch;
  });

  const handleBookNow = (tour: TourPackage) => {
    setSelectedTour(tour);
    setBookingSuccess(true);
    setTimeout(() => {
      setBookingSuccess(false);
    }, 4000);
  };

  return (
    <div className="p-4 sm:p-6 md:p-8 space-y-6 sm:space-y-8 max-w-7xl mx-auto w-full transition-colors overflow-hidden">
      {/* Tourism Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-5 sm:p-8 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-20 -mt-20 w-80 h-80 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            <Palmtree className="h-4 w-4 shrink-0" />
            <span>{isArabic ? 'منصة الباقات والرحلات السياحية' : 'MASARI Curated Tourism'}</span>
          </div>
          <h1 className="text-xl sm:text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {isArabic ? 'الباقات والجولات السياحية الفاخرة' : 'Luxury Tours & Sightseeing Packages'}
          </h1>
          <p className="text-xs sm:text-sm md:text-base text-slate-200 leading-relaxed max-w-2xl">
            {isArabic
              ? 'اكتشف أجمل الوجهات التراثية، الطبيعية، والجولات العائلية واليومية المصممة بعناية مع أفضل المرشدين السياحيين المعتمدين ووسائل النقل VIP.'
              : 'Discover curated heritage expeditions, scenic nature retreats, and exclusive family day tours with certified expert guides and VIP chauffeur service.'}
          </p>
        </div>
      </div>

      {/* Success Notification Alert */}
      {bookingSuccess && selectedTour && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-xs sm:text-sm font-bold">
              {isArabic
                ? `تم استلام طلب حجز: "${selectedTour.titleAr}". سيتواصل معك مستشار مساري لتأكيد المواعيد.`
                : `Booking request received for: "${selectedTour.titleEn}". Our concierge will contact you shortly.`}
            </div>
          </div>
          <button 
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs hover:bg-[#059669] transition-colors whitespace-nowrap"
          >
            {isArabic ? 'عرض حجوزاتي' : 'View Bookings'}
          </button>
        </div>
      )}

      {/* Search & Category Filter Bar */}
      <div className="space-y-3 sm:space-y-4">
        {/* Search Input */}
        <div className="relative">
          <Search className={`absolute ${isArabic ? 'right-4' : 'left-4'} top-1/2 -translate-y-1/2 h-5 w-5 text-slate-400 dark:text-[#64748B]`} />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder={
              isArabic
                ? 'ابحث بالاسم، المدينة، أو الوجهة (مثال: العلا، الرياض، أبها، وادي الديسة)...'
                : 'Search tours by destination or keyword (e.g. AlUla, Riyadh, Abha)...'
            }
            className={`w-full h-12 rounded-2xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] ${
              isArabic ? 'pr-12 pl-4' : 'pl-12 pr-4'
            } text-xs sm:text-sm text-slate-900 dark:text-[#F8FAFC] placeholder-slate-400 dark:placeholder-[#64748B] focus:outline-none focus:border-[#00D4FF] transition-all shadow-sm`}
          />
        </div>

        {/* Category Pills */}
        <div className="flex items-center gap-2 overflow-x-auto pb-2 scrollbar-none">
          <Filter className="h-4 w-4 text-slate-400 dark:text-slate-500 shrink-0 ml-1" />
          {categories.map((cat) => {
            const isActive = selectedCategory === cat.key;
            return (
              <button
                key={cat.key}
                onClick={() => setSelectedCategory(cat.key as any)}
                className={`whitespace-nowrap px-3.5 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all shrink-0 ${
                  isActive
                    ? 'bg-[#0B192C] text-white shadow-md dark:bg-[#00D4FF] dark:text-[#050914]'
                    : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B] hover:border-[#00D4FF]/50'
                }`}
              >
                {isArabic ? cat.labelAr : cat.labelEn}
              </button>
            );
          })}
        </div>
      </div>

      {/* Tourism Cards Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5 sm:gap-6">
        {filteredPackages.map((tour) => {
          return (
            <div
              key={tour.id}
              className="group flex flex-col rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all duration-300 w-full min-w-0"
            >
              {/* Tour Image at TOP */}
              <div className="relative aspect-[16/10] sm:h-52 w-full overflow-hidden bg-slate-200 dark:bg-slate-800 shrink-0">
                <SafeImage
                  src={tour.image}
                  alt={isArabic ? tour.titleAr : tour.titleEn}
                  className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                  fallbackIcon={<Palmtree className="h-8 w-8 text-[#00D4FF]" />}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-black/20 pointer-events-none"></div>

                {/* Rating Badge */}
                <div className="absolute top-3 right-3 flex items-center gap-1 px-2.5 py-1 rounded-xl bg-black/70 backdrop-blur-md text-white text-xs font-bold border border-white/10">
                  <Star className="h-3 w-3 text-[#FF6500] fill-[#FF6500]" />
                  <span>{tour.rating}</span>
                  <span className="text-[10px] text-slate-300">({tour.reviewsCount})</span>
                </div>

                {/* Category Tag */}
                <div className="absolute top-3 left-3 px-2.5 py-1 rounded-xl bg-[#00D4FF] text-[#050914] text-xs font-extrabold shadow-md whitespace-nowrap">
                  {isArabic
                    ? tour.category === 'history'
                      ? 'تراث وتاريخ'
                      : tour.category === 'daily'
                      ? 'جولة يومية'
                      : tour.category === 'family'
                      ? 'برنامج عائلي'
                      : 'سفاري مخصص'
                    : tour.category.toUpperCase()}
                </div>

                {/* Location Bar */}
                <div className="absolute bottom-3 right-3 left-3 flex items-center gap-1.5 text-white text-xs font-medium">
                  <MapPin className="h-3.5 w-3.5 text-[#00D4FF] shrink-0" />
                  <span className="truncate">{isArabic ? tour.locationAr : tour.locationEn}</span>
                </div>
              </div>

              {/* Card Body */}
              <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between space-y-4">
                <div className="space-y-2">
                  {/* Full Arabic Title */}
                  <h3 className="text-base font-extrabold text-[#0B192C] dark:text-white leading-snug group-hover:text-[#008DDA] dark:group-hover:text-[#00D4FF] transition-colors">
                    {isArabic ? tour.titleAr : tour.titleEn}
                  </h3>

                  <p className="text-xs text-slate-600 dark:text-slate-400 leading-relaxed">
                    {isArabic ? tour.descriptionAr : tour.descriptionEn}
                  </p>
                </div>

                {/* Tour Key Details (Duration & Travelers) */}
                <div className="grid grid-cols-2 gap-2 pt-2 border-t border-slate-100 dark:border-slate-800 text-xs text-slate-600 dark:text-slate-400">
                  <div className="flex items-center gap-1.5">
                    <Clock className="h-3.5 w-3.5 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                    <span>{isArabic ? tour.durationAr : tour.durationEn}</span>
                  </div>
                  <div className="flex items-center gap-1.5">
                    <Users className="h-3.5 w-3.5 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                    <span>{isArabic ? tour.travelersAr : tour.travelersEn}</span>
                  </div>
                </div>

                {/* Inclusions / Highlights */}
                <div className="space-y-1.5">
                  {(isArabic ? tour.highlightsAr : tour.highlightsEn).slice(0, 2).map((item, idx) => (
                    <div key={idx} className="flex items-center gap-2 text-xs text-slate-700 dark:text-slate-300">
                      <div className="h-4 w-4 rounded-full bg-[#00D4FF]/15 text-[#008DDA] dark:text-[#00D4FF] flex items-center justify-center shrink-0">
                        <Check className="h-2.5 w-2.5 stroke-[3]" />
                      </div>
                      <span className="truncate">{item}</span>
                    </div>
                  ))}
                </div>

                {/* Price & Action Buttons */}
                <div className="pt-3 border-t border-slate-100 dark:border-slate-800 space-y-3">
                  <div className="flex items-baseline justify-between">
                    <div>
                      <div className="text-[10px] text-slate-500 dark:text-slate-400 font-medium">
                        {isArabic ? 'السعر للشخص' : 'Price per person'}
                      </div>
                      <div className="flex items-baseline gap-1">
                        <span className="text-xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                          {tour.price.toLocaleString()}
                        </span>
                        <span className="text-xs font-bold text-slate-600 dark:text-slate-400">
                          {isArabic ? tour.currencyAr : tour.currencyEn}
                        </span>
                      </div>
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-2">
                    <button
                      onClick={() => setSelectedTour(tour)}
                      className="h-10 px-3 rounded-xl text-xs font-bold text-slate-700 dark:text-slate-200 bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 transition-colors text-center"
                    >
                      {isArabic ? 'التفاصيل' : 'Details'}
                    </button>
                    <button
                      onClick={() => handleBookNow(tour)}
                      className="h-10 px-3 rounded-xl text-xs font-bold text-white bg-[#FF6500] hover:bg-[#EA580C] shadow-md transition-all duration-200 active:scale-95 text-center"
                    >
                      {isArabic ? 'احجز الآن' : 'Book Now'}
                    </button>
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Tour Detail Modal */}
      {selectedTour && !bookingSuccess && (
        <div className="fixed inset-0 z-50 bg-black/70 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto p-5 sm:p-8 space-y-5 shadow-2xl">
            <div className="flex items-start justify-between gap-3">
              <div>
                <span className="inline-block px-3 py-1 rounded-full bg-[#00D4FF]/15 text-[#008DDA] dark:text-[#00D4FF] text-xs font-bold mb-2">
                  {isArabic ? selectedTour.locationAr : selectedTour.locationEn}
                </span>
                <h2 className="text-lg sm:text-2xl font-extrabold text-[#0B192C] dark:text-white">
                  {isArabic ? selectedTour.titleAr : selectedTour.titleEn}
                </h2>
              </div>
              <button
                onClick={() => setSelectedTour(null)}
                className="p-2 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-500 hover:text-slate-800 dark:hover:text-white shrink-0"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            <div className="rounded-2xl overflow-hidden h-52 sm:h-64 w-full">
              <SafeImage
                src={selectedTour.image}
                alt={isArabic ? selectedTour.titleAr : selectedTour.titleEn}
                className="w-full h-full object-cover"
                fallbackIcon={<Palmtree className="h-10 w-10 text-[#00D4FF]" />}
              />
            </div>

            <p className="text-xs sm:text-sm text-slate-700 dark:text-slate-300 leading-relaxed">
              {isArabic ? selectedTour.descriptionAr : selectedTour.descriptionEn}
            </p>

            <div className="space-y-3">
              <h4 className="text-xs font-bold text-slate-900 dark:text-slate-100 uppercase tracking-wider">
                {isArabic ? 'مميزات وشمولية البرنامج:' : 'Package Inclusions & Features:'}
              </h4>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                {(isArabic ? selectedTour.highlightsAr : selectedTour.highlightsEn).map((h, i) => (
                  <div key={i} className="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-800 text-xs text-slate-700 dark:text-slate-300">
                    <Check className="h-4 w-4 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                    <span>{h}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="pt-4 border-t border-slate-100 dark:border-slate-800 flex flex-col sm:flex-row items-center justify-between gap-3">
              <div>
                <div className="text-xs text-slate-500 dark:text-slate-400">
                  {isArabic ? 'السعر الإجمالي' : 'Total Package Price'}
                </div>
                <div className="text-xl sm:text-2xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                  {selectedTour.price.toLocaleString()} {isArabic ? selectedTour.currencyAr : selectedTour.currencyEn}
                </div>
              </div>
              <div className="flex gap-2.5 w-full sm:w-auto">
                <button
                  onClick={() => setSelectedTour(null)}
                  className="flex-1 sm:flex-none px-4 py-2.5 rounded-xl bg-slate-100 dark:bg-slate-800 text-slate-700 dark:text-slate-200 font-bold text-xs"
                >
                  {isArabic ? 'إغلاق' : 'Close'}
                </button>
                <button
                  onClick={() => handleBookNow(selectedTour)}
                  className="flex-1 sm:flex-none px-6 py-2.5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-md"
                >
                  {isArabic ? 'تأكيد الحجز الفوري' : 'Confirm Booking'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
