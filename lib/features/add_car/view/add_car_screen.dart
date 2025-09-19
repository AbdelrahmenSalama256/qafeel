import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/component/widgets/app_dropdown.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/add_car/view/widgets/car_images.dart';
import 'package:qafeel/features/add_car/view/widgets/palet_row.dart';
import 'package:qafeel/features/auth/view/widgets/custom_scaffold.dart';

import '../../profile/view/notification_button.dart';
import 'cubit/add_car_cubit.dart';
import 'cubit/add_car_state.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCarCubit(),
      child: const _AddCarView(),
    );
  }
}

class _AddCarView extends StatelessWidget {
  const _AddCarView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCarCubit, AddCarState>(
      builder: (context, state) {
        final cubit = context.read<AddCarCubit>();

        return CustomScaffold(
          showLogo: false,
          containerColor: const Color(0xffEDE6FF),
          curveRadius: 30.r,
          curveHeight: 70.h,
          appBar: NotificationButton(
            ontap: () {},
          ),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('add_car'.tr(context)),
                SizedBox(height: 20.h),
                _buildCarAnimation(),
                SizedBox(height: 20.h),
                _buildTypeAndModelFields(context, cubit, state),
                SizedBox(height: 20.h),
                _buildYearAndColorFields(context, cubit, state),
                SizedBox(height: 20.h),
                PlateRow(),
                SizedBox(height: 20.h),
                CarImagesSection(cubit: cubit, state: state),
                SizedBox(height: 40.h),
                _buildSubmitButton(context, cubit, state),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildCarAnimation() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 179.w,
            height: 179.w,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.green.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset(
              "assets/images/png/car.png",
              width: double.infinity,
              height: 130.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeAndModelFields(
      BuildContext context, AddCarCubit cubit, AddCarState state) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "type".tr(context),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.h),
              AppDropdownField(
                hint: "type".tr(context),
                items: ['Sedan', 'SUV', 'Truck', 'Hatchback'],
                value: state.carType,
                onChanged: cubit.updateCarType,
              ),
            ],
          ),
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "model".tr(context),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.h),
              AppDropdownField(
                hint: "model".tr(context),
                items: ['Model A', 'Model B', 'Model C'],
                value: state.carModel,
                onChanged: cubit.updateCarModel,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYearAndColorFields(
      BuildContext context, AddCarCubit cubit, AddCarState state) {
    final colorMap = {
      'Red': Colors.red,
      'Blue': Colors.blue,
      'Green': Colors.green,
      'Black': Colors.black,
      'White': Colors.white,
    };

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "manufacturing_year".tr(context),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.h),
              AppDropdownField(
                hint: "manufacturing_year".tr(context),
                items: List.generate(30, (i) => (2023 - i).toString()),
                value: state.manufacturingYear,
                onChanged: cubit.updateManufacturingYear,
              ),
            ],
          ),
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "color".tr(context),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.h),
              AppDropdownField(
                hint: "light_green".tr(context),
                items: colorMap.keys.toList(),
                value: state.carColor,
                onChanged: cubit.updateCarColor,
                colorMap: colorMap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, AddCarCubit cubit, AddCarState state) {
    return AppButton(
      text: "add_car".tr(context),
      onPressed: state.isSubmitting ? null : cubit.submitCar,
      isLoading: state.isSubmitting,
    );
  }
}
