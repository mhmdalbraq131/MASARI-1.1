import React from 'react';
import {
  Sparkles,
  ArrowLeft,
  ArrowRight,
  ShieldAlert,
  CheckCircle2,
  Lock,
  Layers,
  Code,
  Smartphone,
  ExternalLink
} from 'lucide-react';
import { MASARI_ROUTES } from '../../data/routesData';
import { Language, UserRole } from '../../types';

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
  const routeInfo = MASARI_ROUTES.find((r) => r.path === currentPath);

  // Protected route check
  if (routeInfo?.protectedRole && routeInfo.protectedRole !== 'guest' && userRole === 'guest') {
    return (
      <div className="p-8 max-w-2xl mx-auto my-12 text-center rounded-3xl bg-[#0A1631] border border-[#EF4444]/30 space-y-6">
        <div className="inline-flex p-4 rounded-full bg-[#EF4444]/15 text-[#EF4444]">
          <Lock className="h-10 w-10" />
        </div>
        <div className="space-y-2">
          <h2 className="text-2xl font-extrabold text-[#EF4444]">
            {isArabic ? 'مسار محمي بواسطة ProtectedRouteGuard' : 'Protected Route Guard Active'}
          </h2>
          <p className="text-sm text-[#94A3B8]">
            {isArabic
              ? `يتطلب الوصول إلى هذا المسار (${currentPath}) تسجيل الدخول بحساب (${routeInfo.protectedRole}).`
              : `Access to ${currentPath} requires an authenticated user with role (${routeInfo.protectedRole}).`}
          </p>
        </div>
        <div className="flex justify-center gap-3">
          <button
            onClick={() => onNavigate('/home')}
            className="px-5 py-2.5 rounded-xl bg-[#D4AF37] text-[#050914] font-bold text-xs"
          >
            {isArabic ? 'العودة للرئيسية' : 'Back to Home'}
          </button>
        </div>
      </div>
    );
  }

  const title = isArabic
    ? routeInfo?.titleAr || currentPath.replace('/', '').toUpperCase()
    : routeInfo?.titleEn || currentPath.replace('/', '').toUpperCase();

  const subtitle = isArabic
    ? routeInfo?.subtitleAr || 'المعمارية التقنية للمسار المباشر'
    : routeInfo?.subtitleEn || 'Direct Route Architecture Overview';

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-5xl mx-auto">
      {/* Header & Navigation Breadcrumb */}
      <div className="flex items-center justify-between">
        <button
          onClick={() => onNavigate('/home')}
          className="flex items-center gap-2 text-xs font-semibold text-[#D4AF37] hover:underline"
        >
          {isArabic ? <ArrowRight className="h-4 w-4" /> : <ArrowLeft className="h-4 w-4" />}
          <span>{isArabic ? 'العودة للوحة التحكم' : 'Back to Dashboard'}</span>
        </button>

        <span className="px-3 py-1 rounded-full bg-[#0A1631] border border-[#1E293B] text-xs font-mono text-[#00D4FF]">
          Route: {currentPath}
        </span>
      </div>

      {/* Main Feature Banner */}
      <div className="rounded-3xl bg-gradient-to-br from-[#0A1631] to-[#050914] border border-[#D4AF37]/30 p-8 space-y-6">
        <div className="flex items-center gap-3">
          <div className="p-3.5 rounded-2xl bg-[#D4AF37]/15 text-[#D4AF37]">
            <Sparkles className="h-7 w-7" />
          </div>
          <div>
            <h1 className="text-2xl md:text-3xl font-extrabold text-[#D4AF37]">
              {title}
            </h1>
            <p className="text-sm text-[#94A3B8] mt-1">{subtitle}</p>
          </div>
        </div>

        {/* Feature Cards Showcase */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 pt-4">
          <div className="p-4 rounded-2xl bg-[#050914] border border-[#1E293B] space-y-2">
            <div className="flex items-center gap-2 text-[#00D4FF] text-xs font-bold">
              <Layers className="h-4 w-4" />
              <span>{isArabic ? 'المعمارية البرمجية' : 'Clean Architecture'}</span>
            </div>
            <p className="text-xs text-[#94A3B8]">
              {isArabic ? 'Domain Entities, Repositories, and Presentation State.' : 'Separation of concerns into Domain, Data & Presentation.'}
            </p>
          </div>

          <div className="p-4 rounded-2xl bg-[#050914] border border-[#1E293B] space-y-2">
            <div className="flex items-center gap-2 text-[#10B981] text-xs font-bold">
              <Code className="h-4 w-4" />
              <span>{isArabic ? 'إدارة الحالة State' : 'Riverpod Providers'}</span>
            </div>
            <p className="text-xs text-[#94A3B8]">
              {isArabic ? 'مزودات الحالة localeProvider & themeModeProvider.' : 'Reactive state management with Riverpod.'}
            </p>
          </div>

          <div className="p-4 rounded-2xl bg-[#050914] border border-[#1E293B] space-y-2">
            <div className="flex items-center gap-2 text-[#FF7F50] text-xs font-bold">
              <Smartphone className="h-4 w-4" />
              <span>{isArabic ? 'توافق المنصات' : 'Multi-Platform Shell'}</span>
            </div>
            <p className="text-xs text-[#94A3B8]">
              {isArabic ? 'استجابة متكاملة للويب، iOS، و Android.' : 'Responsive MasariAppShell across Web, iOS & Android.'}
            </p>
          </div>
        </div>

        {/* Status Checkbox Items */}
        <div className="p-4 rounded-2xl bg-[#0A1631]/80 border border-[#D4AF37]/20 space-y-3">
          <div className="text-xs font-bold text-[#D4AF37]">
            {isArabic ? 'جاهزية المسار والأساس الهندسي:' : 'Route Architectural Verification:'}
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-2 text-xs text-[#F8FAFC]">
            <div className="flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-[#10B981]" />
              <span>{isArabic ? 'ربط GoRouter المحمي' : 'GoRouter Route Bound'}</span>
            </div>
            <div className="flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-[#10B981]" />
              <span>{isArabic ? 'دعم العربية RTL والإنجليزية LTR' : 'RTL/LTR Dynamic Localizations'}</span>
            </div>
            <div className="flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-[#10B981]" />
              <span>{isArabic ? 'بنية مساري الفاخرة Dark Theme' : 'MASARI Royal Dark Design System'}</span>
            </div>
            <div className="flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-[#10B981]" />
              <span>{isArabic ? 'تهيئة خدمات Firebase' : 'Firebase Core Ready'}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
