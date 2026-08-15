export interface TourPackage {
  id: string;
  category: 'daily' | 'history' | 'family' | 'custom' | 'all';
  titleAr: string;
  titleEn: string;
  locationAr: string;
  locationEn: string;
  durationAr: string;
  durationEn: string;
  travelersAr: string;
  travelersEn: string;
  price: number;
  currencyAr: string;
  currencyEn: string;
  rating: number;
  reviewsCount: number;
  image: string;
  descriptionAr: string;
  descriptionEn: string;
  highlightsAr: string[];
  highlightsEn: string[];
  featured?: boolean;
}

export interface FlightItem {
  id: string;
  airlineAr: string;
  airlineEn: string;
  flightNumber: string;
  fromCode: string;
  fromCityAr: string;
  fromCityEn: string;
  toCode: string;
  toCityAr: string;
  toCityEn: string;
  departureTime: string;
  arrivalTime: string;
  durationAr: string;
  durationEn: string;
  stopsAr: string;
  stopsEn: string;
  cabinClassAr: string;
  cabinClassEn: string;
  price: number;
  baggage: string;
}

export interface HotelItem {
  id: string;
  nameAr: string;
  nameEn: string;
  cityAr: string;
  cityEn: string;
  distanceToHaramAr?: string;
  distanceToHaramEn?: string;
  stars: number;
  rating: number;
  reviewsCount: number;
  pricePerNight: number;
  image: string;
  amenitiesAr: string[];
  amenitiesEn: string[];
  tagAr: string;
  tagEn: string;
}

export interface HajjUmrahPackage {
  id: string;
  type: 'hajj' | 'umrah';
  titleAr: string;
  titleEn: string;
  hotelMakkahAr: string;
  hotelMakkahEn: string;
  hotelMadinahAr: string;
  hotelMadinahEn: string;
  durationDays: number;
  campTypeAr?: string;
  campTypeEn?: string;
  price: number;
  badgeAr: string;
  badgeEn: string;
  image: string;
  inclusionsAr: string[];
  inclusionsEn: string[];
}

export interface VehicleItem {
  id: string;
  type: 'cars' | 'bus' | 'transfers';
  nameAr: string;
  nameEn: string;
  modelAr: string;
  modelEn: string;
  passengers: number;
  luggage: number;
  pricePerDay: number;
  image: string;
  featuresAr: string[];
  featuresEn: string[];
}

export interface VisaType {
  id: string;
  titleAr: string;
  titleEn: string;
  validityAr: string;
  validityEn: string;
  stayDurationAr: string;
  stayDurationEn: string;
  processingTimeAr: string;
  processingTimeEn: string;
  fee: number;
  requirementsAr: string[];
  requirementsEn: string[];
}

// Tourism Packages Data
export const TOURISM_PACKAGES: TourPackage[] = [
  {
    id: 'tour-1',
    category: 'history',
    titleAr: 'رحلة استكشاف العلا ومدائن صالح الفاخرة',
    titleEn: 'Luxury AlUla & Hegra Heritage Expedition',
    locationAr: 'العلا، المملكة العربية السعودية',
    locationEn: 'AlUla, Saudi Arabia',
    durationAr: '3 أيام / ليلتان',
    durationEn: '3 Days / 2 Nights',
    travelersAr: '2 - 6 مسافرين',
    travelersEn: '2 - 6 Travelers',
    price: 3850,
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    rating: 4.9,
    reviewsCount: 142,
    image: 'https://images.unsplash.com/photo-1578895101407-74223b2c37e1?auto=format&fit=crop&w=800&q=80',
    descriptionAr: 'جولة ملكية خاصة لاستكشاف روائع العلا التاريخية، جبل الفيل، مسرح مرايا وقضاء ليلة ساحرة تحت النجوم في منتجع صحراوي فاخر.',
    descriptionEn: 'Exclusive royal tour exploring the archaeological wonders of Hegra, Elephant Rock, Maraya Hall with a luxury desert resort stay.',
    highlightsAr: ['مرشد سياحي خاص مرخص', 'إقامة في منتجع 5 نجوم', 'تنقلات بسيارة دفع رباعي VIP', 'شامل جميع وجبات الطعام الفاخرة'],
    highlightsEn: ['Private Licensed Guide', '5-Star Luxury Resort Stay', 'VIP 4WD Chauffeur', 'Gourmet Full Board Dining'],
    featured: true,
  },
  {
    id: 'tour-2',
    category: 'daily',
    titleAr: 'جولة معالم الرياض التاريخية والحديثة',
    titleEn: 'Riyadh Historical & Modern Highlights Tour',
    locationAr: 'الرياض، المملكة العربية السعودية',
    locationEn: 'Riyadh, Saudi Arabia',
    durationAr: 'يوم كامل (8 ساعات)',
    durationEn: 'Full Day (8 Hours)',
    travelersAr: '1 - 10 مسافرين',
    travelersEn: '1 - 10 Travelers',
    price: 650,
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    rating: 4.8,
    reviewsCount: 215,
    image: 'https://images.unsplash.com/photo-1586724237569-f3d0c1dee8c6?auto=format&fit=crop&w=800&q=80',
    descriptionAr: 'استمتع بجولة شاملة تغطي قصر المصمك التاريخي، حي الطريف بالدرعية، برج المملكة وجولة تسوق في أسواق الرياض التراثية.',
    descriptionEn: 'Experience historical Al Masmak Fortress, UNESCO At-Turaif in Diriyah, Kingdom Centre Sky Bridge, and traditional Souqs.',
    highlightsAr: ['تذاكر دخول المواقع التاريخية', 'وجبة غداء نجدية تقليدية', 'سيارة مرسيدس حديثة ومكيفة', 'مشروبات وضيافة سعودية أصيلة'],
    highlightsEn: ['Historical Site Entry Tickets', 'Traditional Najdi Lunch', 'Modern AC Mercedes Transport', 'Authentic Saudi Hospitality'],
  },
  {
    id: 'tour-3',
    category: 'family',
    titleAr: 'رحلة مرتفعات السودة وجبال عسير العائلية',
    titleEn: 'Abha & Asir Highlands Family Escape',
    locationAr: 'أبها وعسير، المملكة العربية السعودية',
    locationEn: 'Abha & Asir, Saudi Arabia',
    durationAr: '4 أيام / 3 ليالٍ',
    durationEn: '4 Days / 3 Nights',
    travelersAr: 'عائلات ومجموعات',
    travelersEn: 'Families & Groups',
    price: 4200,
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    rating: 4.9,
    reviewsCount: 88,
    image: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80',
    descriptionAr: 'أجواء ضبابية وطبيعة جبلية ساحرة تشمل قرية رجال ألمع التراثية، تلفريك السودة، وزيارة مزارع البن والورد العسيري.',
    descriptionEn: 'Breathtaking misty mountains, Rijal Almaa heritage village, Al Souda cable cars, and authentic coffee farm visits.',
    highlightsAr: ['تلفريك السودة وقرية رجال ألمع', 'فيلا فندقية عائلية فاخرة', 'أنشطة ترفيهية للأطفال', 'زيارة الأسواق الشعبية'],
    highlightsEn: ['Cable Car & Rijal Almaa Access', 'Luxury Family Villa Accommodation', 'Children Activities & Games', 'Local Souq Shopping Tour'],
  },
  {
    id: 'tour-4',
    category: 'history',
    titleAr: 'جولة جدة التاريخية (البلد) وسواحل البحر الأحمر',
    titleEn: 'Historic Jeddah Al-Balad & Red Sea Yacht Tour',
    locationAr: 'جدة، المملكة العربية السعودية',
    locationEn: 'Jeddah, Saudi Arabia',
    durationAr: 'يومان / ليلة واحدة',
    durationEn: '2 Days / 1 Night',
    travelersAr: '2 - 8 مسافرين',
    travelersEn: '2 - 8 Travelers',
    price: 1950,
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    rating: 4.85,
    reviewsCount: 164,
    image: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=800&q=80',
    descriptionAr: 'اكتشف عبق التاريخ الحجازي في مباني جدة التراثية مع رحلة يخت خاصة على مياه البحر الأحمر عند الغروب.',
    descriptionEn: 'Discover authentic Hejazi architecture in UNESCO Al-Balad coupled with a private luxury sunset yacht cruise.',
    highlightsAr: ['رحلة يخت بحري خاصة ساعتان', 'مرشد تاريخي متخصص', 'تجربة المأكولات البحرية الفاخرة', 'استقبال وتوديع بالمطار'],
    highlightsEn: ['2-Hour Private Yacht Cruise', 'Expert Heritage Tour Guide', 'Fine Seafood Dining Experience', 'VIP Airport Chauffeur'],
  },
  {
    id: 'tour-5',
    category: 'custom',
    titleAr: 'سفاري وادي الديسة وتخييم تبوك الفاخر',
    titleEn: 'Wadi Al-Disah Safari & Tabuk Luxury Glamping',
    locationAr: 'تبوك، المملكة العربية السعودية',
    locationEn: 'Tabuk, Saudi Arabia',
    durationAr: '3 أيام / ليلتان',
    durationEn: '3 Days / 2 Nights',
    travelersAr: 'برنامج مخصص حسب الطلب',
    travelersEn: 'Custom Tailored Group',
    price: 5400,
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    rating: 5.0,
    reviewsCount: 52,
    image: 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?auto=format&fit=crop&w=800&q=80',
    descriptionAr: 'برنامج استكشافي مخصص بين العيون الجارية وأشجار النخيل وسط جبال الديسة الشاهقة مع إقامة فندقية برية بتجهيزات VIP.',
    descriptionEn: 'Custom expedition through the lush canyon of Wadi Al-Disah with 5-star desert dome glamping and private astronomy sessions.',
    highlightsAr: ['خيام قبة فندقية مكيفة فاخرة', 'رحلات مشي واستكشاف مع خبراء', 'تلسكوب فلكي لرصد النجوم', 'طاهٍ خاص للوجبات'],
    highlightsEn: ['Luxury AC Geodesic Domes', 'Expert-Led Canyon Trekking', 'Deep Sky Stargazing Telescopes', 'Private Gourmet Chef'],
  }
];

// Flights Data
export const FLIGHTS_LIST: FlightItem[] = [
  {
    id: 'fl-101',
    airlineAr: 'الخطوط السعودية',
    airlineEn: 'Saudia Airlines',
    flightNumber: 'SV-1024',
    fromCode: 'RUH',
    fromCityAr: 'الرياض (RUH)',
    fromCityEn: 'Riyadh (RUH)',
    toCode: 'JED',
    toCityAr: 'جدة (JED)',
    toCityEn: 'Jeddah (JED)',
    departureTime: '08:30 ص',
    arrivalTime: '10:15 ص',
    durationAr: '1س 45د',
    durationEn: '1h 45m',
    stopsAr: 'مباشرة',
    stopsEn: 'Direct',
    cabinClassAr: 'درجة الأعمال VIP',
    cabinClassEn: 'Business Class',
    price: 1150,
    baggage: '2 x 32 كجم',
  },
  {
    id: 'fl-102',
    airlineAr: 'طيران ناس',
    airlineEn: 'Flynas',
    flightNumber: 'XY-220',
    fromCode: 'DMM',
    fromCityAr: 'الدمام (DMM)',
    fromCityEn: 'Dammam (DMM)',
    toCode: 'MED',
    toCityAr: 'المدينة المنورة (MED)',
    toCityEn: 'Madinah (MED)',
    departureTime: '11:00 ص',
    arrivalTime: '01:10 م',
    durationAr: '2س 10د',
    durationEn: '2h 10m',
    stopsAr: 'مباشرة',
    stopsEn: 'Direct',
    cabinClassAr: 'الدرجة الاقتصادية الممتازة',
    cabinClassEn: 'Premium Economy',
    price: 580,
    baggage: '1 x 20 كجم',
  },
  {
    id: 'fl-103',
    airlineAr: 'الخطوط السعودية',
    airlineEn: 'Saudia Airlines',
    flightNumber: 'SV-340',
    fromCode: 'JED',
    fromCityAr: 'جدة (JED)',
    fromCityEn: 'Jeddah (JED)',
    toCode: 'DXB',
    toCityAr: 'دبي (DXB)',
    toCityEn: 'Dubai (DXB)',
    departureTime: '03:45 م',
    arrivalTime: '07:30 م',
    durationAr: '2س 45د',
    durationEn: '2h 45m',
    stopsAr: 'مباشرة',
    stopsEn: 'Direct',
    cabinClassAr: 'الدرجة الأولى الملكية',
    cabinClassEn: 'First Class',
    price: 2850,
    baggage: '3 x 32 كجم',
  },
  {
    id: 'fl-104',
    airlineAr: 'طيران الرياض',
    airlineEn: 'Riyadh Air',
    flightNumber: 'RX-701',
    fromCode: 'RUH',
    fromCityAr: 'الرياض (RUH)',
    fromCityEn: 'Riyadh (RUH)',
    toCode: 'LHR',
    toCityAr: 'لندن هيثرو (LHR)',
    toCityEn: 'London Heathrow (LHR)',
    departureTime: '01:15 ص',
    arrivalTime: '06:30 ص',
    durationAr: '7س 15د',
    durationEn: '7h 15m',
    stopsAr: 'مباشرة',
    stopsEn: 'Direct',
    cabinClassAr: 'جناح مساري VIP',
    cabinClassEn: 'Masari Private Suite',
    price: 8400,
    baggage: '3 x 32 كجم',
  }
];

// Hotels Data
export const HOTELS_LIST: HotelItem[] = [
  {
    id: 'ht-01',
    nameAr: 'فندق قصر مكة رافلز (Raffles Makkah Palace)',
    nameEn: 'Raffles Makkah Palace',
    cityAr: 'مكة المكرمة',
    cityEn: 'Makkah',
    distanceToHaramAr: 'مطل مباشرة على الحرم والكعبة',
    distanceToHaramEn: 'Direct Haram & Kaaba Panoramic View',
    stars: 5,
    rating: 4.95,
    reviewsCount: 1840,
    pricePerNight: 2450,
    image: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80',
    amenitiesAr: ['إطلالة كعبة مباشرة', 'خدمة المساعد الشخصي (Butler)', 'سبا فاخر', 'مطاعم راقية عالمية'],
    amenitiesEn: ['Direct Kaaba View', '24/7 Private Butler', 'Luxury Wellness Spa', 'Fine Dining Restaurants'],
    tagAr: 'الأعلى طلباً',
    tagEn: 'Top Choice',
  },
  {
    id: 'ht-02',
    nameAr: 'فندق دار التقوى المدينة المنورة',
    nameEn: 'Dar Al Taqwa Hotel Madinah',
    cityAr: 'المدينة المنورة',
    cityEn: 'Madinah',
    distanceToHaramAr: 'خطوات من باب الملك فهد بالمسجد النبوي',
    distanceToHaramEn: 'Steps from King Fahd Gate, Prophet Mosque',
    stars: 5,
    rating: 4.9,
    reviewsCount: 960,
    pricePerNight: 1650,
    image: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80',
    amenitiesAr: ['إطلالة الحرم النبوي', 'إفطار مجاني فاخر', 'خدمة استقبال VIP', 'مواقف خاصة مجانية'],
    amenitiesEn: ['Prophet Mosque View', 'Gourmet Breakfast Included', 'VIP Valet Service', 'Complimentary Parking'],
    tagAr: 'راحة روحانية',
    tagEn: 'Spiritual Serenity',
  },
  {
    id: 'ht-03',
    nameAr: 'منتجع بانيان تري العلا (Banyan Tree AlUla)',
    nameEn: 'Banyan Tree AlUla Resort',
    cityAr: 'العلا',
    cityEn: 'AlUla',
    stars: 5,
    rating: 4.98,
    reviewsCount: 420,
    pricePerNight: 4100,
    image: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80',
    amenitiesAr: ['فلل بمسبح خاص', 'موقع وسط وادي عشار', 'جلسات استجمام وعلاج طبيعي', 'أنشطة فلكية'],
    amenitiesEn: ['Private Pool Villas', 'Ashar Valley Setting', 'Sanctuary Spa Treatments', 'Stargazing Decks'],
    tagAr: 'فخامة استثنائية',
    tagEn: 'Ultra Luxury',
  },
  {
    id: 'ht-04',
    nameAr: 'فندق الفورسيزونز الرياض (Four Seasons Riyadh)',
    nameEn: 'Four Seasons Hotel Riyadh',
    cityAr: 'الرياض',
    cityEn: 'Riyadh',
    stars: 5,
    rating: 4.88,
    reviewsCount: 1250,
    pricePerNight: 2100,
    image: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=80',
    amenitiesAr: ['برج المملكة', 'إطلالة بانورامية للمدينة', 'مركز لياقة وسبا للرجال والسيدات', 'خدمة رجال الأعمال'],
    amenitiesEn: ['Kingdom Tower Iconic Location', 'Panoramic City Views', 'Luxury Spa & Health Club', 'Executive Business Lounge'],
    tagAr: 'رجال الأعمال',
    tagEn: 'Business Elite',
  }
];

// Hajj and Umrah Packages Data
export const HAJJ_UMRAH_PACKAGES: HajjUmrahPackage[] = [
  {
    id: 'hajj-vip-1',
    type: 'hajj',
    titleAr: 'باقة الصفوة الملكية لحج بيت الله الحرام',
    titleEn: 'Al-Safwah Royal VIP Hajj Package',
    hotelMakkahAr: 'فندق برج الساعة فيرمونت (أجنحة ملكية)',
    hotelMakkahEn: 'Makkah Clock Royal Tower, Fairmont Suites',
    hotelMadinahAr: 'فندق الأوبروي المدينة المنورة',
    hotelMadinahEn: 'The Oberoi Madinah Luxury Suites',
    durationDays: 14,
    campTypeAr: 'مخيمات مساري VIP المطورة بمشعر منى وعرفات',
    campTypeEn: 'MASARI Platinum AC VIP Camps in Mina & Arafat',
    price: 34500,
    badgeAr: 'الباقة الملكية الأولى',
    badgeEn: 'Royal Tier 1',
    image: 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?auto=format&fit=crop&w=800&q=80',
    inclusionsAr: [
      'تنقلات خاصة عبر قطار الحرمين السريع ومرسيدس VIP',
      'إعاشة بوفيه مفتوح مع طهاة دوليين على مدار الساعة',
      'كادر إرشادي وطبي خاص مرافق على مدار الساعة',
      'توفير كافة مستلزمات الإحرام والضيافة المجهزة',
    ],
    inclusionsEn: [
      'Haramain High Speed Train & VIP Mercedes Fleet',
      '24/7 International Gourmet Buffet by Master Chefs',
      'Dedicated Religious Scholars & Medical Escort Team',
      'Full Ihram & Premium Pilgrimage Amenity Kit',
    ],
  },
  {
    id: 'umrah-vip-1',
    type: 'umrah',
    titleAr: 'باقة عمرة النخبة والزيارة الروحانية',
    titleEn: 'Elite Umrah & Spiritual Sanctuary Package',
    hotelMakkahAr: 'فندق جبل عمر كونراد (إطلالة كعبة)',
    hotelMakkahEn: 'Conrad Makkah, Kaaba View Suite',
    hotelMadinahAr: 'فندق دار الإيمان إنتركونتيننتال',
    hotelMadinahEn: 'Dar Al Iman InterContinental Madinah',
    durationDays: 7,
    price: 7800,
    badgeAr: 'شامل التأشيرة والتنقل',
    badgeEn: 'Visa & Chauffeur Included',
    image: 'https://images.unsplash.com/photo-1564769625905-50e93615e769?auto=format&fit=crop&w=800&q=80',
    inclusionsAr: [
      'إصدار تأشيرة العمرة الإلكترونية الفورية',
      'استقبال وتوديع بمطار الملك عبد العزيز صالة الفرسان',
      'قطار الحرمين درجة أولى بين مكة والمدينة',
      'جولة مزارات تاريخية خاصة (غار حراء، مسجد قباء، أحد)',
    ],
    inclusionsEn: [
      'Instant e-Umrah Visa Issuance & Authorization',
      'VIP Airport Meet & Assist at Alfursan Lounge',
      'First Class Haramain High Speed Rail Tickets',
      'Private Historical Ziyarah (Ghar Hira, Quba, Uhud)',
    ],
  },
  {
    id: 'umrah-ramadan',
    type: 'umrah',
    titleAr: 'باقة العشر الأواخر من شهر رمضان المبارك',
    titleEn: 'Last Ten Nights of Ramadan Blessings Package',
    hotelMakkahAr: 'فندق سويس أوتيل المقام مكة',
    hotelMakkahEn: 'Swissôtel Al Maqam Makkah',
    hotelMadinahAr: 'فندق كراون بلازا المدينة',
    hotelMadinahEn: 'Crowne Plaza Madinah',
    durationDays: 12,
    price: 18900,
    badgeAr: 'روحانية العشر الأواخر',
    badgeEn: 'Ramadan Special',
    image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=800&q=80',
    inclusionsAr: [
      'إفطار وسحور رمضاني يومي فاخر',
      'موقع ملاصق لساحات الحرم المكي',
      'حضور ختم القرآن الكريم ليلة 29 وصلاة العيد',
      'تنظيم تصاريح نسك للعمرة والصلاة في الروضة الشريفة',
    ],
    inclusionsEn: [
      'Daily Gourmet Iftar & Suhoor Buffet',
      'Direct Access to Holy Haram Courtyards',
      '29th Night Khatm Al-Quran & Eid Prayers',
      'Nusuk Permit Assistance for Umrah & Rawdah',
    ],
  }
];

// Transportation Fleet Data
export const VEHICLES_LIST: VehicleItem[] = [
  {
    id: 'vh-1',
    type: 'cars',
    nameAr: 'مرسيدس مايباخ S-Class VIP',
    nameEn: 'Mercedes-Maybach S-Class VIP',
    modelAr: 'موديل 2025 مع سائق خاص يتحدث لغات متعددة',
    modelEn: '2025 Model with Multilingual Chauffeur',
    passengers: 3,
    luggage: 3,
    pricePerDay: 2200,
    image: 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=800&q=80',
    featuresAr: ['مقاعد تدليك خلفية متكئة', 'واي فاي وثلاجة مشروبات مجانية', 'شاشات ترفيه خاصة', 'خدمة استقبال المطارات'],
    featuresEn: ['Executive Reclining Massage Seats', 'Complimentary WiFi & Cold Refreshments', 'Dual Rear Entertainment Screens', 'VIP Airport Meet & Greet'],
  },
  {
    id: 'vh-2',
    type: 'cars',
    nameAr: 'جي إم سي يوكون دينالي XL',
    nameEn: 'GMC Yukon Denali XL VIP',
    modelAr: 'موديل 2025 عائلي فاخر وفخم',
    modelEn: '2025 Luxury Family SUV',
    passengers: 7,
    luggage: 6,
    pricePerDay: 1400,
    image: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=800&q=80',
    featuresAr: ['مساحة أمتعة عملاقة', 'تكييف مركزي متطور', 'أنظمة أمان وراحة قصوى', 'مثالية للعائلات وحقائب الحج والعمرة'],
    featuresEn: ['Massive Luggage Capacity', 'Tri-Zone Climate Control', 'Advanced Safety Features', 'Ideal for Families & Pilgrims'],
  },
  {
    id: 'vh-3',
    type: 'bus',
    nameAr: 'حافلة مساري الملكية مرسيدس ترافيكو VIP',
    nameEn: 'MASARI Royal Mercedes Tourismo VIP Coach',
    modelAr: 'حافلة سياحية درجة رجال أعمال (30 مقعداً فاخراً)',
    modelEn: 'Business Class 30-Seat Luxury Touring Coach',
    passengers: 30,
    luggage: 40,
    pricePerDay: 3500,
    image: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?auto=format&fit=crop&w=800&q=80',
    featuresAr: ['مقاعد جلدية متباعدة ومريحة جداً', 'دورات مياه مجهزة على متن الحافلة', 'شواحن هواتف وشبكة إنترنت 5G', 'ضيافة ومشروبات'],
    featuresEn: ['Extra-Wide Leather Recliner Seats', 'On-Board Restroom Facility', 'Individual USB Chargers & 5G WiFi', 'Hot & Cold Refreshment Bar'],
  },
  {
    id: 'vh-4',
    type: 'transfers',
    nameAr: 'خدمة التوصيل السريع من وإلى مطار جدة / المدينة',
    nameEn: 'VIP Airport Express Chauffeur Transfer',
    modelAr: 'سيارات كاديلاك اسكاليد أو مرسيدس V-Class',
    modelEn: 'Cadillac Escalade or Mercedes V-Class',
    passengers: 5,
    luggage: 5,
    pricePerDay: 450,
    image: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=800&q=80',
    featuresAr: ['تتبع موعد الرحلة الجوية آلياً', 'انتظار مجاني لمدة 60 دقيقة في المطار', 'مساعدة كاملة في تحميل وتنزيل الحقائب', 'توصيل مباشر للفندق'],
    featuresEn: ['Real-time Flight Tracking', '60-Minute Free Airport Wait Time', 'Full Luggage Handling Assistance', 'Direct Doorstep Hotel Drop-off'],
  }
];

// Visa Services Data
export const VISA_TYPES: VisaType[] = [
  {
    id: 'visa-tourist',
    titleAr: 'التأشيرة السياحية الإلكترونية (e-Visa)',
    titleEn: 'Saudi Tourist e-Visa',
    validityAr: 'سنة كاملة (دخول متعدد)',
    validityEn: '1 Year (Multiple Entry)',
    stayDurationAr: 'إقامة تصل إلى 90 يوماً',
    stayDurationEn: 'Up to 90 Days stay per visit',
    processingTimeAr: 'إصدار فوري (خلال دقائق - 24 ساعة)',
    processingTimeEn: 'Instant (Minutes to 24 Hours)',
    fee: 480,
    requirementsAr: ['جواز سفر ساري لأكثر من 6 أشهر', 'صورة شخصية رقمية بخلفية بيضاء', 'تأمين طبي معتمد (مشمول)'],
    requirementsEn: ['Passport valid for 6+ months', 'Digital photo with white background', 'Approved Medical Insurance (Included)'],
  },
  {
    id: 'visa-umrah',
    titleAr: 'تأشيرة العمرة المباشرة وتصاريح نسك',
    titleEn: 'Direct Umrah Visa & Nusuk Integration',
    validityAr: '90 يوماً من تاريخ الإصدار',
    validityEn: '90 Days from issuance date',
    stayDurationAr: 'إقامة كاملة لأداء المناسك والتنقل بين المدن',
    stayDurationEn: 'Full duration for rituals & travel in KSA',
    processingTimeAr: '24 - 48 ساعة',
    processingTimeEn: '24 - 48 Hours',
    fee: 650,
    requirementsAr: ['جواز سفر معتمد', 'تأكيد حجز السكن والانتقالات', 'إصدار تصاريح الروضة والعمرة عبر نسك'],
    requirementsEn: ['Valid Official Passport', 'Confirmed Accommodation & Transport', 'Direct Nusuk App Permits Linking'],
  },
  {
    id: 'visa-transit',
    titleAr: 'تأشيرة المرور (الترانزيت) المجانية مع التذكرة',
    titleEn: 'Stopover / Transit e-Visa',
    validityAr: '96 ساعة (4 أيام)',
    validityEn: '96 Hours (4 Days)',
    stayDurationAr: 'أداء عمرة سريعة أو جولة سياحية',
    stayDurationEn: 'Quick Umrah or Tourism City Tour',
    processingTimeAr: 'إصدار فوري مع تذكرة الطيران',
    processingTimeEn: 'Instant upon flight booking',
    fee: 100,
    requirementsAr: ['تذكرة سفر مؤكدة عبر الخطوط السعودية أو ناس', 'صلاحية الجواز 6 أشهر على الأقل'],
    requirementsEn: ['Confirmed flight with Saudia or Flynas', 'Passport validity of at least 6 months'],
  }
];
