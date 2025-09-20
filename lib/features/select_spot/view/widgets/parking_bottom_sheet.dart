import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/cubit/global_cubit.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

import '../cubit/spot_cubit.dart';

class ParkingBottomSheet extends StatelessWidget {
  final String? streetName;
  final String? fullAddress;
  final bool isAddressSelected;
  final VoidCallback? onConfirmPressed;
  final Function(String) onSpotSelected;

  const ParkingBottomSheet({
    super.key,
    required this.isAddressSelected,
    this.onConfirmPressed,
    required this.onSpotSelected,
    this.streetName,
    this.fullAddress,
  });

  Widget _buildSpotGrid(
    List<Map<String, dynamic>> spots,
    bool isSelectable,
    BuildContext context, {
    bool isInsideScroll = false, // جديد
  }) {
    final cubit = context.read<SpotsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: isInsideScroll
            ? const NeverScrollableScrollPhysics() // يمنع Scroll داخلي
            : const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.2,
        ),
        itemCount: spots.length,
        itemBuilder: (context, index) {
          final spot = spots[index];
          final isSelected = cubit.state.selectedSpot == spot['spot'];

          return GestureDetector(
            onTap: isSelectable ? () => onSpotSelected(spot['spot']) : null,
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.green : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: isSelected
                    ? Border.all(color: AppColors.green, width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  spot['spot'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpotsCubit>();
    return SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: 3,
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: EdgeInsets.all(24.h),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        streetName ?? "spot_name_placeholder".tr(context),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        (fullAddress ?? "default_address_placeholder")
                            .tr(context),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.green,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.centerStart,
                            end: AlignmentDirectional.centerEnd,
                            colors: [
                              AppColors.primary,
                              AppColors.green,
                            ],
                          ),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.white,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily:
                                context.read<GlobalCubit>().language == "ar"
                                    ? "arabic"
                                    : "english",
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily:
                                context.read<GlobalCubit>().language == "ar"
                                    ? "arabic"
                                    : "english",
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: 'الركنات المتاحة'),
                            Tab(text: 'القافلين الآن'),
                            Tab(text: 'المقفول عليهم'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(
                                children: [
                                  _buildSpotGrid(
                                      cubit.availableSpots, true, context),
                                  _buildSpotGrid(cubit.currentlyClosedSpots,
                                      false, context),
                                  _buildSpotGrid(
                                      cubit.lockedSpots, false, context),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_down,
                              color: AppColors.white,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                AppButton(
                  onPressed: isAddressSelected ? onConfirmPressed : null,
                  text: 'confirm_location'.tr(context),
                  height: 50.h,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
