import 'package:flutter/material.dart';

/// RTL / LTR Directionality Helper Utilities
class RtlUtils {
  static bool isRtl(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  static TextDirection getTextDirection(String languageCode) {
    return languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }

  static Alignment getStartAlignment(BuildContext context) {
    return isRtl(context) ? Alignment.centerRight : Alignment.centerLeft;
  }

  static Alignment getEndAlignment(BuildContext context) {
    return isRtl(context) ? Alignment.centerLeft : Alignment.centerRight;
  }
}
