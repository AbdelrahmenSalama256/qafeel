import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qafeel/core/component/widgets/app_button.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/constants/navigation.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/select_spot/view/select_available_spot_screen.dart';

import '../../../core/cubit/global_cubit.dart';
import 'cubit/spot_cubit.dart';
import 'cubit/spot_state.dart';
import 'widgets/spot_card.dart';

class SelectSpotScreen extends StatelessWidget {
  const SelectSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final globalCubit = context.read<GlobalCubit>();
    final spotsCubit = context.read<SpotsCubit>();

    if (globalCubit.currentLat == 0.0 && globalCubit.currentLong == 0.0) {
      globalCubit.init();
    }

    return BlocBuilder<SpotsCubit, SpotsState>(
      builder: (context, state) {
        return Scaffold(
          body: state.initialCameraPosition == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    semanticsLabel: "loading".tr(context),
                  ),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: state.initialCameraPosition!,
                      onMapCreated: (controller) {
                        spotsCubit.onMapCreated(controller);
                        spotsCubit.loadMapStyle(controller, context);
                      },
                      buildingsEnabled: true,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      onCameraMove: (position) =>
                          spotsCubit.onCameraMove(position, context),
                      onCameraIdle: () =>
                          spotsCubit.getAddressFromLatLng(context),
                    ),
                    if (!state.isMapLoaded)
                      Container(
                        color: Colors.white.withOpacity(0.7),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            semanticsLabel: "loading".tr(context),
                          ),
                        ),
                      ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 60.h),
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.green,
                            size: 50.sp,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEDE6FF),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              alignment: AlignmentDirectional.centerStart,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.address ??
                                          'my_current_location'.tr(context),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.scope,
                                    color: AppColors.primary,
                                    size: 24.w,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SpotCard(
                              spotName: state.selectedSpot,
                              streetName: state.streetName,
                              partWayName:
                                  state.selectedSpotDetails?['partWayName'],
                              wayNumber:
                                  state.selectedSpotDetails?['wayNumber'],
                              meterDistance:
                                  state.selectedSpotDetails?['meterDistance'],
                              onTap: () {
                                navigateTo(
                                  context,
                                  BlocProvider.value(
                                    value: spotsCubit, // تمرير نفس الـ cubit
                                    child: SelectAvailableSpotScreen(
                                      onSpotSelected: spotsCubit.selectSpot,
                                    ),
                                  ),
                                );
                              },
                              isSelected: state.selectedSpot != null,
                            ),
                            SizedBox(height: 16.h),
                            AppButton(
                              onPressed: state.isAddressSelected
                                  ? () {
                                      if (state.markerPosition != null) {
                                        Navigator.pop(
                                          context,
                                          {
                                            'lat':
                                                state.markerPosition!.latitude,
                                            'lng':
                                                state.markerPosition!.longitude,
                                            'address': state.address,
                                            'selectedSpot': state.selectedSpot,
                                            'selectedSpotDetails':
                                                state.selectedSpotDetails,
                                          },
                                        );
                                      }
                                    }
                                  : null,
                              text: 'confirm_location'.tr(context),
                              height: 50.h,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
