import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/cubit/global_cubit.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';
import 'package:qafeel/features/profile/view/notification_button.dart';
import 'package:qafeel/features/requests/view/widgets/my_place_locked_form.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showLogo: false,
      // gradientBegin: Alignment.topCenter,
      // gradientEnd: Alignment.bottomCenter,
      gradientColors: [
        AppColors.primary,
        AppColors.primary,
      ],
      containerColor: const Color(0xffEDE6FF),
      curveRadius: 30.r,
      curveHeight: 200.h,
      appBar: Container(
        margin: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationButton(
              margin: 0,
              ontap: () {},
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text(
                'طلباتي',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildTabBar(),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MyPlaceLockedForm(),
                _buildNewRequestTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        // color: Colors.transparent,
        gradient: LinearGradient(
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
          colors: [
            AppColors.primary,
            AppColors.green,
          ],
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
          fontFamily: context.read<GlobalCubit>().language == "ar"
              ? "arabic"
              : "english",
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: context.read<GlobalCubit>().language == "ar"
              ? "arabic"
              : "english",
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: 'مقفول عليا'),
          Tab(text: 'آسف أنا قافل'),
        ],
      ),
    );
  }

  Widget _buildNewRequestTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                Text(
                  'استدعاء طلب جديد',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 120.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.directions_car,
                                size: 40.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildInlineFormField('الموقع'),
                          SizedBox(height: 10.h),
                          _buildInlineFormField('نوع الخدمة'),
                          SizedBox(height: 10.h),
                          _buildInlineFormField('2020'),
                          SizedBox(height: 10.h),
                          _buildInlineFormField('نوع الوقود'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          _buildSubmitButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildInlineFormField(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return AppButton(
      text: 'تأكيد الطلب',
      onPressed: () {
        // Handle submit request
      },
    );
  }
}
