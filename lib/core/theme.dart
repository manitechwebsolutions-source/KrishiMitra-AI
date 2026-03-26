import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,

  /// GLOBAL VISUAL DENSITY (better alignment)
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// APP BAR
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.2, // better vertical alignment
      color: Colors.white,
    ),
  ),

  /// TEXT THEME (aligned spacing + height)
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: Color(0xFF1E3A2E),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: Color(0xFF1E3A2E),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: Color(0xFF1E3A2E),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.4,
      color: Color(0xFF2E5A3A),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.4,
      color: Color(0xFF4A6F4A),
    ),
  ),

  /// ELEVATED BUTTON
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  /// OUTLINED BUTTON
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green,
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(vertical: 14),
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

  /// INPUT FIELDS
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // FIXED
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
  ),

  /// CARD THEME (IMPORTANT ALIGNMENT FIX)
  cardTheme: CardThemeData(
    elevation: 2,
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: Colors.white,
  ),

  /// COLOR SCHEME
  colorScheme: const ColorScheme.light(
    primary: Colors.green,
    secondary: Color(0xFFFFA726),
    tertiary: Color(0xFF795548),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
  ),

  /// ICONS
  iconTheme: const IconThemeData(
    color: Colors.green,
    size: 24,
  ),

  /// DIVIDER
  dividerTheme: DividerThemeData(
    color: Colors.green.shade100,
    thickness: 1,
    space: 20,
  ),
);

/// FARM COLORS (UNCHANGED)
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