import 'package:flutter/material.dart';

class AppColors {
  // Primary Swatch (500 = #8142FF)
  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
        50: Color(0xFFF5F2FF),
        100: Color(0xFFEDE8FF),
        200: Color(0xFFDCD4FF),
        300: Color(0xFFC4B1FF),
        400: Color(0xFFA785FF),
        500: Color(_primaryPrimaryValue),
        600: Color(0xFF7F30F7),
        700: Color(0xFF711EE3),
        800: Color(0xFF5E18BF),
        900: Color(0xFF4E169C),
        950: Color(0xFF300B6A),
      });
  static const int _primaryPrimaryValue = 0xFF8142FF;

  // Secondary Swatch (500 = #EA4AB7)
  static const MaterialColor secondary =
      MaterialColor(_secondaryPrimaryValue, <int, Color>{
        50: Color(0xFFFDF2FA),
        100: Color(0xFFFCE7F7),
        200: Color(0xFFFDD1E8),
        300: Color(0xFFF8A9E3),
        400: Color(0xFFF26BCB),
        500: Color(_secondaryPrimaryValue),
        600: Color(0xFFD92998),
        700: Color(0xFFBC1A7B),
        800: Color(0xFF9C1866),
        900: Color(0xFF821957),
        950: Color(0xFF4F0831),
      });
  static const int _secondaryPrimaryValue = 0xFFEA4AB7;

  // Semánticos
  static const Color error = Color(0xFFEF4444); // 500
  static const Color warning = Color(0xFFF59E0B); // 500
  static const Color success = Color(0xFF22C55E); // 500
  static const Color info = Color(0xFF4B4EFC); // 500
  static const Color background = Color(0xFF15082F);

  // Neutrales
  static const Color neutral50 = Color(0xFFF6F6F6);
  static const Color neutral100 = Color(0xFFE7E7E7);
  static const Color neutral200 = Color(0xFFD1D1D1);
  static const Color neutral300 = Color(0xFFB0B0B0);
  static const Color neutral400 = Color(0xFF888888);
  static const Color neutral500 = Color(0xFF6D6D6D);
  static const Color neutral600 = Color(0xFF5D5D5D);
  static const Color neutral700 = Color(0xFF4F4F4F);
  static const Color neutral800 = Color(0xFF454545);
  static const Color neutral900 = Color(0xFF3D3D3D);
  static const Color neutral950 = Color(0xFF1F1F1F);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light();
    return base.copyWith(
      // En vez de primarySwatch:
      primaryColor: AppColors.primary.shade500,

      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary.shade500,
        onPrimary: Colors.white,
        secondary: AppColors.secondary.shade500,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.background, // lo que antes usabas en background
        onSurface: Colors.white, // lo que antes usabas en onBackground
      ),

      scaffoldBackgroundColor: AppColors.background,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral100,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral400),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
