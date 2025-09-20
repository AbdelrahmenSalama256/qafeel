import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';

import '../../../../core/component/widgets/app_text_field.dart';

class MyPlaceLockedForm extends StatelessWidget {
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  MyPlaceLockedForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          AppTextField(
            controller: neighborhoodController,
            labelText: 'اسم الحي',
            hintText: 'أدخل اسم الحي هنا',
            prefixIcon: Icon(Icons.location_on_outlined, size: 20.sp),
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: streetController,
            labelText: 'اسم الشارع',
            hintText: 'أدخل اسم الشارع هنا',
            prefixIcon: Icon(Icons.read_more, size: 20.sp),
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: TextEditingController(),
            labelText: 'معلومات إضافية',
            hintText: 'انقر لإدخال معلومات إضافية',
            readOnly: true,
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AdditionalInfoScreen()));
            },
            prefixIcon: Icon(Icons.info_outline, size: 20.sp),
            suffixIcon: Icon(Icons.arrow_forward_ios, size: 16.sp),
          ),
          SizedBox(height: 25.h),
          _buildCarDetailsCard(),
          SizedBox(height: 25.h),
          _buildRequestItem(
            icon: Icons.lock_outline,
            title: 'مقفول عليا',
            subtitle: 'تم إرسال الطلب بنجاح',
            status: 'قيد المراجعة',
          ),
          SizedBox(height: 15.h),
          _buildRequestItem(
            icon: Icons.close_outlined,
            title: 'آسف أنا قافل',
            subtitle: 'يمكنك متابعة حالة طلبك',
            status: 'مكتمل',
          ),
          SizedBox(height: 15.h),
          _buildRequestItem(
            icon: Icons.access_time_outlined,
            title: 'متابعة الطلب',
            subtitle: 'عرض جميع الطلبات السابقة',
            status: 'السجل',
          ),
        ],
      ),
    );
  }

  Widget _buildCarDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل السيارة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey[200],
              image: const DecorationImage(
                image: AssetImage('assets/images/png/car.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: TextEditingController(text: 'شاص الملك نهد'),
            labelText: 'الموديل',
            readOnly: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: TextEditingController(text: '150'),
                  labelText: 'إبتدأ',
                  readOnly: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AppTextField(
                  controller: TextEditingController(text: '2007'),
                  labelText: 'سنة التجميع',
                  readOnly: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          AppTextField(
            controller: TextEditingController(text: 'اسم قائم'),
            labelText: 'اسم قائم',
            readOnly: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'تأكيد الطالب',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: status == 'قيد المراجعة'
                  ? Colors.orange[100]
                  : status == 'مكتمل'
                      ? Colors.green[100]
                      : Colors.blue[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12.sp,
                color: status == 'قيد المراجعة'
                    ? Colors.orange[800]
                    : status == 'مكتمل'
                        ? Colors.green[800]
                        : Colors.blue[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
