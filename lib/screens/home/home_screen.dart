import 'package:flutter/material.dart';
import '../../core/theme.dart';  // Fixed import path (go up two levels)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KrishiMitra AI'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              /// Welcome Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: FarmColors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to KrishiMitra AI 🌱',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: FarmColors.darkGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your smart farming assistant',
                      style: TextStyle(
                        fontSize: 16,
                        color: FarmColors.leafGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Feature Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.camera_alt,
                      label: 'Scan Disease',
                      color: FarmColors.leafGreen,
                      onTap: () => _showComingSoon(context),
                    ),
                    _buildFeatureCard(
                      icon: Icons.attach_money,
                      label: 'Market Prices',
                      color: FarmColors.sunYellow,
                      onTap: () => _showComingSoon(context),
                    ),
                    _buildFeatureCard(
                      icon: Icons.agriculture,
                      label: 'Farming Tips',
                      color: FarmColors.soilBrown,
                      onTap: () => _showComingSoon(context),
                    ),
                    _buildFeatureCard(
                      icon: Icons.wb_sunny,
                      label: 'Weather',
                      color: FarmColors.waterBlue,
                      onTap: () => _showComingSoon(context),
                    ),
                    _buildFeatureCard(
                      icon: Icons.shopping_cart,
                      label: 'Sell Crop',
                      color: FarmColors.harvestOrange,
                      onTap: () => _showComingSoon(context),
                    ),
                    _buildFeatureCard(
                      icon: Icons.science,
                      label: 'Soil Health',
                      color: FarmColors.wheatBeige,
                      onTap: () => _showComingSoon(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Change Language Button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/language');
                },
                icon: const Icon(Icons.language),
                label: const Text(
                  'Change Language',
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Coming Soon 🚀'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: FarmColors.leafGreen,
      ),
    );
  }
}