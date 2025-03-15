import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColorLight = Color(0xFF6200EE);
  static const Color primaryColorDark = Color(0xFFBB86FC);
  
  static const Color secondaryColorLight = Color(0xFF03DAC6);
  static const Color secondaryColorDark = Color(0xFF03DAC6);
  
  static const Color backgroundColorLight = Color(0xFFF5F5F5);
  static const Color backgroundColorDark = Color(0xFF121212);
  
  static const Color surfaceColorLight = Colors.white;
  static const Color surfaceColorDark = Color(0xFF1E1E1E);
  
  static const Color errorColorLight = Color(0xFFB00020);
  static const Color errorColorDark = Color(0xFFCF6679);
  
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.black;
  
  static const Color onSecondaryLight = Colors.black;
  static const Color onSecondaryDark = Colors.black;
  
  static const Color onBackgroundLight = Colors.black;
  static const Color onBackgroundDark = Colors.white;
  
  static const Color onSurfaceLight = Colors.black;
  static const Color onSurfaceDark = Colors.white;
  
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryColorLight,
        onPrimary: onPrimaryLight,
        secondary: secondaryColorLight,
        onSecondary: onSecondaryLight,
        error: errorColorLight,
        onError: onErrorLight,
        background: backgroundColorLight,
        onBackground: onBackgroundLight,
        surface: surfaceColorLight,
        onSurface: onSurfaceLight,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColorLight,
        foregroundColor: onSurfaceLight,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: onPrimaryLight,
          backgroundColor: primaryColorLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColorDark,
        onPrimary: onPrimaryDark,
        secondary: secondaryColorDark,
        onSecondary: onSecondaryDark,
        error: errorColorDark,
        onError: onErrorDark,
        background: backgroundColorDark,
        onBackground: onBackgroundDark,
        surface: surfaceColorDark,
        onSurface: onSurfaceDark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColorDark,
        foregroundColor: onSurfaceDark,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: onPrimaryDark,
          backgroundColor: primaryColorDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
} 