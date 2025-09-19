import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qafeel/core/constants/app_colors.dart';

class MenuItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;
  final bool? showEdit;
  const MenuItem(
      {super.key,
      this.text,
      this.icon,
      required this.onTap,
      this.showEdit = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.green.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white,
            size: 24.sp,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            text ?? "",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
          Spacer(),
          showEdit == true
              ? InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    "assets/images/svg/edit.svg",
                    width: 20.w,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
