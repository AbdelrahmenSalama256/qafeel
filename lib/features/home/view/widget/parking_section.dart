import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

class ParkingSections extends StatefulWidget {
  const ParkingSections({super.key});

  @override
  State<ParkingSections> createState() => _ParkingSectionsState();
}

class _ParkingSectionsState extends State<ParkingSections> {
  String? _selectedSection;
  final List<String> _lockedSections = ['A1', 'A6', 'B3', 'C5'];
  final List<String> _occupiedSections = ['A1', 'A6', 'B3', 'C5'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('locked_now'.tr(context)),
        SizedBox(height: 8.h),
        _buildSectionContainers(_lockedSections),
        SizedBox(height: 24.h),
        _buildSectionTitle('blocking_now'.tr(context)),
        SizedBox(height: 8.h),
        _buildSectionContainers(_occupiedSections),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'view_all'.tr(context),
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xff808080),
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff808080),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContainers(List<String> sections) {
    return Wrap(
      spacing: 4.w,
      runSpacing: 4.h,
      alignment: WrapAlignment.spaceBetween,
      children: sections.map((section) {
        final isSelected = _selectedSection == section;
        return InkWell(
          hoverColor: AppColors.green,
          onTap: () {
            setState(() {
              _selectedSection = isSelected ? null : section;
            });
          },
          child: Container(
            width: 80.w,
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              // color: isSelected ? Colors.blue : Colors.grey.shade200,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                // color: isSelected ? Colors.blue : Colors.grey.shade300,
                color: AppColors.primary,

                width: 1.w,
              ),
            ),
            child: Text(
              section,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
