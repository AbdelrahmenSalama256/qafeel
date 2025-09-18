import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final bool showLogo;
  final String? logoPath;
  final double? logoHeight;
  final String? backgroundImagePath;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final List<Color>? gradientColors;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;
  final Widget? gradientOverlay;
  final double curveRadius;
  final double? curveHeight;
  final Color containerColor;
  final EdgeInsetsGeometry? padding;
  final Widget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool safeArea;
  final double? containerHeight;
  final AlignmentGeometry containerAlignment;
  final BoxShadow? containerShadow;

  const CustomScaffold({
    super.key,
    required this.child,
    this.showLogo = false,
    this.logoPath = "assets/images/png/logo-icon.png",
    this.logoHeight = 80,
    this.backgroundImagePath = "assets/images/png/app-bg.png",
    this.backgroundColor,
    this.backgroundGradient,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd,
    this.gradientOverlay,
    this.curveRadius = 30,
    this.curveHeight,
    this.containerColor = Colors.white,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawer,
    this.endDrawer,
    this.safeArea = true,
    this.containerHeight,
    this.containerAlignment = Alignment.bottomCenter,
    this.containerShadow,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final defaultCurveHeight = curveHeight ?? 200.h;
    final defaultContainerHeight = containerHeight ?? screenHeight * 0.85;
    final defaultPadding = padding ?? EdgeInsets.all(16.w);

    Widget scaffoldBody = Stack(
      children: [
        _buildBackground(),
        if (appBar != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: appBar ?? SizedBox.shrink(),
          ),
        Positioned.fill(
          top: defaultCurveHeight,
          left: 0,
          right: 0,
          bottom: 0,
          child: Align(
            alignment: containerAlignment,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: defaultContainerHeight,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(curveRadius.r),
                  topRight: Radius.circular(curveRadius.r),
                ),
                boxShadow: containerShadow != null ? [containerShadow!] : null,
              ),
              child: Padding(
                padding: defaultPadding,
                child: child,
              ),
            ),
          ),
        ),
        if (showLogo && logoPath != null)
          Positioned(
            top: defaultCurveHeight - 50.h - (logoHeight?.h ?? 80.h),
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                logoPath!,
                height: logoHeight?.h ?? 80.h,
              ),
            ),
          ),
      ],
    );

    if (safeArea) {
      scaffoldBody = SafeArea(child: scaffoldBody);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: appBar,
      body: scaffoldBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }

  Widget _buildBackground() {
    Gradient? effectiveGradient = backgroundGradient;
    if (gradientColors != null && gradientColors!.length >= 2) {
      effectiveGradient = LinearGradient(
        begin: gradientBegin ?? Alignment.topCenter,
        end: gradientEnd ?? Alignment.bottomCenter,
        colors: gradientColors!,
      );
    }

    if (effectiveGradient != null) {
      return Positioned.fill(
        child: Container(
          decoration: BoxDecoration(gradient: effectiveGradient),
        ),
      );
    } else if (backgroundColor != null) {
      return Positioned.fill(
        child: Container(color: backgroundColor),
      );
    } else if (backgroundImagePath != null) {
      return Positioned.fill(
        child: Image.asset(
          backgroundImagePath!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Positioned.fill(
        child: Container(
          decoration: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          ).createShader(const Rect.fromLTWH(0, 0, 200, 200)) as Decoration,
        ),
      );
    }
  }
}

class ScaffoldPresets {
  static CustomScaffold loginScreen({
    required Widget child,
    bool showLogo = true,
    Widget? gradientOverlay,
  }) {
    return CustomScaffold(
      showLogo: showLogo,
      gradientColors: const [Color(0xFF4CAF50), Color(0xFF2E7D32)],
      gradientBegin: Alignment.topCenter,
      gradientEnd: Alignment.bottomCenter,
      gradientOverlay: gradientOverlay,
      curveRadius: 25,
      safeArea: true,
      child: child,
    );
  }

  static CustomScaffold dashboardScreen({
    required Widget child,
    PreferredSizeWidget? appBar,
    Widget? bottomNavigationBar,
    Widget? gradientOverlay,
  }) {
    return CustomScaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      gradientColors: const [Color(0xFF4CAF50), Color(0xFF81C784)],
      gradientBegin: Alignment.topLeft,
      gradientEnd: Alignment.bottomRight,
      gradientOverlay: gradientOverlay,
      curveHeight: 150,
      containerHeight: null,
      safeArea: true,
      child: child,
    );
  }

  static CustomScaffold onboardingScreen({
    required Widget child,
    Widget? gradientOverlay,
  }) {
    return CustomScaffold(
      gradientColors: const [Color(0xFF4CAF50), Color(0xFF81C784)],
      gradientBegin: Alignment.topLeft,
      gradientEnd: Alignment.bottomRight,
      gradientOverlay: gradientOverlay,
      curveRadius: 35,
      extendBody: true,
      safeArea: false,
      child: child,
    );
  }
}
