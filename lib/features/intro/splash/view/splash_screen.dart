import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/features/base/view/base_screen.dart';

import '../../../../core/constants/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _precacheImages().then((_) {
      _controller.forward().then(
        (value) {
          navigateTo(context, BaseScreen());
        },
      );
    });
  }

  Future<void> _precacheImages() async {
    final images = [
      'assets/images/png/onbb-1.png',
      'assets/images/png/onbb-2.png',
    ];
    for (final img in images) {
      if (img.toLowerCase().endsWith('.svg')) {
        final image = AssetImage(img);
        await precacheImage(image, context);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/images/png/logo-icon.png',
                width: 200.w,
                height: 200.h,
                // fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
