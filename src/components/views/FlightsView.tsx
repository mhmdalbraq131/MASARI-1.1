import React, { useState } from 'react';
import { 
  Plane, 
  ArrowRightLeft, 
  Calendar, 
  Users, 
  Search, 
  ShieldCheck, 
  Luggage, 
  Sparkles,
  ArrowRight
} from 'lucide-react';
import { Language } from '../../types';
import { FLIGHTS_LIST, FlightItem } from '../../data/travelData';

interface FlightsViewProps {
  language: Language;
  onNavigate: (path: string) => void;
}

export const FlightsView: React.FC<FlightsViewProps> = ({ language, onNavigate }) => {
  const isArabic = language === 'ar';
  const [tripType, setTripType] = useState<'round' | 'oneWay'>('round');
  const [origin, setOrigin] = useState('RUH');
  const [destination, setDestination] = useState('JED');
  const [cabinClass, setCabinClass] = useState('all');
  const [bookedFlight, setBookedFlight] = useState<FlightItem | null>(null);

  const handleBook = (flight: FlightItem) => {
    setBookedFlight(flight);
    setTimeout(() => {
      setBookedFlight(null);
    }, 4000);
  };

  return (
    <div className="p-4 sm:p-6 md:p-8 space-y-6 sm:space-y-8 max-w-7xl mx-auto w-full transition-colors overflow-hidden">
      {/* Flights Hero Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-5 sm:p-8 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-72 h-72 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            <Plane className="h-4 w-4 shrink-0" />
            <span>{isArabic ? 'حجوزات الطيران المحلي والدولي والخاص' : 'Aviation & Flight Booking'}</span>
          </div>
          <h1 className="text-xl sm:text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {isArabic ? 'احجز رحلتك الجوية بأعلى معايير الرفاهية' : 'Book Luxury & Commercial Flights'}
          </h1>
          <p className="text-xs sm:text-sm md:text-base text-slate-200 leading-relaxed max-w-2xl">
            {isArabic
              ? 'خيارات طيران مرنة على أرقى الخطوط الجوية مع إمكانية حجز أجنحة خاصة، ترقية درجة السفر، وتأكيد فوري للرحلات.'
              : 'Flexible flight options on premier airlines with private suite bookings, cabin upgrades, and instant ticket issuance.'}
          </p>
        </div>
      </div>

      {/* Success Notification */}
      {bookedFlight && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-xs sm:text-sm font-bold">
              {isArabic
                ? `تم حجز رحلة ${bookedFlight.flightNumber} من ${bookedFlight.fromCityAr} إلى ${bookedFlight.toCityAr} بنجاح!`
                : `Flight ${bookedFlight.flightNumber} from ${bookedFlight.fromCityEn} to ${bookedFlight.toCityEn} booked successfully!`}
            </div>
          </div>
          <button
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs whitespace-nowrap"
          >
            {isArabic ? 'عرض التذكرة' : 'View Ticket'}
          </button>
        </div>
      )}

      {/* Flight Search Widget */}
      <div className="rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-4 sm:p-6 space-y-4 sm:space-y-6 shadow-sm">
        <div className="flex items-center justify-between border-b border-slate-100 dark:border-slate-800 pb-3 sm:pb-4 gap-2">
          <div className="flex items-center gap-2 sm:gap-3">
            <button
              onClick={() => setTripType('round')}
              className={`px-3.5 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all ${
                tripType === 'round'
                  ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914]'
                  : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400'
              }`}
            >
              {isArabic ? 'ذهاب وعودة' : 'Round Trip'}
            </button>
            <button
              onClick={() => setTripType('oneWay')}
              className={`px-3.5 sm:px-4 py-2 rounded-xl text-xs font-bold transition-all ${
                tripType === 'oneWay'
                  ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914]'
                  : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400'
              }`}
            >
              {isArabic ? 'اتجاه واحد' : 'One Way'}
            </button>
          </div>

          <div className="hidden md:flex items-center gap-2 text-xs font-semibold text-slate-500">
            <Sparkles className="h-4 w-4 text-[#008DDA] dark:text-[#00D4FF]" />
            <span>{isArabic ? 'ضمان أفضل الأسعار والخدمات' : 'Best Price & Premium Guarantee'}</span>
          </div>
        </div>

        {/* Input Form Fields */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-3 sm:gap-4">
          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'من (مطار المغادرة)' : 'From'}
            </label>
            <input
              type="text"
              defaultValue={isArabic ? 'الرياض (RUH) - مطار الملك خالد' : 'Riyadh (RUH)'}
              className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
            />
          </div>

          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'إلى (مطار الوصول)' : 'To'}
            </label>
            <input
              type="text"
              defaultValue={isArabic ? 'جدة (JED) - مطار الملك عبد العزيز' : 'Jeddah (JED)'}
              className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
            />
          </div>

          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'تاريخ السفر' : 'Travel Dates'}
            </label>
            <div className="relative">
              <input
                type="text"
                defaultValue={isArabic ? '15 سبتمبر 2026 - 22 سبتمبر 2026' : '15 Sep - 22 Sep 2026'}
                className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-xs font-bold text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
              />
              <Calendar className={`absolute ${isArabic ? 'left-3' : 'right-3'} top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400`} />
            </div>
          </div>

          <div className="space-y-1.5 flex flex-col justify-end">
            <button className="h-11 w-full rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs flex items-center justify-center gap-2 shadow-md transition-all">
              <Search className="h-4 w-4" />
              <span>{isArabic ? 'البحث عن الرحلات' : 'Search Flights'}</span>
            </button>
          </div>
        </div>
      </div>

      {/* Available Flights Section */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-base sm:text-lg md:text-xl font-bold text-[#0B192C] dark:text-white">
            {isArabic ? 'الرحلات المتاحة والمقترحة' : 'Available & Recommended Flights'}
          </h2>
          <span className="text-xs text-slate-500 font-medium">
            {isArabic ? `${FLIGHTS_LIST.length} رحلات مباشرة ممتازة` : `${FLIGHTS_LIST.length} direct flights found`}
          </span>
        </div>

        <div className="space-y-4">
          {FLIGHTS_LIST.map((flight) => (
            <div
              key={flight.id}
              className="flex flex-col md:flex-row items-stretch justify-between p-4 sm:p-5 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] shadow-sm hover:shadow-md dark:shadow-none hover:border-[#00D4FF]/50 transition-all gap-4 w-full min-w-0"
            >
              {/* Airline & Class Info */}
              <div className="flex items-center gap-3 md:w-1/4">
                <div className="h-11 w-11 rounded-2xl bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF] flex items-center justify-center shrink-0">
                  <Plane className="h-5 w-5 stroke-[2]" />
                </div>
                <div>
                  <div className="text-sm font-extrabold text-[#0B192C] dark:text-white leading-snug">
                    {isArabic ? flight.airlineAr : flight.airlineEn}
                  </div>
                  <div className="text-xs text-slate-500 font-mono mt-0.5">
                    {flight.flightNumber}
                  </div>
                  <span className="inline-block mt-1 px-2 py-0.5 rounded text-[10px] font-bold bg-[#00D4FF]/15 text-[#008DDA] dark:text-[#00D4FF]">
                    {isArabic ? flight.cabinClassAr : flight.cabinClassEn}
                  </span>
                </div>
              </div>

              {/* Schedule & Routing */}
              <div className="flex-1 flex items-center justify-between sm:justify-around px-2 sm:px-4 border-y md:border-y-0 md:border-x border-slate-100 dark:border-slate-800 py-3 md:py-0">
                {/* Departure */}
                <div className="text-center">
                  <div className="text-base sm:text-lg font-black text-[#0B192C] dark:text-white">
                    {flight.departureTime}
                  </div>
                  <div className="text-xs font-bold text-slate-600 dark:text-slate-400">
                    {flight.fromCode}
                  </div>
                  <div className="text-[10px] text-slate-400">
                    {isArabic ? flight.fromCityAr : flight.fromCityEn}
                  </div>
                </div>

                {/* Duration & Stops Graphic */}
                <div className="flex flex-col items-center px-2 sm:px-4">
                  <span className="text-[11px] font-semibold text-slate-500">
                    {isArabic ? flight.durationAr : flight.durationEn}
                  </span>
                  <div className="relative w-20 sm:w-28 md:w-32 my-1 flex items-center justify-center">
                    <div className="h-[2px] w-full bg-slate-300 dark:bg-slate-700"></div>
                    <Plane className="h-3.5 w-3.5 text-[#008DDA] dark:text-[#00D4FF] absolute" />
                  </div>
                  <span className="text-[10px] font-bold text-[#10B981]">
                    {isArabic ? flight.stopsAr : flight.stopsEn}
                  </span>
                </div>

                {/* Arrival */}
                <div className="text-center">
                  <div className="text-base sm:text-lg font-black text-[#0B192C] dark:text-white">
                    {flight.arrivalTime}
                  </div>
                  <div className="text-xs font-bold text-slate-600 dark:text-slate-400">
                    {flight.toCode}
                  </div>
                  <div className="text-[10px] text-slate-400">
                    {isArabic ? flight.toCityAr : flight.toCityEn}
                  </div>
                </div>
              </div>

              {/* Baggage & Booking CTA */}
              <div className="flex flex-col xs:flex-row md:flex-col items-stretch xs:items-center md:items-end justify-between md:justify-center gap-3 md:w-1/4">
                <div className="flex items-center justify-between xs:justify-start md:flex-col md:items-end gap-1">
                  <div className="flex items-center gap-1 text-[11px] text-slate-500">
                    <Luggage className="h-3.5 w-3.5 text-slate-400 shrink-0" />
                    <span>{flight.baggage}</span>
                  </div>
                  <div className="flex items-baseline gap-1">
                    <span className="text-xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {flight.price.toLocaleString()}
                    </span>
                    <span className="text-xs font-bold text-slate-500">
                      {isArabic ? 'ر.س' : 'SAR'}
                    </span>
                  </div>
                </div>
                <button
                  onClick={() => handleBook(flight)}
                  className="w-full xs:w-auto md:w-auto h-10 px-5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-md transition-all active:scale-95 text-center"
                >
                  {isArabic ? 'احجز التذكرة' : 'Book Flight'}
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
