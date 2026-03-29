import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:krishimitra_ai/services/language_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16,
                                  color: theme.textTheme.bodyMedium?.color),
                              const SizedBox(width: 4),
                              Text(
                                LanguageService.t("app_name"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.surface,
                        child: Icon(Icons.notifications_none,
                            color: theme.iconTheme.color),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// WEATHER + WHEAT IMAGE USING STACK
                  SizedBox(
                    height: 140, // Fixed height for this section
                    child: Stack(
                      clipBehavior: Clip.none, // Allow image to overflow
                      children: [
                        /// Weather info on left
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "32°",
                                style: theme.textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                LanguageService.t("farm_location"),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),

                        /// Wheat image positioned freely
                        Positioned(
                          right: 0,
                          top: -35, // Move upward - can go into header area
                          child: Image.asset(
                            "assets/images/wheat.png",
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// FEATURE CARDS
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.6,
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

                  const SizedBox(height: 24),

                  /// COMMODITIES
                  Text(
                    LanguageService.t("commodities"),
                    style: theme.textTheme.titleLarge,
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 100,
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

                  const SizedBox(height: 24),

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

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          /// FLOATING NAV BAR
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: theme.colorScheme.secondary,
                          child: Icon(Icons.home,
                              color: theme.colorScheme.onSecondary),
                        ),
                        const SizedBox(width: 28),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/fertilizer'),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: theme.colorScheme.primary,
                            child: Icon(Icons.eco,
                                color: theme.colorScheme.onPrimary),
                          ),
                        ),
                        const SizedBox(width: 28),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: theme.colorScheme.primary,
                          child: Icon(Icons.person,
                              color: theme.colorScheme.onPrimary),
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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: theme.iconTheme.color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _commodityItem(
      BuildContext context, String name, String imagePath) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface,
            ),
            child: Image.asset(imagePath, height: 30),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}