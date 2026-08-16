import React, { useState } from 'react';
import { 
  Hotel, 
  MapPin, 
  Star, 
  Search, 
  Calendar, 
  Users, 
  Check, 
  Sparkles,
  ShieldCheck
} from 'lucide-react';
import { Language } from '../../types';
import { HOTELS_LIST, HotelItem } from '../../data/travelData';
import { SafeImage } from '../SafeImage';

interface HotelsViewProps {
  language: Language;
  onNavigate: (path: string) => void;
}

export const HotelsView: React.FC<HotelsViewProps> = ({ language, onNavigate }) => {
  const isArabic = language === 'ar';
  const [cityFilter, setCityFilter] = useState<'all' | 'makkah' | 'madinah' | 'alula' | 'riyadh'>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [bookedHotel, setBookedHotel] = useState<HotelItem | null>(null);

  const cities = [
    { key: 'all', nameAr: 'كافة المدن', nameEn: 'All Cities' },
    { key: 'makkah', nameAr: 'مكة المكرمة', nameEn: 'Makkah' },
    { key: 'madinah', nameAr: 'المدينة المنورة', nameEn: 'Madinah' },
    { key: 'alula', nameAr: 'العلا', nameEn: 'AlUla' },
    { key: 'riyadh', nameAr: 'الرياض', nameEn: 'Riyadh' },
  ];

  const filteredHotels = HOTELS_LIST.filter((h) => {
    let matchCity = true;
    if (cityFilter === 'makkah') matchCity = h.cityAr.includes('مكة');
    if (cityFilter === 'madinah') matchCity = h.cityAr.includes('المدينة');
    if (cityFilter === 'alula') matchCity = h.cityAr.includes('العلا');
    if (cityFilter === 'riyadh') matchCity = h.cityAr.includes('الرياض');

    const matchSearch =
      h.nameAr.toLowerCase().includes(searchQuery.toLowerCase()) ||
      h.nameEn.toLowerCase().includes(searchQuery.toLowerCase()) ||
      h.cityAr.toLowerCase().includes(searchQuery.toLowerCase());

    return matchCity && matchSearch;
  });

  const handleBook = (hotel: HotelItem) => {
    setBookedHotel(hotel);
    setTimeout(() => {
      setBookedHotel(null);
    }, 4000);
  };

  return (
    <div className="p-4 sm:p-6 md:p-8 space-y-6 sm:space-y-8 max-w-7xl mx-auto w-full transition-colors overflow-hidden">
      {/* Hotels Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-5 sm:p-8 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-72 h-72 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            <Hotel className="h-4 w-4 shrink-0" />
            <span>{isArabic ? 'إقامة فاخرة 5 نجوم وأجنحة مطلة على الحرمين' : 'Luxury 5-Star Stays & Kaaba Views'}</span>
          </div>
          <h1 className="text-xl sm:text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {isArabic ? 'الفنادق والمنتجعات الملكية' : 'Royal Hotels & Luxury Resorts'}
          </h1>
          <p className="text-xs sm:text-sm md:text-base text-slate-200 leading-relaxed max-w-2xl">
            {isArabic
              ? 'اختر من بين نخبة الفنادق الفاخرة المطلة مباشرة على المسجد الحرام والمسجد النبوي ومنتجعات العلا والرياض الحصرية.'
              : 'Curated collection of 5-star hotels with direct Kaaba views, Prophet Mosque access, and serene private desert resorts.'}
          </p>
        </div>
      </div>

      {/* Booking Alert */}
      {bookedHotel && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-xs sm:text-sm font-bold">
              {isArabic
                ? `تم تأكيد حجز الإقامة في: "${bookedHotel.nameAr}". تم إرسال قسيمة الفندق إلى بريدك.`
                : `Reservation confirmed for: "${bookedHotel.nameEn}". Voucher sent to your email.`}
            </div>
          </div>
          <button
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs whitespace-nowrap"
          >
            {isArabic ? 'عرض الحجز' : 'View Booking'}
          </button>
        </div>
      )}

      {/* Hotel Search Widget */}
      <div className="rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-4 sm:p-6 space-y-4 shadow-sm">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-3 sm:gap-4">
          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'المدينة أو الفندق' : 'Destination / Hotel'}
            </label>
            <div className="relative">
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder={isArabic ? 'مكة، المدينة، العلا، الرياض...' : 'Makkah, Madinah, AlUla...'}
                className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
              />
              <Search className={`absolute ${isArabic ? 'left-3' : 'right-3'} top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400`} />
            </div>
          </div>

          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'تاريخ الوصول والمغادرة' : 'Check-in / Check-out'}
            </label>
            <div className="relative">
              <input
                type="text"
                defaultValue={isArabic ? '20 سبتمبر - 25 سبتمبر 2026' : '20 Sep - 25 Sep 2026'}
                className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
              />
              <Calendar className={`absolute ${isArabic ? 'left-3' : 'right-3'} top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400`} />
            </div>
          </div>

          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'الغرف والنزلاء' : 'Rooms & Guests'}
            </label>
            <div className="relative">
              <input
                type="text"
                defaultValue={isArabic ? 'غرفة واحدة - شخصان بالغان' : '1 Room - 2 Adults'}
                className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
              />
              <Users className={`absolute ${isArabic ? 'left-3' : 'right-3'} top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400`} />
            </div>
          </div>

          <div className="space-y-1.5 flex flex-col justify-end">
            <button className="h-11 w-full rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs flex items-center justify-center gap-2 shadow-md transition-all">
              <Search className="h-4 w-4" />
              <span>{isArabic ? 'البحث عن الفنادق' : 'Search Hotels'}</span>
            </button>
          </div>
        </div>

        {/* City Filter Tabs */}
        <div className="flex items-center gap-2 overflow-x-auto pt-2 border-t border-slate-100 dark:border-slate-800 scrollbar-none">
          {cities.map((city) => (
            <button
              key={city.key}
              onClick={() => setCityFilter(city.key as any)}
              className={`whitespace-nowrap px-3.5 sm:px-4 py-1.5 rounded-xl text-xs font-bold transition-all shrink-0 ${
                cityFilter === city.key
                  ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914]'
                  : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 hover:bg-slate-200'
              }`}
            >
              {isArabic ? city.nameAr : city.nameEn}
            </button>
          ))}
        </div>
      </div>

      {/* Hotels Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-5 sm:gap-6">
        {filteredHotels.map((hotel) => (
          <div
            key={hotel.id}
            className="group flex flex-col md:flex-row rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all duration-300 w-full min-w-0"
          >
            {/* Image at TOP on mobile, side on desktop */}
            <div className="relative aspect-[16/10] md:aspect-auto md:w-2/5 h-48 sm:h-56 md:h-auto overflow-hidden bg-slate-200 dark:bg-slate-800 shrink-0">
              <SafeImage
                src={hotel.image}
                alt={isArabic ? hotel.nameAr : hotel.nameEn}
                className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                fallbackIcon={<Hotel className="h-8 w-8 text-[#00D4FF]" />}
              />
              <div className="absolute top-3 right-3 px-2.5 py-1 rounded-xl bg-black/70 backdrop-blur-md text-white text-xs font-bold flex items-center gap-1 border border-white/10">
                <Star className="h-3 w-3 text-[#FF6500] fill-[#FF6500]" />
                <span>{hotel.rating}</span>
              </div>
              <div className="absolute top-3 left-3 px-2.5 py-1 rounded-xl bg-[#00D4FF] text-[#050914] text-xs font-extrabold shadow-md whitespace-nowrap">
                {isArabic ? hotel.tagAr : hotel.tagEn}
              </div>
            </div>

            {/* Content Container */}
            <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between space-y-4">
              <div className="space-y-2">
                <div className="flex items-center gap-1.5 text-slate-500 text-xs">
                  <MapPin className="h-3.5 w-3.5 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                  <span>{isArabic ? hotel.cityAr : hotel.cityEn}</span>
                </div>

                {/* Full Arabic Hotel Name */}
                <h3 className="text-base sm:text-lg font-extrabold text-[#0B192C] dark:text-white leading-snug group-hover:text-[#008DDA] dark:group-hover:text-[#00D4FF] transition-colors">
                  {isArabic ? hotel.nameAr : hotel.nameEn}
                </h3>

                {hotel.distanceToHaramAr && (
                  <div className="text-xs font-semibold text-[#008DDA] dark:text-[#00D4FF] bg-[#00D4FF]/10 px-2.5 py-1 rounded-lg inline-block">
                    {isArabic ? hotel.distanceToHaramAr : hotel.distanceToHaramEn}
                  </div>
                )}
              </div>

              {/* Amenities */}
              <div className="grid grid-cols-2 gap-2 pt-2 border-t border-slate-100 dark:border-slate-800">
                {(isArabic ? hotel.amenitiesAr : hotel.amenitiesEn).map((am, i) => (
                  <div key={i} className="flex items-center gap-1.5 text-xs text-slate-600 dark:text-slate-400">
                    <Check className="h-3.5 w-3.5 text-[#10B981] shrink-0" />
                    <span>{am}</span>
                  </div>
                ))}
              </div>

              {/* Pricing & CTA */}
              <div className="pt-3 border-t border-slate-100 dark:border-slate-800 flex flex-col xs:flex-row sm:flex-row items-stretch xs:items-center sm:items-center justify-between gap-3">
                <div>
                  <div className="text-[10px] text-slate-500 font-medium">
                    {isArabic ? 'السعر لليلة الواحدة' : 'Price per night'}
                  </div>
                  <div className="flex items-baseline gap-1">
                    <span className="text-lg sm:text-xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {hotel.pricePerNight.toLocaleString()}
                    </span>
                    <span className="text-xs font-bold text-slate-500">
                      {isArabic ? 'ر.س' : 'SAR'}
                    </span>
                  </div>
                </div>

                <button
                  onClick={() => handleBook(hotel)}
                  className="w-full xs:w-auto sm:w-auto h-10 px-5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-md transition-all active:scale-95 text-center"
                >
                  {isArabic ? 'احجز الغرفة' : 'Book Room'}
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
