import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/language/language_screen.dart';
import '../screens/home/home_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => const SplashScreen(),
  '/language': (context) => const LanguageScreen(),
  '/home': (context) => const HomeScreen(),
};

// Optional: Route names as constants to avoid typos
abstract class AppRoutes {
  static const String splash = '/splash';
  static const String language = '/language';
  static const String home = '/home';
}