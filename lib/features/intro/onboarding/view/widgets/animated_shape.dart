import 'dart:math' as math;

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
    return AnimatedBuilder(
      animation: cubit.positionAnimation,
      builder: (context, child) {
        final value = cubit.positionAnimation.value;

        double? start;
        double? end;
        double? top;
        double? bottom;

        if (page == 0) {
          start = -190.w + (value * 50.w);
          bottom = 0.h;
        } else if (page == 1) {
          end = -190.w + (value * 50.w);
          bottom = -20.h;
        } else {
          // لو عايزها في الـstart خليها start هنا
          start = -200.w + (value * 50.w);
          top = 50.h;
        }

        double angle;
        if (page == 0) {
          angle = 0;
        } else if (page == 1) {
          angle = 50 * math.pi / 240 * value;
        } else {
          angle = 0;
        }

        return PositionedDirectional(
          start: start,
          end: end,
          top: top,
          bottom: bottom,
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.rotate(
              angle: angle,
              child: SizedBox(
                width: 280.w,
                height: 280.h,
                child: Image.asset(
                  "assets/images/png/shape.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
