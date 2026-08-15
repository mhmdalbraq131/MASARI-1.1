import React, { useState } from 'react';
import { 
  ShieldAlert, 
  Users, 
  TrendingUp, 
  CreditCard, 
  CheckCircle2, 
  AlertTriangle, 
  ToggleLeft, 
  ToggleRight,
  Search,
  Activity,
  Layers,
  FileText,
  Lock
} from 'lucide-react';
import { Language, UserRole } from '../../types';

interface AdminViewProps {
  language: Language;
  userRole: UserRole;
  onNavigate: (path: string) => void;
}

export const AdminView: React.FC<AdminViewProps> = ({ language, userRole, onNavigate }) => {
  const isArabic = language === 'ar';
  const [serviceStatus, setServiceStatus] = useState({
    flights: true,
    hotels: true,
    hajjUmrah: true,
    tourism: true,
    fleet: true,
    visa: true,
  });

  if (userRole !== 'admin') {
    return (
      <div className="p-8 max-w-xl mx-auto my-12 text-center rounded-3xl bg-white dark:bg-[#0A1631] border border-[#EF4444]/30 shadow-xl space-y-6">
        <div className="inline-flex p-4 rounded-full bg-[#EF4444]/15 text-[#EF4444]">
          <ShieldAlert className="h-10 w-10" />
        </div>
        <div className="space-y-2">
          <h2 className="text-xl font-extrabold text-[#EF4444]">
            {isArabic ? 'صلاحيات الإدارة العليا مطلوبة' : 'Administrative Privileges Required'}
          </h2>
          <p className="text-sm text-slate-600 dark:text-slate-400">
            {isArabic
              ? 'الوصول إلى بوابة الإدارة محصور بالمشرفين المعتمدين. يمكنك تبديل الدور من الشريط العلوي للتجربة.'
              : 'Access to the Admin Portal is restricted to authorized operations managers.'}
          </p>
        </div>
        <button
          onClick={() => onNavigate('/home')}
          className="px-6 py-2.5 rounded-xl bg-[#FF6500] text-white font-bold text-xs"
        >
          {isArabic ? 'العودة للرئيسية' : 'Return to Home'}
        </button>
      </div>
    );
  }

  const toggleService = (key: keyof typeof serviceStatus) => {
    setServiceStatus((prev) => ({ ...prev, [key]: !prev[key] }));
  };

  return (
    <div className="p-4 md:p-8 space-y-8 max-w-7xl mx-auto w-full transition-colors">
      {/* Admin Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 p-6 rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white shadow-xl">
        <div className="space-y-1">
          <div className="flex items-center gap-2 text-xs font-bold text-[#00D4FF]">
            <ShieldAlert className="h-4 w-4" />
            <span>{isArabic ? 'مركز عمليات منصة مساري' : 'MASARI Operations Control Hub'}</span>
          </div>
          <h1 className="text-2xl font-extrabold text-white">
            {isArabic ? 'بوابة الإدارة والتشغيل والرقابة' : 'Operational Administration Portal'}
          </h1>
        </div>
        <div className="flex items-center gap-2">
          <span className="px-3 py-1.5 rounded-xl bg-[#10B981]/20 border border-[#10B981]/40 text-[#10B981] text-xs font-bold flex items-center gap-1.5">
            <span className="h-2 w-2 rounded-full bg-[#10B981] animate-pulse"></span>
            {isArabic ? 'الأنظمة التشغيلية تعمل بكفاءة' : 'All Operations Live'}
          </span>
        </div>
      </div>

      {/* KPI Stats Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {[
          { labelAr: 'إجمالي الحجوزات النشطة', labelEn: 'Active Bookings', val: '1,428', change: '+12.4%', icon: Activity },
          { labelAr: 'إيرادات المبيعات (اليوم)', labelEn: 'Today Sales (SAR)', val: '384,500 ر.س', change: '+8.2%', icon: TrendingUp },
          { labelAr: 'المسافرين المعتمدين', labelEn: 'Verified Travelers', val: '28,940', change: '+4.5%', icon: Users },
          { labelAr: 'طلبات التأشيرات الفورية', labelEn: 'Visa Applications', val: '342', change: '+19.1%', icon: FileText },
        ].map((kpi, idx) => {
          const Icon = kpi.icon;
          return (
            <div
              key={idx}
              className="p-5 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-3 shadow-sm"
            >
              <div className="flex items-center justify-between">
                <span className="text-xs text-slate-500 font-medium">
                  {isArabic ? kpi.labelAr : kpi.labelEn}
                </span>
                <div className="p-2 rounded-xl bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF]">
                  <Icon className="h-4 w-4" />
                </div>
              </div>
              <div className="text-2xl font-black text-[#0B192C] dark:text-white">
                {kpi.val}
              </div>
              <div className="text-[11px] font-bold text-[#10B981]">
                {kpi.change} {isArabic ? 'مقارنة بالأسبوع الماضي' : 'vs last week'}
              </div>
            </div>
          );
        })}
      </div>

      {/* Service Operational Toggles */}
      <div className="p-6 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-4 shadow-sm">
        <h2 className="text-base font-extrabold text-[#0B192C] dark:text-white">
          {isArabic ? 'حالة بوابات الحجز المباشر' : 'Live Booking Gateways Status'}
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3">
          {[
            { key: 'flights', labelAr: 'حجوزات الطيران', labelEn: 'Flights API' },
            { key: 'hotels', labelAr: 'بوابة الفنادق', labelEn: 'Hotels CRS' },
            { key: 'hajjUmrah', labelAr: 'باقات الحج والعمرة', labelEn: 'Hajj/Umrah Ops' },
            { key: 'tourism', labelAr: 'البرامج السياحية', labelEn: 'Tourism Gateway' },
            { key: 'fleet', labelAr: 'أسطول النقل VIP', labelEn: 'Fleet Dispatch' },
            { key: 'visa', labelAr: 'إصدار التأشيرات', labelEn: 'e-Visa System' },
          ].map((srv) => {
            const isOnline = serviceStatus[srv.key as keyof typeof serviceStatus];
            return (
              <button
                key={srv.key}
                onClick={() => toggleService(srv.key as any)}
                className={`p-3.5 rounded-2xl border text-center transition-all flex flex-col items-center justify-between gap-2 ${
                  isOnline
                    ? 'bg-slate-50 dark:bg-slate-800/40 border-slate-200 dark:border-slate-700'
                    : 'bg-red-500/10 border-red-500/30'
                }`}
              >
                <span className="text-xs font-bold text-[#0B192C] dark:text-white">
                  {isArabic ? srv.labelAr : srv.labelEn}
                </span>
                <span
                  className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${
                    isOnline
                      ? 'bg-[#10B981]/15 text-[#10B981]'
                      : 'bg-red-500/20 text-red-400'
                  }`}
                >
                  {isOnline ? (isArabic ? 'نشط ومتاح' : 'ONLINE') : (isArabic ? 'معطل' : 'PAUSED')}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Recent Live Orders Table */}
      <div className="p-6 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-4 shadow-sm">
        <h2 className="text-base font-extrabold text-[#0B192C] dark:text-white">
          {isArabic ? 'أحدث المعاملات والحجوزات الفورية' : 'Live Customer Bookings Stream'}
        </h2>
        <div className="overflow-x-auto">
          <table className="w-full text-xs text-right">
            <thead>
              <tr className="border-b border-slate-100 dark:border-slate-800 text-slate-400 pb-2">
                <th className="pb-3 pr-2">{isArabic ? 'رقم الحجز' : 'Ref'}</th>
                <th className="pb-3">{isArabic ? 'العميل' : 'Customer'}</th>
                <th className="pb-3">{isArabic ? 'الخدمة' : 'Service'}</th>
                <th className="pb-3">{isArabic ? 'المبلغ' : 'Amount'}</th>
                <th className="pb-3">{isArabic ? 'الحالة' : 'Status'}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 dark:divide-slate-800">
              {[
                { ref: 'MSR-8841', name: 'سلطان بن فهد', srv: 'باقة الصفوة الملكية للحج', amt: '34,500 ر.س', status: 'مؤكد' },
                { ref: 'MSR-8840', name: 'Dr. Sarah Jenkins', srv: 'Luxury AlUla Tour', amt: '3,850 ر.س', status: 'مؤكد' },
                { ref: 'MSR-8839', name: 'عبد الرحمن القحطاني', srv: 'فندق رافلز مكة (ليلتان)', amt: '4,900 ر.س', status: 'قيد الدفع' },
                { ref: 'MSR-8838', name: 'طارق الزهراني', srv: 'مرسيدس مايباخ (توصيل مطار)', amt: '450 ر.س', status: 'مكتمل' },
              ].map((row, i) => (
                <tr key={i} className="text-slate-800 dark:text-slate-200">
                  <td className="py-3 pr-2 font-mono font-bold">{row.ref}</td>
                  <td className="py-3 font-semibold">{row.name}</td>
                  <td className="py-3">{row.srv}</td>
                  <td className="py-3 font-bold text-[#008DDA] dark:text-[#00D4FF]">{row.amt}</td>
                  <td className="py-3">
                    <span className="px-2.5 py-1 rounded-full bg-[#10B981]/15 text-[#10B981] text-[10px] font-bold">
                      {row.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
