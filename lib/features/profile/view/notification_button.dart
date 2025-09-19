import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback ontap;
  final double? margin;
  const NotificationButton({super.key, required this.ontap, this.margin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(margin == null ? 15.w : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Container(
              width: 35.w,
              height: 35.h,
              padding: EdgeInsets.all(7.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                "assets/images/svg/notification.svg",
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
