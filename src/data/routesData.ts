import { RouteItem } from '../types';

export const MASARI_ROUTES: RouteItem[] = [
  // Primary Travel Services
  {
    id: 'home',
    path: '/home',
    titleAr: 'الرئيسية',
    titleEn: 'Home Dashboard',
    subtitleAr: 'لوحة التحكم الرئيسية لمنصة مساري الملكية',
    subtitleEn: 'Main MASARI Royal Dashboard Overview',
    icon: 'LayoutDashboard',
    category: 'travel',
  },
  {
    id: 'flights',
    path: '/flights',
    titleAr: 'رحلات الطيران',
    titleEn: 'Flights',
    subtitleAr: 'حجوزات الطيران المحلي والدولي والخاص',
    subtitleEn: 'Domestic, International & Private Aviation',
    icon: 'Plane',
    category: 'travel',
    badge: 'طيران'
  },
  {
    id: 'hotels',
    path: '/hotels',
    titleAr: 'الفنادق والإقامة',
    titleEn: 'Hotels & Resorts',
    subtitleAr: 'فنادق مكة، المدينة وكافة الوجهات العالمية',
    subtitleEn: 'Makkah, Madinah & Global Luxury Hotels',
    icon: 'Hotel',
    category: 'travel',
    badge: 'فاخر'
  },
  {
    id: 'bus',
    path: '/bus',
    titleAr: 'حجوزات الحافلات',
    titleEn: 'Bus Transport',
    subtitleAr: 'حافلات النقل VIP الجماعي والرحلات الترددية',
    subtitleEn: 'VIP Coach Transport & Shuttle Services',
    icon: 'Bus',
    category: 'travel'
  },
  {
    id: 'cars',
    path: '/cars',
    titleAr: 'تأجير السيارات',
    titleEn: 'Car Rental',
    subtitleAr: 'سيارات فاخرة مع سائق أو بدون',
    subtitleEn: 'Luxury Car Rentals with or without Driver',
    icon: 'Car',
    category: 'travel'
  },
  {
    id: 'transfers',
    path: '/transfers',
    titleAr: 'النقل الخاص',
    titleEn: 'Private Transfers',
    subtitleAr: 'توصيل المطار واستقبال VIP الخاص',
    subtitleEn: 'Airport Chauffeur & VIP Welcoming',
    icon: 'Compass',
    category: 'travel'
  },
  {
    id: 'tourism',
    path: '/tourism',
    titleAr: 'الباقات السياحية',
    titleEn: 'Tourism Packages',
    subtitleAr: 'جولات سياحية وبرامج ترفيهية متكاملة',
    subtitleEn: 'Curated Sightseeing & Leisure Experiences',
    icon: 'Palmtree',
    category: 'travel',
    badge: 'برامج'
  },
  {
    id: 'visa',
    path: '/visa',
    titleAr: 'التأشيرات والفيزا',
    titleEn: 'Visa Services',
    subtitleAr: 'إصدار التأشيرات الإلكترونية والسياحية',
    subtitleEn: 'e-Visa Issuance & Travel Authorization',
    icon: 'FileCheck',
    category: 'travel'
  },

  // Spiritual Services (Hajj & Umrah)
  {
    id: 'hajj',
    path: '/hajj',
    titleAr: 'باقات الحج الملكية',
    titleEn: 'Hajj Packages',
    subtitleAr: 'باقات الحج الشاملة مع مخيمات VIP بالشاعر',
    subtitleEn: 'Comprehensive Hajj Packages & VIP Camps',
    icon: 'Landmark',
    category: 'spiritual',
    badge: 'ملكي'
  },
  {
    id: 'umrah',
    path: '/umrah',
    titleAr: 'خدمات العمرة',
    titleEn: 'Umrah Services',
    subtitleAr: 'برامج العمرة المخصصة والأثر التاريخي',
    subtitleEn: 'Tailored Umrah Packages & Historical Visits',
    icon: 'Moon',
    category: 'spiritual',
    badge: 'روحاني'
  },

  // Management & Account
  {
    id: 'wallet',
    path: '/wallet',
    titleAr: 'محفظة مساري',
    titleEn: 'Masari Wallet',
    subtitleAr: 'المحفظة الرقمية، النقاط والرصيد الاستثماري',
    subtitleEn: 'Digital Wallet, Loyalty Points & Balance',
    icon: 'Wallet',
    category: 'account',
    protectedRole: 'user'
  },
  {
    id: 'bookings',
    path: '/bookings',
    titleAr: 'سجل الحجوزات',
    titleEn: 'My Bookings',
    subtitleAr: 'إدارة وتتبع كافة الحجوزات النشطة والسابقة',
    subtitleEn: 'Active and Historical Booking Records',
    icon: 'Ticket',
    category: 'account',
    protectedRole: 'user'
  },
  {
    id: 'travelers',
    path: '/travelers',
    titleAr: 'إدارة المسافرين',
    titleEn: 'Travelers Directory',
    subtitleAr: 'قائمة المسافرين المحفوظين والوثائق الرسمية',
    subtitleEn: 'Saved Traveler Profiles & Documents',
    icon: 'Users',
    category: 'account',
    protectedRole: 'user'
  },
  {
    id: 'passports',
    path: '/passports',
    titleAr: 'مركز الجوازات',
    titleEn: 'Passports Center',
    subtitleAr: 'تشفير وحفظ وتحديث جوازات السفر',
    subtitleEn: 'Secure Encryption & Passport Storage',
    icon: 'Shield',
    category: 'account',
    protectedRole: 'user'
  },
  {
    id: 'ai',
    path: '/ai',
    titleAr: 'مساعد AI الذكي',
    titleEn: 'AI Travel Assistant',
    subtitleAr: 'استشارات وتخطيط الرحلات بالذكاء الاصطناعي',
    subtitleEn: 'AI-Powered Itinerary & Trip Consulting',
    icon: 'Sparkles',
    category: 'account',
    badge: 'AI'
  },
  {
    id: 'profile',
    path: '/profile',
    titleAr: 'الملف الشخصي',
    titleEn: 'User Profile',
    subtitleAr: 'بيانات الحساب وتفضيلات العضوية الملكية',
    subtitleEn: 'Personal Profile & Loyalty Status',
    icon: 'User',
    category: 'account',
    protectedRole: 'user'
  },
  {
    id: 'settings',
    path: '/settings',
    titleAr: 'الإعدادات واللغات',
    titleEn: 'Settings & Locale',
    subtitleAr: 'تفضيلات النظام، التنبيهات والأمان',
    subtitleEn: 'System Preferences & Notifications',
    icon: 'Settings',
    category: 'account'
  },
  {
    id: 'admin',
    path: '/admin',
    titleAr: 'بوابة الإدارة العليا',
    titleEn: 'Admin Portal',
    subtitleAr: 'لوحة تحكم المشرفين وإدارة الخدمات',
    subtitleEn: 'System Control Center & Service Ops',
    icon: 'ShieldAlert',
    category: 'account',
    protectedRole: 'admin',
    badge: 'Admin'
  }
];
