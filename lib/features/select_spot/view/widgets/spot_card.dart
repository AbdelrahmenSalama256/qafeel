import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

class SpotCard extends StatelessWidget {
  final String? spotName;
  final String? streetName;
  final String? partWayName;
  final String? wayNumber;
  final String? meterDistance;
  final VoidCallback? onTap;
  final bool isSelected;

  const SpotCard({
    super.key,
    this.isSelected = true,
    this.spotName,
    this.streetName,
    this.partWayName,
    this.wayNumber,
    this.onTap,
    this.meterDistance,
  });

  @override
  Widget build(BuildContext context) {
    String? fullAddress;

    // Combine only non-null, non-empty parts
    final parts = [streetName, partWayName, wayNumber]
        .where((e) => e != null && e.trim().isNotEmpty)
        .toList();

    if (parts.isNotEmpty) {
      fullAddress = parts.join("، ");
    }

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(92.52 * 3.1415926535 / 180),
                  colors: const [
                    Color(0xFF5C4199),
                    Color(0xFF291D49),
                  ],
                  stops: const [0.477, 0.9532],
                )
              : LinearGradient(
                  transform: GradientRotation(92.52 * 3.1415926535 / 180),
                  colors: const [
                    Color(0xFFFFFFFF),
                    Color(0xFFCEFFEF),
                    Color(0xFFFFFFFF),
                  ],
                  stops: const [0.0, 0.3442, 1.0],
                ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 70.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                gradient: isSelected
                    ? LinearGradient(
                        transform:
                            GradientRotation(137.27 * 3.1415926535 / 180),
                        colors: const [
                          Color(0xFF2FAE84),
                          Color(0xFF2B775E),
                        ],
                        stops: const [0.2401, 0.7599],
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(92.52 * 3.1415926535 / 180),
                        colors: const [
                          Color(0xFF5C4199),
                          Color(0xFF291D49),
                        ],
                        stops: const [0.477, 0.9532],
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    meterDistance ?? "0",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "meter".tr(context),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (spotName ?? "spot_name_placeholder").tr(context),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: isSelected ? AppColors.white : AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    (fullAddress ?? "default_address_placeholder").tr(context),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? AppColors.green : AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              CupertinoIcons.chevron_back,
              size: 20.sp,
              color: isSelected ? AppColors.white : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
