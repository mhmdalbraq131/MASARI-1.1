import React, { useState } from 'react';
import { 
  Sparkles, 
  ArrowLeft, 
  ArrowRight, 
  ShieldCheck, 
  CheckCircle2, 
  PhoneCall, 
  Calendar, 
  Lock
} from 'lucide-react';
import { Language, UserRole } from '../../types';
import { MASARI_ROUTES } from '../../data/routesData';

interface GenericServiceViewProps {
  currentPath: string;
  language: Language;
  userRole: UserRole;
  onNavigate: (path: string) => void;
}

export const GenericServiceView: React.FC<GenericServiceViewProps> = ({
  currentPath,
  language,
  userRole,
  onNavigate,
}) => {
  const isArabic = language === 'ar';
  const [requestSent, setRequestSent] = useState(false);

  // Find route metadata
  const routeInfo = MASARI_ROUTES.find((r) => r.path === currentPath);
  const title = isArabic
    ? routeInfo?.titleAr || 'خدمة مساري الفاخرة'
    : routeInfo?.titleEn || 'MASARI Premium Service';
  const subtitle = isArabic
    ? routeInfo?.subtitleAr || 'خدمات مخصصة لتلبية كافة تطلعاتكم بأعلى معايير الرفاهية والأمان'
    : routeInfo?.subtitleEn || 'Dedicated personalized services tailored to your travel requirements';

  // Protected route check
  if (routeInfo?.protectedRole && routeInfo.protectedRole !== 'guest' && userRole === 'guest') {
    return (
      <div className="p-8 max-w-xl mx-auto my-12 text-center rounded-3xl bg-white dark:bg-[#0A1631] border border-[#EF4444]/30 space-y-6 shadow-xl">
        <div className="inline-flex p-4 rounded-full bg-[#EF4444]/15 text-[#EF4444]">
          <Lock className="h-10 w-10" />
        </div>
        <div className="space-y-2">
          <h2 className="text-xl font-extrabold text-[#EF4444]">
            {isArabic ? 'تسجيل الدخول مطلوب' : 'Authentication Required'}
          </h2>
          <p className="text-sm text-slate-600 dark:text-slate-400">
            {isArabic
              ? 'يرجى تسجيل الدخول للوصول إلى هذه الخدمة وإدارة تفضيلاتك.'
              : 'Please sign in to access this personalized service.'}
          </p>
        </div>
        <button
          onClick={() => onNavigate('/home')}
          className="px-6 py-2.5 rounded-xl bg-[#FF6500] text-white font-bold text-xs shadow-md"
        >
          {isArabic ? 'العودة للرئيسية' : 'Back to Home'}
        </button>
      </div>
    );
  }

  const handleSendRequest = () => {
    setRequestSent(true);
    setTimeout(() => {
      setRequestSent(false);
    }, 4000);
  };

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-5xl mx-auto w-full transition-colors">
      {/* Navigation Breadcrumb */}
      <div className="flex items-center justify-between">
        <button
          onClick={() => onNavigate('/home')}
          className="flex items-center gap-2 text-xs font-semibold text-[#008DDA] dark:text-[#00D4FF] hover:underline"
        >
          {isArabic ? <ArrowRight className="h-4 w-4" /> : <ArrowLeft className="h-4 w-4" />}
          <span>{isArabic ? 'العودة للرئيسية' : 'Back to Home'}</span>
        </button>
      </div>

      {/* Main Feature Banner */}
      <div className="rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white p-8 space-y-6 shadow-xl">
        <div className="flex items-center gap-3">
          <div className="p-3.5 rounded-2xl bg-[#00D4FF]/15 text-[#00D4FF]">
            <Sparkles className="h-7 w-7" />
          </div>
          <div>
            <h1 className="text-2xl md:text-3xl font-extrabold text-white">
              {title}
            </h1>
            <p className="text-sm text-slate-200 mt-1">{subtitle}</p>
          </div>
        </div>

        {/* Customer Highlights */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 pt-2">
          <div className="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1.5">
            <div className="text-xs font-bold text-[#00D4FF]">
              {isArabic ? 'خدمة مخصصة VIP' : 'Bespoke VIP Service'}
            </div>
            <p className="text-xs text-slate-300">
              {isArabic ? 'تصميم الرحلة بما يتوافق مع رغباتكم الخاصة.' : 'Tailored itinerary for your exact travel preferences.'}
            </p>
          </div>

          <div className="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1.5">
            <div className="text-xs font-bold text-[#10B981]">
              {isArabic ? 'مستشار سياحي خاص' : 'Dedicated Concierge'}
            </div>
            <p className="text-xs text-slate-300">
              {isArabic ? 'فريق دعم ومتابعة على مدار 24 ساعة طوال الرحلة.' : '24/7 priority concierge & trip coordination.'}
            </p>
          </div>

          <div className="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1.5">
            <div className="text-xs font-bold text-[#FF6500]">
              {isArabic ? 'أعلى معايير الأمان والخصوصية' : 'Highest Privacy Standards'}
            </div>
            <p className="text-xs text-slate-300">
              {isArabic ? 'حفظ البيانات وتوفير أقصى درجات الراحة.' : 'Uncompromised security, luxury and privacy.'}
            </p>
          </div>
        </div>
      </div>

      {/* Request Alert */}
      {requestSent && (
        <div className="p-4 rounded-2xl bg-[#10B981]/15 border border-[#10B981]/40 text-[#10B981] flex items-center justify-between shadow-lg">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-6 w-6 shrink-0" />
            <div className="text-sm font-bold">
              {isArabic
                ? 'تم استلام طلب الخدمة بنجاح. سيتواصل معك مستشار مساري خلال دقائق.'
                : 'Service inquiry received. Our concierge team will reach out shortly.'}
            </div>
          </div>
        </div>
      )}

      {/* Inquiry Form */}
      <div className="p-6 md:p-8 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-5 shadow-sm">
        <h3 className="text-base font-extrabold text-[#0B192C] dark:text-white">
          {isArabic ? 'طلب استشارة أو حجز خاص' : 'Special Booking & Inquiry Request'}
        </h3>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs">
          <div className="space-y-1.5">
            <label className="font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'الاسم الكامل' : 'Full Name'}
            </label>
            <input
              type="text"
              defaultValue={isArabic ? 'محمد عبد الله' : 'Mohammed Abdullah'}
              className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white font-semibold focus:outline-none focus:border-[#00D4FF]"
            />
          </div>

          <div className="space-y-1.5">
            <label className="font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'رقم الجوال أو الواتساب' : 'Mobile / WhatsApp Number'}
            </label>
            <input
              type="text"
              defaultValue="+966 50 123 4567"
              className="w-full h-11 px-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white font-semibold focus:outline-none focus:border-[#00D4FF]"
            />
          </div>

          <div className="md:col-span-2 space-y-1.5">
            <label className="font-bold text-slate-700 dark:text-slate-300">
              {isArabic ? 'تفاصيل الطلب أو الملاحظات' : 'Trip Details / Requirements'}
            </label>
            <textarea
              rows={3}
              placeholder={isArabic ? 'اكتب تفاصيل الرحلة، عدد المسافرين، التواريخ المرغوبة...' : 'Specify dates, number of guests, special preferences...'}
              className="w-full p-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white font-semibold focus:outline-none focus:border-[#00D4FF]"
            ></textarea>
          </div>
        </div>

        <div className="flex justify-end pt-2">
          <button
            onClick={handleSendRequest}
            className="px-6 py-3 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-md transition-all active:scale-95"
          >
            {isArabic ? 'إرسال طلب الحجز' : 'Submit Request'}
          </button>
        </div>
      </div>
    </div>
  );
};
