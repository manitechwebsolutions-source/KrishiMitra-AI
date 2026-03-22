import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:krishimitra_ai/services/language_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      body: Stack(
        children: [
          /// MAIN CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LanguageService.t("hello_welcome"),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.black54),
                              const SizedBox(width: 4),
                              Text(
                                LanguageService.t("app_name"),
                                style:
                                const TextStyle(color: Colors.black54),
                              ),
                            ],
                          )
                        ],
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.notifications_none),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// WEATHER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "32°",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        "assets/images/wheat.png",
                        height: 90,
                      ),
                    ],
                  ),

                  Text(
                    LanguageService.t("farm_location"),
                    style: const TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  /// FEATURE CARDS
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _featureCard(
                        context,
                        Icons.science,
                        LanguageService.t("fertilizer"),
                            () => Navigator.pushNamed(context, '/fertilizer'),
                      ),
                      _featureCard(
                        context,
                        Icons.attach_money,
                        LanguageService.t("profit_calc"),
                            () => Navigator.pushNamed(context, '/profit'),
                      ),
                      _featureCard(
                        context,
                        Icons.camera_alt,
                        LanguageService.t("disease_detect"),
                            () {},
                      ),
                      _featureCard(
                        context,
                        Icons.account_balance,
                        LanguageService.t("gov_schemes"),
                            () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// COMMODITIES
                  Text(
                    LanguageService.t("commodities"),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _commodityItem(context,
                            LanguageService.t("rice"), "assets/images/rice.jpg"),
                        _commodityItem(context,
                            LanguageService.t("corn"), "assets/images/corn.jpeg"),
                        _commodityItem(
                            context,
                            LanguageService.t("grapes"),
                            "assets/images/grapes.jpg"),
                        _commodityItem(
                            context,
                            LanguageService.t("potato"),
                            "assets/images/potato.jpg"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// FIELD IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/field.jpeg",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),

          /// FLOATING NAV BAR
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.home, color: Colors.white),
                        ),

                        const SizedBox(width: 30),

                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/fertilizer'),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xFFFFC978),
                            child: Icon(Icons.eco, color: Colors.black),
                          ),
                        ),

                        const SizedBox(width: 30),

                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Color(0xFFFFC978),
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _featureCard(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _commodityItem(
      BuildContext context, String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(imagePath, height: 30),
          ),
          const SizedBox(height: 6),
          Text(name),
        ],
      ),
    );
  }
}