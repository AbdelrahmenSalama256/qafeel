import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إحصائيات',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem(false, '250', 'مشترك', Icons.people),
            _buildStatItem(true, '17', 'موقف', Icons.local_parking),
            _buildStatItem(false, '250', 'سيارة', Icons.directions_car),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
      bool isCenter, String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: isCenter ? 130.w : 80.w,
          // height: 100.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCenter ? Colors.white : AppColors.white,
            gradient: isCenter
                ? LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.green,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
                : null,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                alignment: Alignment.center,
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30.w,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: isCenter ? AppColors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: isCenter ? AppColors.white : AppColors.textGrey,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
