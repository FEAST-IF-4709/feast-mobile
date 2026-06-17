import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color tokens mirroring the FEAST web frontend's feast-* Tailwind palette.
/// Salvaged from lib/core/app_colors.dart — values are unchanged.
abstract final class FeastColors {
  static const Color primary = Color(0xFFDD7A00);
  static const Color background = Color(0xFFFFF8F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFFBBBBBB);
  static const Color textSubtitle = Color(0xFFEDC9A6);
  static const Color error = Color(0xFFB00020);
  static const Color divider = Color(0xFFF1DDD1);
}

/// Single source of truth for the app's ThemeData.
/// Apply via MaterialApp.theme / MaterialApp.router's theme parameter.
abstract final class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.light(
      primary: FeastColors.primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFFE07B00),
      onSecondary: Colors.white,
      surface: FeastColors.surface,
      onSurface: FeastColors.textDark,
      error: FeastColors.error,
      onError: Colors.white,
    );

    final base = ThemeData.light(useMaterial3: true);

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.inter(
        color: FeastColors.textDark,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.inter(
        color: FeastColors.textDark,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.inter(
        color: FeastColors.textDark,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        color: FeastColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.inter(
        color: FeastColors.textDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(color: FeastColors.textDark, fontSize: 16),
      bodyMedium: GoogleFonts.inter(color: FeastColors.textDark, fontSize: 14),
      bodySmall: GoogleFonts.inter(color: FeastColors.textLight, fontSize: 12),
      labelLarge: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: FeastColors.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: FeastColors.surface,
        foregroundColor: FeastColors.textDark,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: FeastColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FeastColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: FeastColors.primary,
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: FeastColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: FeastColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FeastColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FeastColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FeastColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: FeastColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: FeastColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: FeastColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: FeastColors.divider,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
