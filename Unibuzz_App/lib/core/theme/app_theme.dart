import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.background,
        onSurface: AppColors.white,
        tertiary: AppColors.neonCyan,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.racingSansOne(
          color: AppColors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        displayMedium: GoogleFonts.racingSansOne(
          color: AppColors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        displaySmall: GoogleFonts.racingSansOne(
          color: AppColors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
        headlineLarge: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: AppColors.textSecondary,
          fontSize: 14,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.poppins(
          color: AppColors.textTertiary,
          fontSize: 12,
          height: 1.3,
        ),
        labelLarge: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
        labelSmall: GoogleFonts.poppins(
          color: AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        contentTextStyle: GoogleFonts.poppins(color: AppColors.white, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      useMaterial3: true,
    );
  }
}
