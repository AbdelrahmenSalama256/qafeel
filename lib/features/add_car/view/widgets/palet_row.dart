import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class PlateRow extends StatelessWidget {
  const PlateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildPlateSection(
              title: "أحرف اللوحة",
              items: [
                _buildBox(isFilled: true, text: "ك"),
                _buildBox(),
                _buildBox(),
              ],
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            child: _buildPlateSection(
              title: "أرقام اللوحة",
              items: List.generate(3, (i) => _buildBox()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlateSection(
      {required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...items.map((e) => Expanded(
                    flex: 7,
                    child: e,
                  )),
              SizedBox(width: 20.w),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.add, color: Colors.purple, size: 20.w)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBox({bool isFilled = false, String? text}) {
    return Container(
      width: 200.w,
      height: 35.h,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled ? AppColors.primary : Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: text != null
          ? Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}
