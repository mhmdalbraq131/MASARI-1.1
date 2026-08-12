import 'package:intl/intl.dart';

/// Formatting Utilities for MASARI Platform (Currency, Date, Numbers)
class MasariFormatters {
  static String formatCurrency(double amount, {String currencyCode = 'SAR', String locale = 'ar'}) {
    final formatter = NumberFormat.currency(
      symbol: currencyCode == 'SAR' ? (locale == 'ar' ? 'ر.س' : 'SAR') : currencyCode,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String formatDate(DateTime date, {String locale = 'ar', String format = 'dd MMM yyyy'}) {
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }
}
