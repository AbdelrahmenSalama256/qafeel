import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/navigation.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/auth/view/login_screen.dart';

import '../data/onboaring_model.dart';
import 'cubit/onboaring_cubit.dart';
import 'cubit/onboaring_state.dart';
import 'widgets/animated_shape.dart';
import 'widgets/dots.dart';
import 'widgets/keep_alive.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        OnboardingCubit.ticker = Navigator.of(context);
        return OnboardingCubit();
      },
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => __OnboardingViewState();
}

class __OnboardingViewState extends State<_OnboardingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _precacheImages(context);
      }
    });
  }

  Future<void> _precacheImages(BuildContext context) async {
    final slidesForCache = _buildSlides(context);
    for (final s in slidesForCache) {
      final img = s.image;
      if (img != null && img.toLowerCase().endsWith('.png')) {
        final image = AssetImage(img);
        await precacheImage(image, context);
      }
    }
  }

  List<OnboardModel> _buildSlides(BuildContext context) => [
        OnboardModel(
          image: 'assets/images/svg/onbb-1.svg',
          title: 'onboarding_title1'.tr(context),
          subtitle: 'onboarding_subtitle1'.tr(context),
        ),
        OnboardModel(
          image: 'assets/images/svg/onbb-2.svg',
          title: 'onboarding_title2'.tr(context),
          subtitle: 'onboarding_subtitle2'.tr(context),
        ),
        OnboardModel(
          image: 'assets/images/png/shape.png',
          title: 'onboarding_title3'.tr(context),
          subtitle: 'onboarding_subtitle3'.tr(context),
          isLast: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final slides = _buildSlides(context);
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final page = context.select((OnboardingCubit c) => c.currentPage);
          return Stack(
            children: [
              AnimatedShape(slides: slides, cubit: cubit, page: page),
              PageView.builder(
                controller: cubit.pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: cubit.onPageChanged,
                itemCount: slides.length,
                itemBuilder: (_, i) => KeepAliveSlide(slide: slides[i]),
                allowImplicitScrolling: true,
              ),
              Positioned(
                bottom: 50.h,
                left: 0,
                right: 0,
                child: Dots(
                  dotAnimation: cubit.dotAnimation,
                  currentPage: page,
                  count: slides.length,
                ),
              ),
              PositionedDirectional(
                top: 16.h,
                end: 16.w,
                child: SafeArea(
                  child: TextButton(
                    onPressed: () => navigateAndFinish(context, LoginScreen()),
                    child: Text(
                      'onboarding_skip'.tr(context),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
