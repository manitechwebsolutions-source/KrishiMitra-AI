import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  // Additional animations for agriculture elements
  late Animation<double> _sunAnimation;
  late Animation<double> _leafAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Main animations
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    );

    // Sun rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Sun movement animation
    _sunAnimation = Tween<double>(begin: -50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Leaf floating animation
    _leafAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Simulate initialization tasks with loading indicator
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/language');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper method to create language text widgets with animation
  Widget _buildLanguageText(String text, double delay) {
    return AnimatedOpacity(
      opacity: _controller.value > delay ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.green.shade700,
          shadows: [
            Shadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background with gradient
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(
                        Colors.green.shade50,
                        Colors.lightGreen.shade50,
                        _controller.value,
                      )!,
                      Color.lerp(
                        Colors.green.shade100,
                        Colors.green.shade200,
                        _controller.value,
                      )!,
                      Color.lerp(
                        Colors.green.shade50,
                        Colors.lightGreen.shade100,
                        _controller.value,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),

          // Decorative sun element (without assets)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: 40 + _sunAnimation.value,
                right: 20,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.withOpacity(0.15 * _controller.value),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.1 * _controller.value),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.wb_sunny,
                      color: Colors.orange.withOpacity(0.4 * _controller.value),
                      size: 40,
                    ),
                  ),
                ),
              );
            },
          ),

          // Decorative cloud-like elements (made with containers)
          Positioned(
            top: 100,
            left: 20,
            child: AnimatedOpacity(
              opacity: _controller.value > 0.1 ? 0.1 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          Positioned(
            top: 150,
            left: 60,
            child: AnimatedOpacity(
              opacity: _controller.value > 0.2 ? 0.1 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          // Main content with fade transition
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Hindi (Top)
                  _buildLanguageText('कृषि मित्र AI', 0.2),

                  const SizedBox(height: 20),

                  /// English
                  _buildLanguageText('KrishiMitra AI', 0.3),

                  const SizedBox(height: 30),

                  /// Main Logo/Icon with enhanced animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.95),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: Offset(0, 5 * (1 - _controller.value)),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Main agriculture icon
                              Transform.rotate(
                                angle: _rotationAnimation.value * 2,
                                child: const Icon(
                                  Icons.agriculture,
                                  size: 60,
                                  color: Colors.green,
                                ),
                              ),
                              // Floating leaf animation (using Eco icon)
                              AnimatedBuilder(
                                animation: _leafAnimation,
                                builder: (context, child) {
                                  return Positioned(
                                    top: -10 - (_leafAnimation.value * 5),
                                    right: -5 - (_leafAnimation.value * 3),
                                    child: Opacity(
                                      opacity: _leafAnimation.value,
                                      child: Transform.rotate(
                                        angle: _leafAnimation.value * 0.5,
                                        child: const Icon(
                                          Icons.eco,
                                          size: 25,
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'కృషిమిత్ర AI',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                              letterSpacing: 1.2,
                            ),
                          ),

                          // Loading indicator (dots)
                          const SizedBox(height: 20),
                          AnimatedOpacity(
                            opacity: _controller.value > 0.7 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildLoadingDot(Colors.green.shade600, 0),
                                const SizedBox(width: 5),
                                _buildLoadingDot(Colors.green.shade400, 0.2),
                                const SizedBox(width: 5),
                                _buildLoadingDot(Colors.green.shade200, 0.4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Kannada
                  _buildLanguageText('ಕೃಷಿ ಮಿತ್ರ AI', 0.5),

                  const SizedBox(height: 20),

                  /// Tamil (Bottom)
                  _buildLanguageText('கிரிஷி மித்ரா AI', 0.6),

                  // Progress indicator
                  const SizedBox(height: 40),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          value: _controller.value,
                          backgroundColor: Colors.green.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green.shade700,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Decorative grass-like elements at bottom (made with containers)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _controller.value > 0.2 ? 0.2 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(10, (index) {
                  return Container(
                    width: 3,
                    height: 15 + (index % 3) * 5,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Version number
          Positioned(
            bottom: 10,
            right: 10,
            child: AnimatedOpacity(
              opacity: _controller.value,
              duration: const Duration(milliseconds: 500),
              child: Text(
                'v1.0.0',
                style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for loading dots animation
  Widget _buildLoadingDot(Color color, double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(
              _controller.value > 0.7
                  ? (0.5 + 0.5 * (1 + (_controller.value - 0.7) / 0.3))
                  : 0.3,
            ),
          ),
        );
      },
    );
  }
}