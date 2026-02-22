import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  // Text Themes
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1E3A2E), // Dark green
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E3A2E),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E3A2E),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFF2E5A3A),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFF4A6F4A),
    ),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green,
      minimumSize: const Size(double.infinity, 50),
      side: const BorderSide(color: Colors.green, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input Decoration (for forms)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.green.shade100),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.green, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    labelStyle: const TextStyle(color: Color(0xFF4A6F4A)),
    hintStyle: TextStyle(color: Colors.grey.shade400),
  ),

  // Card Theme - FIXED: Changed from CardTheme to CardThemeData
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: Colors.white,
    margin: const EdgeInsets.all(8),
  ),

  // Color Scheme
  colorScheme: const ColorScheme.light(
    primary: Colors.green,
    secondary: Color(0xFFFFA726), // Orange/amber for accents (sun/farming)
    tertiary: Color(0xFF795548), // Brown for soil
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: Colors.green,
    size: 24,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Colors.green.shade100,
    thickness: 1,
    space: 20,
  ),
);

// Additional color constants for specific farming-related features
class FarmColors {
  static const Color soilBrown = Color(0xFF795548);
  static const Color sunYellow = Color(0xFFFFA726);
  static const Color leafGreen = Color(0xFF4CAF50);
  static const Color waterBlue = Color(0xFF42A5F5);
  static const Color harvestOrange = Color(0xFFFF9800);
  static const Color wheatBeige = Color(0xFFF5E6D3);
  static const Color darkGreen = Color(0xFF1E3A2E);
  static const Color lightGreen = Color(0xFFE8F5E9);
}