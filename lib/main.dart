import 'package:flutter/material.dart';
import 'package:krishimitra_ai/core/theme.dart'; // ✅ added
import 'package:krishimitra_ai/screens/splash/splash_screen.dart';
import 'package:krishimitra_ai/screens/home/home_screen.dart';
import 'package:krishimitra_ai/screens/calculators/fertilizer_screen.dart';
import 'package:krishimitra_ai/screens/calculators/profit_screen.dart';
import 'package:krishimitra_ai/services/language_service.dart';
import 'package:krishimitra_ai/screens/language/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// load default language
  await LanguageService.loadLanguage("en");

  runApp(const KrishiMitraApp());
}

class KrishiMitraApp extends StatefulWidget {
  const KrishiMitraApp({super.key});

  static Future<void> setLocale(BuildContext context, String lang) async {
    final state =
    context.findAncestorStateOfType<_KrishiMitraAppState>();

    await LanguageService.loadLanguage(lang);

    state?.changeLanguage();
  }

  @override
  State<KrishiMitraApp> createState() => _KrishiMitraAppState();
}

class _KrishiMitraAppState extends State<KrishiMitraApp> {
  void changeLanguage() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrishiMitra AI',
      debugShowCheckedModeBanner: false,

      initialRoute: '/splash',

      /// ✅ NOW USING YOUR GLOBAL THEME
      theme: appTheme,

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/language': (context) => const LanguageScreen(),
        '/home': (context) => const HomeScreen(),
        '/fertilizer': (context) => const FertilizerScreen(),
        '/profit': (context) => const ProfitScreen(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Route not found!')),
          ),
        );
      },
    );
  }
}