export type UserRole = 'guest' | 'user' | 'admin';
export type Language = 'ar' | 'en';
export type ThemeMode = 'dark' | 'light';

export interface RouteItem {
  id: string;
  path: string;
  titleAr: string;
  titleEn: string;
  subtitleAr: string;
  subtitleEn: string;
  icon: string;
  category: 'travel' | 'spiritual' | 'account';
  protectedRole?: UserRole;
  badge?: string;
}
