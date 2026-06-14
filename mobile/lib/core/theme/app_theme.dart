import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Core Color Palette
  static const Color primaryBlue = Color(0xFF0052CC);
  static const Color primaryBlueDark = Color(0xFF003D9B);
  static const Color primaryBlueLight = Color(0xFFC4D2FF);

  static const Color shariaGreen = Color(0xFF006D37);
  static const Color shariaGreenLight = Color(0xFF6BFE9C);

  static const Color background = Color(0xFFF9F9FF);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF161C27);
  static const Color textLightGray = Color(0xFF737685);
  static const Color textDisabled = Color(0xFFC3C6D6);

  static const Color errorRed = Color(0xFFBA1A1A);
  static const Color warningAmber = Color(0xFF815000);

  // Cupertino Theme
  static final CupertinoThemeData cupertinoTheme = CupertinoThemeData(
    primaryColor: primaryBlue,
    primaryContrastingColor: Colors.white,
    barBackgroundColor: background,
    scaffoldBackgroundColor: background,
    textTheme: CupertinoTextThemeData(
      navTitleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      navLargeTitleTextStyle: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textDark,
        letterSpacing: -0.5,
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textDark,
      ),
      tabLabelTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textLightGray,
      ),
      actionTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryBlue,
      ),
      dateTimePickerTextStyle: GoogleFonts.inter(
        fontSize: 16,
        color: textDark,
      ),
    ),
  );

  // Shared border radius
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusFull = 9999;
}
