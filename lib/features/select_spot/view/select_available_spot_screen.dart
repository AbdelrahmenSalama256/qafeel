import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

import 'cubit/spot_cubit.dart';
import 'cubit/spot_state.dart';
import 'widgets/parking_bottom_sheet.dart';

class SelectAvailableSpotScreen extends StatelessWidget {
  final Function(String) onSpotSelected;

  const SelectAvailableSpotScreen({
    super.key,
    required this.onSpotSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpotsCubit>();

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
                        // cubit.onMapCreated(controller);
                        // cubit.loadMapStyle(controller, context);
                      },
                      buildingsEnabled: true,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      onCameraMove: (position) =>
                          cubit.onCameraMove(position, context),
                      // onCameraIdle: () => cubit.getAddressFromLatLng(context),
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
                      child: ParkingBottomSheet(
                        isAddressSelected: state.isAddressSelected,
                        streetName: state.streetName ?? "",
                        fullAddress: state.fullAddress ?? "",
                        onConfirmPressed: () {
                          if (state.selectedSpot != null &&
                              state.markerPosition != null) {
                            Navigator.pop(
                              context,
                              {
                                'lat': state.markerPosition!.latitude,
                                'lng': state.markerPosition!.longitude,
                                'address': state.address,
                                'selectedSpot': state.selectedSpot,
                                'selectedSpotDetails':
                                    state.selectedSpotDetails,
                              },
                            );
                          }
                        },
                        onSpotSelected: cubit.selectSpot,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
