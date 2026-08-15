import React, { useState } from 'react';
import { 
  Wallet, 
  Ticket, 
  Users, 
  Shield, 
  Sparkles, 
  User, 
  Settings, 
  CheckCircle2, 
  CreditCard, 
  Clock, 
  Plane, 
  Hotel, 
  Palmtree, 
  Download,
  Plus,
  Send,
  Lock
} from 'lucide-react';
import { Language, UserRole } from '../../types';

interface UserAccountViewsProps {
  language: Language;
  currentPath: string;
  userRole: UserRole;
  onNavigate: (path: string) => void;
}

export const UserAccountViews: React.FC<UserAccountViewsProps> = ({
  language,
  currentPath,
  userRole,
  onNavigate,
}) => {
  const isArabic = language === 'ar';
  const [aiPrompt, setAiPrompt] = useState('');
  const [aiMessages, setAiMessages] = useState([
    {
      sender: 'bot',
      textAr: 'أهلاً بك في مستشار مساري الذكي للرحلات والسياحة. كيف يمكنني مساعدتك في تخطيط رحلتك القادمة أو حجز مناسك العمرة والحج؟',
      textEn: 'Welcome to MASARI AI Travel & Pilgrimage Assistant. How can I assist you with your upcoming travel or Umrah plans today?',
    }
  ]);

  // Protected guard
  if (userRole === 'guest' && currentPath !== '/settings' && currentPath !== '/ai') {
    return (
      <div className="p-8 max-w-xl mx-auto my-12 text-center rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] shadow-xl space-y-6">
        <div className="inline-flex p-4 rounded-full bg-[#00D4FF]/10 text-[#008DDA] dark:text-[#00D4FF]">
          <Lock className="h-10 w-10" />
        </div>
        <div className="space-y-2">
          <h2 className="text-xl font-extrabold text-[#0B192C] dark:text-white">
            {isArabic ? 'تسجيل الدخول مطلوب' : 'Authentication Required'}
          </h2>
          <p className="text-sm text-slate-600 dark:text-slate-400">
            {isArabic
              ? 'يرجى تسجيل الدخول للوصول إلى محفظتك، سجل حجوزاتك، وإدارة وثائق السفر.'
              : 'Please sign in to access your wallet, bookings history, and travel documents.'}
          </p>
        </div>
        <button
          onClick={() => onNavigate('/home')}
          className="px-6 py-2.5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs shadow-md"
        >
          {isArabic ? 'العودة للرئيسية' : 'Return to Home'}
        </button>
      </div>
    );
  }

  // Wallet View
  if (currentPath === '/wallet') {
    return (
      <div className="p-4 md:p-8 space-y-6 max-w-5xl mx-auto w-full">
        <div className="p-6 md:p-8 rounded-3xl bg-gradient-to-br from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white space-y-4 shadow-xl">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-[#00D4FF] flex items-center gap-1.5">
              <Wallet className="h-4 w-4" />
              {isArabic ? 'محفظة مساري الرقمية' : 'MASARI Digital Wallet'}
            </span>
            <span className="px-3 py-1 rounded-full bg-[#00D4FF]/20 text-[#00D4FF] text-xs font-bold">
              {isArabic ? 'عضوية النخبة' : 'Elite Tier'}
            </span>
          </div>
          <div>
            <div className="text-xs text-slate-300">{isArabic ? 'الرصيد المتاح' : 'Available Balance'}</div>
            <div className="text-3xl md:text-4xl font-black text-white mt-1">
              14,850.00 <span className="text-sm font-bold text-[#00D4FF]">{isArabic ? 'ر.س' : 'SAR'}</span>
            </div>
          </div>
          <div className="flex gap-3 pt-2">
            <button className="px-4 py-2 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white text-xs font-bold shadow-md">
              {isArabic ? 'شحن الرصيد' : 'Top Up'}
            </button>
            <button className="px-4 py-2 rounded-xl bg-white/10 hover:bg-white/20 text-white text-xs font-bold">
              {isArabic ? 'استبدال النقاط' : 'Redeem Points'}
            </button>
          </div>
        </div>

        {/* Transaction History */}
        <div className="rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-6 space-y-4">
          <h3 className="text-base font-extrabold text-[#0B192C] dark:text-white">
            {isArabic ? 'آخر العمليات المالية' : 'Recent Transactions'}
          </h3>
          <div className="space-y-3">
            {[
              { title: 'حجز فندق قصر مكة رافلز', date: '12 أغسطس 2026', amount: '-2,450 ر.س', type: 'debit' },
              { title: 'استرداد مكافأة برنامج الولاء', date: '05 أغسطس 2026', amount: '+500 ر.س', type: 'credit' },
              { title: 'حجز رحلة الرياض - جدة VIP', date: '28 يوليو 2026', amount: '-1,150 ر.س', type: 'debit' },
            ].map((tx, idx) => (
              <div key={idx} className="flex items-center justify-between p-3.5 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-100 dark:border-slate-800">
                <div>
                  <div className="text-xs font-bold text-[#0B192C] dark:text-white">{tx.title}</div>
                  <div className="text-[11px] text-slate-500">{tx.date}</div>
                </div>
                <div className={`text-xs font-black ${tx.type === 'credit' ? 'text-[#10B981]' : 'text-slate-800 dark:text-slate-200'}`}>
                  {tx.amount}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  // Bookings View
  if (currentPath === '/bookings') {
    return (
      <div className="p-4 md:p-8 space-y-6 max-w-5xl mx-auto w-full">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-extrabold text-[#0B192C] dark:text-white">
            {isArabic ? 'سجل الحجوزات والرحلات' : 'My Bookings & Travel Records'}
          </h1>
          <button className="px-4 py-2 rounded-xl bg-[#00D4FF]/15 text-[#008DDA] dark:text-[#00D4FF] text-xs font-bold">
            {isArabic ? 'الحجوزات النشطة (2)' : 'Active (2)'}
          </button>
        </div>

        <div className="space-y-4">
          <div className="p-6 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-4 shadow-sm">
            <div className="flex items-center justify-between border-b border-slate-100 dark:border-slate-800 pb-3">
              <div className="flex items-center gap-2">
                <Palmtree className="h-5 w-5 text-[#008DDA] dark:text-[#00D4FF]" />
                <span className="text-sm font-extrabold text-[#0B192C] dark:text-white">
                  {isArabic ? 'رحلة استكشاف العلا ومدائن صالح الفاخرة' : 'Luxury AlUla & Hegra Heritage'}
                </span>
              </div>
              <span className="px-3 py-1 rounded-full bg-[#10B981]/15 text-[#10B981] text-xs font-bold">
                {isArabic ? 'مؤكد ونشط' : 'Confirmed'}
              </span>
            </div>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-xs">
              <div>
                <span className="text-slate-500 block">{isArabic ? 'رقم الحجز:' : 'Booking Ref:'}</span>
                <span className="font-mono font-bold text-slate-800 dark:text-slate-200">MSR-98421</span>
              </div>
              <div>
                <span className="text-slate-500 block">{isArabic ? 'تاريخ المغادرة:' : 'Departure:'}</span>
                <span className="font-bold text-slate-800 dark:text-slate-200">15 سبتمبر 2026</span>
              </div>
              <div>
                <span className="text-slate-500 block">{isArabic ? 'المسافرين:' : 'Travelers:'}</span>
                <span className="font-bold text-slate-800 dark:text-slate-200">2 بالغين</span>
              </div>
              <div>
                <span className="text-slate-500 block">{isArabic ? 'المبلغ الإجمالي:' : 'Total Paid:'}</span>
                <span className="font-bold text-[#008DDA] dark:text-[#00D4FF]">7,700 ر.س</span>
              </div>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <button className="px-4 py-2 rounded-xl bg-slate-100 dark:bg-slate-800 text-xs font-bold text-slate-700 dark:text-slate-300">
                {isArabic ? 'تحميل القسيمة PDF' : 'Download Voucher'}
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // AI Assistant View
  if (currentPath === '/ai') {
    const handleSend = () => {
      if (!aiPrompt.trim()) return;
      const userMsg = { sender: 'user', textAr: aiPrompt, textEn: aiPrompt };
      const newBot = {
        sender: 'bot',
        textAr: `بناءً على طلبك، يُنصح بحجز رحلة العلا الفاخرة مع إقامة ليلتين في منتجع بانيان تري، واستخدام خدمة النقل الخاص بمايباخ للحصول على أعلى درجات الراحة والسكينة.`,
        textEn: `Based on your preferences, we recommend the Luxury AlUla package staying at Banyan Tree Resort with our VIP Chauffeur Maybach service.`,
      };
      setAiMessages([...aiMessages, userMsg, newBot]);
      setAiPrompt('');
    };

    return (
      <div className="p-4 md:p-8 max-w-4xl mx-auto w-full space-y-6">
        <div className="p-6 rounded-3xl bg-gradient-to-r from-[#0B192C] via-[#1E3E62] to-[#0B192C] text-white flex items-center justify-between">
          <div className="space-y-1">
            <div className="flex items-center gap-2 text-xs font-bold text-[#00D4FF]">
              <Sparkles className="h-4 w-4" />
              <span>{isArabic ? 'مستشار مساري الذكي' : 'MASARI AI Travel Concierge'}</span>
            </div>
            <h2 className="text-xl font-extrabold text-white">
              {isArabic ? 'تخطيط الرحلات واستشارات السفر الفورية' : 'Smart Travel Planning & Advising'}
            </h2>
          </div>
        </div>

        <div className="rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] p-6 space-y-4 h-[450px] flex flex-col justify-between shadow-sm">
          <div className="space-y-4 overflow-y-auto pr-2">
            {aiMessages.map((msg, i) => (
              <div
                key={i}
                className={`flex ${msg.sender === 'user' ? 'justify-end' : 'justify-start'}`}
              >
                <div
                  className={`max-w-[80%] p-4 rounded-2xl text-xs leading-relaxed ${
                    msg.sender === 'user'
                      ? 'bg-[#0B192C] text-white dark:bg-[#00D4FF] dark:text-[#050914]'
                      : 'bg-slate-100 dark:bg-slate-800 text-slate-800 dark:text-slate-200'
                  }`}
                >
                  {isArabic ? msg.textAr : msg.textEn}
                </div>
              </div>
            ))}
          </div>

          <div className="flex items-center gap-2 pt-2 border-t border-slate-100 dark:border-slate-800">
            <input
              type="text"
              value={aiPrompt}
              onChange={(e) => setAiPrompt(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && handleSend()}
              placeholder={isArabic ? 'اسأل عن أفضل أوقات العمرة، حجوزات العلا، أو باقات الحج...' : 'Ask about Umrah timings, AlUla packages, or flight options...'}
              className="flex-1 h-12 px-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-xs text-slate-900 dark:text-white focus:outline-none focus:border-[#00D4FF]"
            />
            <button
              onClick={handleSend}
              className="h-12 px-5 rounded-xl bg-[#FF6500] hover:bg-[#EA580C] text-white font-bold text-xs flex items-center justify-center gap-1 shadow-md"
            >
              <Send className="h-4 w-4" />
              <span>{isArabic ? 'إرسال' : 'Send'}</span>
            </button>
          </div>
        </div>
      </div>
    );
  }

  // Profile & Settings View fallback
  return (
    <div className="p-4 md:p-8 space-y-6 max-w-4xl mx-auto w-full">
      <div className="p-6 rounded-3xl bg-white dark:bg-[#0A1631] border border-slate-200 dark:border-[#1E293B] space-y-6 shadow-sm">
        <div className="flex items-center gap-4">
          <div className="h-16 w-16 rounded-full bg-[#00D4FF]/15 text-[#008DDA] dark:text-[#00D4FF] flex items-center justify-center font-black text-xl">
            MA
          </div>
          <div>
            <h2 className="text-lg font-extrabold text-[#0B192C] dark:text-white">
              {isArabic ? 'محمد عبد الله البراق' : 'Mohammed Abdullah Al-Baraq'}
            </h2>
            <p className="text-xs text-slate-500">mhmdalbraq131@gmail.com</p>
            <span className="inline-block mt-1 px-2.5 py-0.5 rounded-full bg-[#00D4FF]/20 text-[#008DDA] dark:text-[#00D4FF] text-[10px] font-bold">
              {isArabic ? 'عضوية مساري الملكية VIP' : 'MASARI Royal VIP Member'}
            </span>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 pt-4 border-t border-slate-100 dark:border-slate-800 text-xs">
          <div className="p-3.5 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-100 dark:border-slate-800 space-y-1">
            <span className="text-slate-500 font-medium">{isArabic ? 'رقم الهوية / الإقامة:' : 'National ID / Iqama:'}</span>
            <div className="font-bold text-slate-800 dark:text-slate-200">1082938472</div>
          </div>
          <div className="p-3.5 rounded-2xl bg-slate-50 dark:bg-slate-800/40 border border-slate-100 dark:border-slate-800 space-y-1">
            <span className="text-slate-500 font-medium">{isArabic ? 'رقم الجوال الموثق:' : 'Verified Mobile:'}</span>
            <div className="font-bold text-slate-800 dark:text-slate-200">+966 50 123 4567</div>
          </div>
        </div>
      </div>
    </div>
  );
};
