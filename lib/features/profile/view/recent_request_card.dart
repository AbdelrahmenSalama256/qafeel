import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';

class RecentRequestCard extends StatelessWidget {
  final String? reqTitle;
  final String? reqLenght;
  final String? reqDate;
  final VoidCallback? ontap;
  const RecentRequestCard(
      {super.key, this.reqTitle, this.reqLenght, this.reqDate, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      // height: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reqTitle ?? "",
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  reqLenght ?? "",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  reqDate ?? "",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 15.w,
          // ),
          // Spacer(),
          InkWell(
            onTap: ontap,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.chevron_back,
                size: 20.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
