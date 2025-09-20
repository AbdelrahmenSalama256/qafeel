import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/navigation.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

import '../../../../auth/view/login_screen.dart';
import '../../data/onboaring_model.dart';

class Slide extends StatelessWidget {
  final OnboardModel slide;
  const Slide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              // color: const Color(0xffE8E0FF),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: slide.isLast!
                ? Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(100.r),
                        bottomLeft: Radius.circular(50.r),
                        bottomRight: Radius.circular(100.r),
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/png/logo-icon.png",
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : SvgPicture.asset(
                    slide.image!,
                    fit: BoxFit.contain,
                  ),
          ),
          SizedBox(height: 30.h),
          Text(
            slide.title ?? "",
            style: TextStyle(
              fontSize: 28.sp,
              color: const Color(0xff5C4199),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            slide.subtitle ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: const Color(0xff666666),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (slide.isLast!) ...[
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: AppButton(
                borderRadius: BorderRadius.circular(20.r),
                onPressed: () {
                  navigateAndFinish(context, LoginScreen());
                },
                backgroundColor: AppColors.primary,
                text: "onboarding_start_button".tr(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
