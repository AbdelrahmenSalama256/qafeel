import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/navigation.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';
import 'package:qafeel/features/profile/view/menu_item.dart';
import 'package:qafeel/features/profile/view/notification_button.dart';
import 'package:qafeel/features/profile/view/recent_request_card.dart';
import 'package:qafeel/features/requests/view/my_requests_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      containerHeight: 0,
      bottom: true,
      gradientColors: [
        AppColors.green,
        AppColors.primary,
      ],
      gradientBegin: Alignment.topCenter,
      gradientEnd: Alignment.bottomCenter,
      gradientStops: [0.0, 0.2949],
      appBar: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationButton(
              ontap: () {},
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "my_membership".tr(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 140.w,
                        height: 140.h,
                        padding: EdgeInsets.all(7.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.green.withOpacity(0.4),
                              width: 1.w),
                          borderRadius: BorderRadius.circular(70.r),
                        ),
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          padding: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.green.withOpacity(0.2),
                                width: 1.w),
                            borderRadius: BorderRadius.circular(70.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(60.r),
                              topEnd: Radius.circular(70.r),
                              topStart: Radius.circular(70.r),
                              bottomStart: Radius.circular(60.r),
                            ),
                            child: Image.asset(
                              "assets/images/png/profile-user.jpg",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        end: 0,
                        top: 0,
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              "assets/images/png/qr-code.png",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuItem(
                    onTap: () {},
                    icon: CupertinoIcons.person,
                    text: "name".tr(context),
                  ),
                  MenuItem(
                    onTap: () {},
                    icon: CupertinoIcons.envelope,
                    text: "email_label".tr(context),
                  ),
                  MenuItem(
                    onTap: () {},
                    icon: Icons.location_on_outlined,
                    text: "address".tr(context),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "my_requests".tr(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RecentRequestCard(
                          reqDate: "last_update_date".tr(context),
                          reqLenght: "requests_count".tr(context),
                          reqTitle: "car_exit_request".tr(context),
                          ontap: () {
                            navigateTo(context, MyRequestsScreen());
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: RecentRequestCard(
                          reqDate: "last_update_date".tr(context),
                          reqLenght: "requests_count".tr(context),
                          reqTitle: "car_exit_request".tr(context),
                          ontap: () {
                            // navigateTo(context, MyRequestsScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "more".tr(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MenuItem(
                    onTap: () {},
                    icon: CupertinoIcons.phone,
                    text: "contact_us".tr(context),
                    showEdit: false,
                  ),
                  MenuItem(
                    onTap: () {},
                    icon: Icons.privacy_tip,
                    text: "privacy_policy".tr(context),
                    showEdit: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.h,
            )
          ],
        ),
      ),
      child: SizedBox.shrink(),
    );
  }
}
