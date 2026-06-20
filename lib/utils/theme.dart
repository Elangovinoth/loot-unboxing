import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Base
  static const background = Color(0xFF0A0F1E);
  static const surface = Color(0xFF131929);
  static const surfaceElevated = Color(0xFF1C2640);
  static const border = Color(0xFF252F47);

  // Accent
  static const teal = Color(0xFF00D4AA);
  static const tealDim = Color(0x1A00D4AA);
  static const tealMid = Color(0x5500D4AA);
  static const amber = Color(0xFFFFB627);
  static const amberDim = Color(0x1AFFB627);
  static const red = Color(0xFFFF4757);
  static const redDim = Color(0x1AFF4757);
  static const green = Color(0xFF2ED573);
  static const greenDim = Color(0x1A2ED573);
  static const purple = Color(0xFFA78BFA);
  static const purpleDim = Color(0x1AA78BFA);

  // Text
  static const textPrimary = Color(0xFFF0F4FF);
  static const textSecondary = Color(0xFF8896B3);
  static const textMuted = Color(0xFF4A5578);
  static const textInverse = Color(0xFF0A0F1E);

  // Platforms
  static const amazon = Color(0xFFFF9900);
  static const flipkart = Color(0xFF2874F0);
  static const meesho = Color(0xFFF43397);
  static const snapdeal = Color(0xFFE40000);
  static const myntra = Color(0xFFFF3F6C);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.teal,
          surface: AppColors.surface,
          background: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: AppColors.textMuted,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.teal),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.teal,
          unselectedItemColor: AppColors.textMuted,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.teal, width: 1.5),
          ),
          hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        dividerColor: AppColors.border,
      );
}
