import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/widgets/print_util.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';
import 'package:qafeel/features/home/view/widget/banner.dart';
import 'package:qafeel/features/home/view/widget/parking_section.dart';
import 'package:qafeel/features/home/view/widget/statistics.dart';
import 'package:qafeel/features/select_spot/view/select_spot_screen.dart';

import '../../profile/view/notification_button.dart';
import '../../select_spot/view/cubit/spot_cubit.dart';
import 'widget/action_bottons.dart';
import 'widget/blog_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showLogo: false,
      gradientBegin: Alignment.topCenter,
      gradientEnd: Alignment.bottomCenter,
      gradientColors: [
        AppColors.green,
        AppColors.primary,
      ],
      containerColor: const Color(0xffEDE6FF),
      curveRadius: 30.r,
      curveHeight: 200.h,
      appBar: Container(
        margin: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationButton(
              margin: 0,
              ontap: () {},
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0.4), width: 1.w),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/png/profile-user.jpg",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "welcome".tr(context),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "علاء التميمي",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 60.w,
                  height: 60.h,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/png/qr-code.png",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          SpotsCubit()..initializeLocation(context),
                      child: const SelectSpotScreen(),
                    ),
                  ),
                );

                if (result != null && result is Map) {
                  setState(() {
                    selectedLocation =
                        result['address'] ?? "choose_city".tr(context);
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 40.h,
                padding: EdgeInsetsDirectional.only(
                  start: 15.w,
                  top: 5.h,
                  bottom: 5.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedLocation ?? "choose_city".tr(context),
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          fontSize: 18.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    Container(
                      width: 40.w,
                      height: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                        gradient: AppColors.longGradient,
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 20.sp,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            SizedBox(height: 15.h),
            BannerHome(
              height: 200.h,
              imageUrls: [
                'assets/images/png/banner.png',
                'assets/images/png/banner.png',
                'assets/images/png/banner.png',
              ],
              titles: [
                "خليك في الأمان",
                "خليك في الأمان",
                "خليك في الأمان",
              ],
              descriptions: [
                "وماتخليش حد يقفل عليك",
                "وماتخليش حد يقفل عليك",
                "وماتخليش حد يقفل عليك",
              ],
            ),
            SizedBox(height: 20.h),
            ActionButton(
              text: "report_car".tr(context),
              icon: "assets/images/svg/report.svg",
              onPressed: () {},
              backgroundColor: Colors.white,
              textColor: AppColors.primary,
            ),
            ActionButton(
              text: "my_cars".tr(context),
              icon: "assets/images/svg/car-garage.svg",
              onPressed: () {},
              backgroundColor: Colors.white,
              textColor: AppColors.green,
            ),
            SizedBox(height: 20.h),
            ParkingSections(),
            SizedBox(height: 20.h),
            BlogSection(
              imageUrls: [
                'assets/images/png/logo-icon.png',
                'assets/images/png/banner.png',
                'assets/images/png/logo-icon.png',
              ],
              titles: [
                "blog1_title".tr(context),
                "blog2_title".tr(context),
                "blog3_title".tr(context),
              ],
              descriptions: [
                "blog1_desc".tr(context),
                "blog2_desc".tr(context),
                "blog3_desc".tr(context),
              ],
              onBlogPressed: (index) {
                PrintUtil.debug('Blog $index clicked');
              },
            ),
            SizedBox(height: 20.h),
            StatisticsSection(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
