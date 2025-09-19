import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

import '../cubit/add_car_cubit.dart';
import '../cubit/add_car_state.dart';

class CarImagesSection extends StatelessWidget {
  final AddCarCubit cubit;
  final AddCarState state;

  const CarImagesSection({super.key, required this.cubit, required this.state});

  Future<void> _takePhoto(BuildContext context) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (image != null) {
        cubit.addCarImage(image.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب منح إذن الكاميرا لالتقاط الصور')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add_car_images_optional".tr(context),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...state.carImages.asMap().entries.map((entry) => _buildImageBox(
                  entry.value, () => cubit.removeCarImage(entry.key))),
              _buildUploadBox(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox(BuildContext context) {
    return GestureDetector(
      onTap: () => _takePhoto(context),
      child: Container(
        width: 90.w,
        height: 90.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Color(0xffD0C5EB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 30.w, color: AppColors.primary),
            SizedBox(height: 4.h),
            Text(
              "التقاط صورة",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(String imagePath, VoidCallback onRemove) {
    return Stack(
      children: [
        Container(
          width: 90.w,
          height: 90.h,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
