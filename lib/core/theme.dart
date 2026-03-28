import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,

  /// 🌾 BACKGROUND (HomeScreen beige)
  scaffoldBackgroundColor: const Color(0xFFF5E6D3),

  /// GLOBAL DENSITY
  visualDensity: VisualDensity.adaptivePlatformDensity,

  /// 🎯 COLOR SCHEME (CORE COLORS)
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFFC978), // yellow accent
    secondary: Color(0xFF3A3733), // dark (bottom nav style)
    surface: Colors.white, // cards & containers
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Color(0xFF1E1E1E),
    error: Colors.red,
  ),

  /// 🔝 APP BAR (minimal style)
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF1E1E1E),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E1E1E),
    ),
  ),

  /// ✍️ TEXT THEME
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1E1E1E),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E1E1E),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1E1E1E),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFF1E1E1E),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
  ),

  /// 🟡 ELEVATED BUTTON (yellow accent)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFC978),
      foregroundColor: Colors.black,
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

  /// 🟡 OUTLINED BUTTON
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFFFFC978),
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(vertical: 14),
      side: const BorderSide(color: Color(0xFFFFC978), width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  /// 🧾 INPUT FIELDS
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFFFC978), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    labelStyle: const TextStyle(color: Colors.black54),
  ),

  /// 🧱 CARD THEME (feature cards)
  cardTheme: CardThemeData(
    elevation: 0,
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  /// 🎯 ICONS
  iconTheme: const IconThemeData(
    color: Color(0xFF1E1E1E),
    size: 24,
  ),

  /// ➖ DIVIDER
  dividerTheme: const DividerThemeData(
    color: Colors.black12,
    thickness: 1,
    space: 20,
  ),
);

/// 🌾 OPTIONAL FARM COLORS (you can still use these if needed)
class FarmColors {
  static const Color soilBrown = Color(0xFF795548);
  static const Color sunYellow = Color(0xFFFFC978);
  static const Color leafGreen = Color(0xFF4CAF50);
  static const Color waterBlue = Color(0xFF42A5F5);
  static const Color harvestOrange = Color(0xFFFF9800);
  static const Color wheatBeige = Color(0xFFF5E6D3);
  static const Color dark = Color(0xFF3A3733);
}