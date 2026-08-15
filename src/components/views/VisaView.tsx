import React, { useState } from 'react';
import { 
  FileCheck, 
  ShieldCheck, 
  Clock, 
  Check, 
  Calendar, 
  Sparkles,
  HelpCircle,
  ArrowRight
} from 'lucide-react';
import { Language } from '../../types';
import { VISA_TYPES, VisaType } from '../../data/travelData';

interface VisaViewProps {
  language: Language;
  onNavigate: (path: string) => void;
}

export const VisaView: React.FC<VisaViewProps> = ({ language, onNavigate }) => {
  const isArabic = language === 'ar';
  const [selectedVisa, setSelectedVisa] = useState<VisaType | null>(null);
  const [submitted, setSubmitted] = useState(false);

  const handleApply = (visa: VisaType) => {
    setSelectedVisa(visa);
    setSubmitted(true);
    setTimeout(() => {
      setSubmitted(false);
    }, 4000);
  };

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-7xl mx-auto w-full transition-colors">
      {/* Header Banner */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-6 md:p-10 shadow-xl">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-72 h-72 bg-[#00D4FF]/15 rounded-full blur-3xl pointer-events-none"></div>
        <div className="relative z-10 space-y-3 max-w-3xl">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#00D4FF]/20 border border-[#00D4FF]/40 text-xs font-bold text-[#00D4FF]">
            <FileCheck className="h-4 w-4" />
            <span>{isArabic ? 'بوابة التأشيرات وتصاريح الدخول الفورية' : 'Instant e-Visa & Travel Authorization'}</span>
          </div>
          <h1 className="text-2xl md:text-4xl font-extrabold tracking-tight text-white">
            {isArabic ? 'إصدار التأشيرات السياحية وتأشيرات العمرة' : 'Saudi Tourist, Umrah & Transit Visas'}
          </h1>
          <p className="text-sm md:text-base text-slate-200 leading-relaxed">
            {isArabic
              ? 'إجراءات مبسطة وتأشيرات إلكترونية سريعة معتمدة من وزارة الخارجية والمنصات الرسمية شاملة التأمين الطبي وتصاريح نسك.'
              : 'Streamlined online visa application with certified official verification, comprehensive medical insurance, and Nusuk permit integration.'}
          </p>
        </div>
      </div>

      {/* Submission Alert */}
      {submitted && selectedVisa && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex items-center justify-between shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-sm font-bold">
              {isArabic
                ? `تم استلام طلب إصدار: "${selectedVisa.titleAr}". سيتم إشعارك بصدور التأشيرة خلال ${selectedVisa.processingTimeAr}.`
                : `Application received for "${selectedVisa.titleEn}". You will receive updates within ${selectedVisa.processingTimeEn}.`}
            </div>
          </div>
          <button
            onClick={() => onNavigate('/bookings')}
            className="px-3 py-1.5 rounded-xl bg-[#10B981] text-white font-bold text-xs"
          >
            {isArabic ? 'متابعة الطلب' : 'Track Status'}
          </button>
        </div>
      )}

      {/* Visa Cards Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {VISA_TYPES.map((visa) => (
          <div
            key={visa.id}
            className="flex flex-col rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-6 shadow-sm hover:shadow-xl dark:shadow-none hover:border-[#00D4FF]/50 transition-all justify-between space-y-6"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="p-3 rounded-2xl bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF]">
                  <FileCheck className="h-6 w-6" />
                </div>
                <span className="px-3 py-1 rounded-full bg-slate-100 dark:bg-slate-800 text-[11px] font-bold text-slate-700 dark:text-slate-300">
                  {isArabic ? visa.validityAr : visa.validityEn}
                </span>
              </div>

              <div>
                <h3 className="text-lg font-extrabold text-[#0B192C] dark:text-white">
                  {isArabic ? visa.titleAr : visa.titleEn}
                </h3>
                <p className="text-xs text-slate-500 mt-1">
                  {isArabic ? visa.stayDurationAr : visa.stayDurationEn}
                </p>
              </div>

              <div className="flex items-center gap-2 p-2.5 rounded-xl bg-slate-50 dark:bg-slate-800/40 text-xs text-slate-600 dark:text-slate-400">
                <Clock className="h-4 w-4 text-[#008DDA] dark:text-[#00D4FF] shrink-0" />
                <span>
                  {isArabic ? `وقت المعالجة: ${visa.processingTimeAr}` : `Processing Time: ${visa.processingTimeEn}`}
                </span>
              </div>

              <div className="space-y-2">
                <div className="text-xs font-bold text-slate-700 dark:text-slate-300">
                  {isArabic ? 'المستندات المطلوبة:' : 'Requirements:'}
                </div>
                {visa.requirementsAr.map((req, i) => (
                  <div key={i} className="flex items-center gap-2 text-xs text-slate-600 dark:text-slate-400">
                    <Check className="h-3.5 w-3.5 text-[#10B981] shrink-0" />
                    <span>{req}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="pt-4 border-t border-slate-100 dark:border-slate-800 flex items-center justify-between">
              <div>
                <div className="text-[10px] text-slate-500 font-medium">
                  {isArabic ? 'رسوم التأشيرة والتأمين' : 'Fee & Insurance'}
                </div>
                <div className="flex items-baseline gap-1">
                  <span className="text-xl font-black text-[#0B192C] dark:text-[#00D4FF]">
                    {visa.fee}
                  </span>
                  <span className="text-xs font-bold text-slate-500">
                    {isArabic ? 'ر.س' : 'SAR'}
                  </span>
                </div>
              </div>

              <button
                onClick={() => handleApply(visa)}
                className="px-5 py-2.5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-extrabold text-xs shadow-md transition-all active:scale-95"
              >
                {isArabic ? 'تقديم الطلب' : 'Apply Now'}
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
