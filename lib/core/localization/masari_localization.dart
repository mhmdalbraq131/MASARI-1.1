import 'package:flutter/widgets.dart';

/// Lightweight bilingual text helper used by MASARI UI.
/// Arabic is the default language; English is selected from the app locale.
String masariText(BuildContext context, String arabic, String english) {
  return Localizations.localeOf(context).languageCode == 'en' ? english : arabic;
}

String masariLocaleCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}
