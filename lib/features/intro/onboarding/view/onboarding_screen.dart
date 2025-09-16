import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qafeel/core/constants/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/onbb-1.svg",
                  width: 200.w,
                  // height: 50.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "سجِّل الآن",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "واستخدم التطبيق ببساطة",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 100.h,
            start: -90.w,
            child: Container(
              width: 170.w,
              height: 170.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: Color(0xff5C4199), width: 0.3),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 150.h,
            start: -40.w,
            child: Container(
              width: 70.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xff5C4199), width: 0.3),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.r),
                  bottomLeft: Radius.circular(0),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 20.h,
            start: -15.w,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                // border: Border.all(color: Color(0xff5C4199), width: 0.3),
                // borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset("assets/images/svg/qafeel-shape.svg"),
            ),
          ),
        ],
      ),
    );
  }
}
