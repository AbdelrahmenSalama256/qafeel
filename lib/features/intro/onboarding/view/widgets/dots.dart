import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';

class Dots extends StatelessWidget {
  final int currentPage;
  final int count;

  const Dots({
    super.key,
    required this.currentPage,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentPage == index ? 20.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color:
                currentPage == index ? AppColors.primary : AppColors.secondary,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
