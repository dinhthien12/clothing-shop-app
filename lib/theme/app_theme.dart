import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF111111);      // Đen
  static const Color secondary = Color(0xFF757575);    // Xám
  static const Color background = Color(0xFFF5F5F5);   // Nền
  static const Color card = Colors.white;              // Card
  static const Color border = Color(0xFFE0E0E0);       // Viền
  static const Color success = Color(0xFF2E7D32);      // Thành công
  static const Color error = Color(0xFFD32F2F);        // Lỗi

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,


    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: card,
      onSurface: primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primary,
      centerTitle: true,
      elevation: 0,
    ),

    cardColor: card,

    dividerColor: border,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary),
      ),
    ),
  );
}