import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/onboaring_model.dart';
import '../cubit/onboaring_cubit.dart';

class AnimatedShape extends StatelessWidget {
  final List<OnboardModel> slides;
  final OnboardingCubit cubit;
  final int page;

  const AnimatedShape({
    super.key,
    required this.slides,
    required this.cubit,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    // Set a static position (e.g., bottom-left for the first slide)
    return PositionedDirectional(
      start: -190.w, // Static position
      bottom: 0.h, // Static position
      child: SizedBox(
        width: 280.w,
        height: 280.h,
        child: Image.asset(
          "assets/images/png/shape.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
