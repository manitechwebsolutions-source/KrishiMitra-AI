import 'package:flutter/material.dart';
import 'core/app_routes.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  // Ensure Flutter is initialized (good practice for future plugins)
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const KrishiMitraApp());
}

class KrishiMitraApp extends StatelessWidget {
  const KrishiMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrishiMitra AI',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      initialRoute: '/splash',
      home: const SplashScreen(), // fallback if route fails

      // Optional enhancements you might want to add:

      // Theme customization (uncomment and modify as needed)
      // theme: ThemeData(
      //   primarySwatch: Colors.green, // Agriculture theme
      //   useMaterial3: true, // Enable Material 3 design
      //   fontFamily: 'Poppins', // If you add custom fonts later
      // ),

      // Error handling for navigation
      onGenerateRoute: (settings) {
        // You can add custom route generation logic here if needed
        return null; // Falls back to routes map
      },

      // Error handling for undefined routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
      },
    );
  }
}