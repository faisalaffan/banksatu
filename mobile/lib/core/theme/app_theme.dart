import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Curated Harmanious Color Palette
  static const Color primaryBlue = Color(0xFF0052CC); // BankSatu Blue
  static const Color primaryBlueDark = Color(0xFF003D9B);
  static const Color primaryBlueLight = Color(0xFFC4D2FF);

  static const Color shariaGreen = Color(0xFF006D37); // Action Green (Success/Sharia)
  static const Color shariaGreenLight = Color(0xFF6BFE9C);

  static const Color background = Color(0xFFF9F9FF); // Premium Light Canvas
  static const Color surfaceCard = Colors.white;
  static const Color textDark = Color(0xFF161C27); // Dark Charcoal (High contrast readable)
  static const Color textLightGray = Color(0xFF737685);
  static const Color textDisabled = Color(0xFFC3C6D6);

  static const Color errorRed = Color(0xFFBA1A1A);
  static const Color warningAmber = Color(0xFF815000);

  // Soft Shadows
  static List<BoxShadow> get premiumShadow => [
        BoxShadow(
          color: const Color(0xFF0C56D0).withOpacity(0.04),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ];

  static List<BoxShadow> get floatingShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 8),
          blurRadius: 24,
        ),
      ];

  // Core Light ThemeData
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      scaffoldBackgroundColor: background,
      primaryColor: primaryBlue,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: shariaGreen,
        background: background,
        surface: surfaceCard,
        error: errorRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textDark,
        onSurface: textDark,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textDark,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textDark,
          letterSpacing: -0.3,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textDark,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textDark,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textLightGray,
          letterSpacing: 0.1,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE8EEFF), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC3C6D6), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE3E8F9), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        labelStyle: const TextStyle(color: textLightGray, fontSize: 14),
      ),
      buttonTheme: const ButtonThemeData(
        height: 48,
      ),
    );
  }
}
