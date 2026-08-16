import React, { useState } from 'react';
import { 
  Car, 
  Bus, 
  Compass, 
  Users, 
  Luggage, 
  ShieldCheck, 
  Check, 
  Sparkles,
  MapPin,
  Clock
} from 'lucide-react';
import { Language } from '../../types';
import { VEHICLES_LIST, VehicleItem } from '../../data/travelData';
import { SafeImage } from '../SafeImage';

interface TransportationViewProps {
  language: Language;
  initialType?: 'cars' | 'bus' | 'transfers';
  onNavigate: (path: string) => void;
}

export const TransportationView: React.FC<TransportationViewProps> = ({ 
  language, 
  initialType = 'cars', 
  onNavigate 
}) => {
  const isArabic = language === 'ar';
  const [selectedType, setSelectedType] = useState<'cars' | 'bus' | 'transfers'>(initialType);
  const [bookedVehicle, setBookedVehicle] = useState<VehicleItem | null>(null);

  const filteredVehicles = VEHICLES_LIST.filter((v) => v.type === selectedType);

  const handleBook = (vehicle: VehicleItem) => {
    setBookedVehicle(vehicle);
    setTimeout(() => {
      setBookedVehicle(null);
    }, 4000);
  };

  return (
    <div className="p-4 sm:p-6 md:p-8 space-y-6 sm:space-y-8 max-w-7xl mx-auto w-full transition-colors overflow-hidden">
      {/* Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-5 sm:p-8 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-72 h-72 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            <Compass className="h-4 w-4 shrink-0" />
            <span>{isArabic ? 'أسطول مساري للنقل الفاخر والجماعي' : 'MASARI Executive Fleet & Transfers'}</span>
          </div>
          <h1 className="text-xl sm:text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {isArabic ? 'خدمات النقل، تأجير السيارات والتوصيل الخاص' : 'Chauffeur, Car Rental & Coach Services'}
          </h1>
          <p className="text-xs sm:text-sm md:text-base text-slate-200 leading-relaxed max-w-2xl">
            {isArabic
              ? 'أسطول حديث ومجهز من سيارات مايباخ، يوكون دينالي، حافلات مرسيدس VIP، وخدمات الاستقبال الفوري في جميع مطارات المملكة.'
              : 'Premier fleet comprising Maybach S-Class, GMC Yukon XL, Mercedes VIP Tourismo coaches, and airport chauffeur transfers.'}
          </p>
        </div>
      </div>

      {/* Booking Alert */}
      {bookedVehicle && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-xs sm:text-sm font-bold">
              {isArabic
                ? `تم استلام طلب حجز: "${bookedVehicle.nameAr}". سيتواصل معك السائق الخاص لتأكيد نقطة الالتقاء.`
                : `Booking confirmed for "${bookedVehicle.nameEn}". Your chauffeur will contact you.`}
            </div>
          </div>
          <button
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs whitespace-nowrap"
          >
            {isArabic ? 'عرض الحجوزات' : 'View Bookings'}
          </button>
        </div>
      )}

      {/* Fleet Type Tabs */}
      <div className="flex items-center gap-2 sm:gap-3 overflow-x-auto pb-1 scrollbar-none">
        <button
          onClick={() => setSelectedType('cars')}
          className={`flex items-center gap-2 px-4 sm:px-5 py-2.5 sm:py-3 rounded-2xl text-xs font-bold transition-all whitespace-nowrap shrink-0 ${
            selectedType === 'cars'
              ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
              : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B]'
          }`}
        >
          <Car className="h-4 w-4" />
          <span>{isArabic ? 'تأجير السيارات الفاخرة' : 'Luxury Car Rental'}</span>
        </button>

        <button
          onClick={() => setSelectedType('bus')}
          className={`flex items-center gap-2 px-4 sm:px-5 py-2.5 sm:py-3 rounded-2xl text-xs font-bold transition-all whitespace-nowrap shrink-0 ${
            selectedType === 'bus'
              ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
              : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B]'
          }`}
        >
          <Bus className="h-4 w-4" />
          <span>{isArabic ? 'حافلات النقل VIP' : 'VIP Coach Transport'}</span>
        </button>

        <button
          onClick={() => setSelectedType('transfers')}
          className={`flex items-center gap-2 px-4 sm:px-5 py-2.5 sm:py-3 rounded-2xl text-xs font-bold transition-all whitespace-nowrap shrink-0 ${
            selectedType === 'transfers'
              ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914] shadow-md'
              : 'bg-white dark:bg-[#0A1631] text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-[#1E293B]'
          }`}
        >
          <Compass className="h-4 w-4" />
          <span>{isArabic ? 'توصيل واستقبال المطار' : 'Airport Transfers'}</span>
        </button>
      </div>

      {/* Vehicles Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-5 sm:gap-6">
        {filteredVehicles.map((vh) => (
          <div
            key={vh.id}
            className="flex flex-col rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] overflow-hidden shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all duration-300 w-full min-w-0"
          >
            {/* Top Image */}
            <div className="relative aspect-[16/10] sm:h-56 w-full overflow-hidden bg-slate-200 dark:bg-slate-800 shrink-0">
              <SafeImage
                src={vh.image}
                alt={isArabic ? vh.nameAr : vh.nameEn}
                className="h-full w-full object-cover"
                fallbackIcon={<Car className="h-8 w-8 text-[#00D4FF]" />}
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-black/20 pointer-events-none"></div>

              <div className="absolute bottom-3 right-3 left-3 flex items-center justify-between text-white text-xs font-semibold">
                <div className="flex items-center gap-3 bg-black/70 backdrop-blur-md px-3 py-1.5 rounded-xl border border-white/10">
                  <div className="flex items-center gap-1.5">
                    <Users className="h-3.5 w-3.5 text-[#00D4FF]" />
                    <span>{vh.passengers} {isArabic ? 'ركاب' : 'Seats'}</span>
                  </div>
                  <div className="flex items-center gap-1.5">
                    <Luggage className="h-3.5 w-3.5 text-[#00D4FF]" />
                    <span>{vh.luggage} {isArabic ? 'حقائب' : 'Bags'}</span>
                  </div>
                </div>
              </div>
            </div>

            {/* Card Content Body */}
            <div className="p-4 sm:p-6 space-y-4 flex-1 flex flex-col justify-between">
              <div className="space-y-1.5">
                <h3 className="text-base sm:text-lg font-extrabold text-[#0B192C] dark:text-white leading-snug">
                  {isArabic ? vh.nameAr : vh.nameEn}
                </h3>
                <p className="text-xs text-slate-500">
                  {isArabic ? vh.modelAr : vh.modelEn}
                </p>
              </div>

              <div className="space-y-1.5">
                {(isArabic ? vh.featuresAr : vh.featuresEn).map((feat, i) => (
                  <div key={i} className="flex items-center gap-2 text-xs text-slate-700 dark:text-slate-300">
                    <Check className="h-3.5 w-3.5 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                    <span className="truncate">{feat}</span>
                  </div>
                ))}
              </div>

              <div className="pt-4 border-t border-slate-100 dark:border-slate-800 flex flex-col xs:flex-row sm:flex-row items-stretch xs:items-center sm:items-center justify-between gap-3">
                <div>
                  <div className="text-[10px] text-slate-500 font-medium">
                    {isArabic ? 'السعر' : 'Rate'}
                  </div>
                  <div className="flex items-baseline gap-1">
                    <span className="text-xl sm:text-2xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                      {vh.pricePerDay.toLocaleString()}
                    </span>
                    <span className="text-xs font-bold text-slate-500">
                      {isArabic ? (selectedType === 'transfers' ? 'ر.س / مشوار' : 'ر.س / يوم') : (selectedType === 'transfers' ? 'SAR / Trip' : 'SAR / Day')}
                    </span>
                  </div>
                </div>

                <button
                  onClick={() => handleBook(vh)}
                  className="w-full xs:w-auto sm:w-auto h-11 px-6 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-extrabold text-xs shadow-md transition-all active:scale-95 text-center"
                >
                  {isArabic ? 'احجز الآن' : 'Book Vehicle'}
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
