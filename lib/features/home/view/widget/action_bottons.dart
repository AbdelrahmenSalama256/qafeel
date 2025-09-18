import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? elevation;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor,
    this.borderColor,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff666666).withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(20, 20),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
              color: iconColor ?? textColor,
            ),
            SizedBox(width: 10.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            Spacer(),
            Icon(
              CupertinoIcons.chevron_back,
              size: 16.sp,
              color: iconColor ?? textColor,
            ),
          ],
        ),
      ),
    );
  }
}
