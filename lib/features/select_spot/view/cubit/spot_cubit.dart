import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qafeel/core/constants/widgets/print_util.dart';
import 'package:qafeel/core/cubit/global_cubit.dart';
import 'package:qafeel/core/locale/app_loacl.dart';

import 'spot_state.dart';

class SpotsCubit extends Cubit<SpotsState> {
  SpotsCubit() : super(SpotsState());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final List<Map<String, dynamic>> _availableSpots = [
    {
      'spot': 'A1',
      'meterDistance': '100',
      'streetName': 'Main St',
      'partWayName': 'Side A',
      'wayNumber': '12'
    },
    {
      'spot': 'A6',
      'meterDistance': '150',
      'streetName': 'Park Ave',
      'partWayName': 'Side B',
      'wayNumber': '15'
    },
    {
      'spot': 'B3',
      'meterDistance': '200',
      'streetName': 'Central Rd',
      'partWayName': 'Side C',
      'wayNumber': '20'
    },
    {
      'spot': 'C5',
      'meterDistance': '250',
      'streetName': 'Broadway',
      'partWayName': 'Side D',
      'wayNumber': '25'
    },
  ];
  final List<Map<String, dynamic>> _currentlyClosedSpots = [
    {
      'spot': 'D1',
      'meterDistance': '300',
      'streetName': 'Closed St',
      'partWayName': 'Side E',
      'wayNumber': '30'
    },
    {
      'spot': 'D2',
      'meterDistance': '350',
      'streetName': 'Closed Ave',
      'partWayName': 'Side F',
      'wayNumber': '35'
    },
  ];
  final List<Map<String, dynamic>> _lockedSpots = [
    {
      'spot': 'K1',
      'meterDistance': '400',
      'streetName': 'Locked Rd',
      'partWayName': 'Side G',
      'wayNumber': '40'
    },
    {
      'spot': 'L2',
      'meterDistance': '450',
      'streetName': 'Locked St',
      'partWayName': 'Side H',
      'wayNumber': '45'
    },
  ];

  void initializeLocation(BuildContext context) {
    if (state.markerPosition != null && state.initialCameraPosition != null) {
      return;
    }
    final globalCubit = context.read<GlobalCubit>();
    if (globalCubit.currentLat == 0.0 && globalCubit.currentLong == 0.0) {
      globalCubit.getCurrentLocation();
    }

    final lat =
        (globalCubit.currentLat == 0.0) ? 25.276987 : globalCubit.currentLat;
    final lng =
        (globalCubit.currentLong == 0.0) ? 55.296249 : globalCubit.currentLong;
    final address =
        globalCubit.currentLocation ?? 'unknown_address'.tr(context);

    emit(state.copyWith(
      markerPosition: LatLng(lat, lng),
      address: address,
      fullAddress: address,
      streetName: '',
      initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 17),
      markers: {
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: LatLng(lat, lng),
          infoWindow: const InfoWindow(title: 'selected_location'),
        ),
      },
    ));

    if (lat != 0.0 && lng != 0.0) {
      _getAddressFromLatLng(position: LatLng(lat, lng), context: context);
    }
  }

  void updateMarker(CameraPosition position) {
    emit(state.copyWith(markerPosition: position.target));
  }

  Future<void> getAddressFromLatLng(BuildContext context) async {
    if (state.markerPosition == null) return;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        state.markerPosition!.latitude,
        state.markerPosition!.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}";
        emit(state.copyWith(address: address, isAddressSelected: true));
      }
    } catch (e) {
      debugPrint("Error in reverse geocoding: $e");
    }
  }

  Future<void> _getAddressFromLatLng({
    required LatLng position,
    required BuildContext context,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final fullAddress =
            '${place.name ?? ''}, ${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}'
                .replaceAll(RegExp(r', ,'), ',')
                .replaceAll(RegExp(r',,'), ',')
                .replaceAll(RegExp(r'^, '), '');

        emit(state.copyWith(
          streetName: place.street ?? 'unknown_street'.tr(context),
          fullAddress: fullAddress,
          address: fullAddress,
          isAddressSelected: true,
        ));
      } else {
        emit(state.copyWith(
          streetName: 'unknown_street'.tr(context),
          fullAddress: 'unknown_address'.tr(context),
          address: 'unknown_address'.tr(context),
          isAddressSelected: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        streetName: 'unknown_street'.tr(context),
        fullAddress: 'unknown_address'.tr(context),
        address: 'unknown_address'.tr(context),
        isAddressSelected: false,
      ));
    }
  }

  void loadMapStyle(GoogleMapController controller, BuildContext context) {
    if (!state.isMapLoaded && !isClosed) {
      DefaultAssetBundle.of(context)
          .loadString("assets/map_styles/light.json")
          .then((style) {
        if (!isClosed) {
          controller.setMapStyle(style);
          emit(state.copyWith(isMapLoaded: true));
        }
      }).catchError((error) {
        PrintUtil.error("Error loading map style: $error");
        if (!isClosed) {
          emit(state.copyWith(isMapLoaded: true));
        }
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted && !isClosed) {
      _controller.complete(controller);
    }
  }

  void onCameraMove(CameraPosition position, BuildContext context) async {
    if (isClosed) return;
    final newPosition =
        LatLng(position.target.latitude, position.target.longitude);

    emit(state.copyWith(
      markerPosition: newPosition,
      markers: {
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: newPosition,
          infoWindow: const InfoWindow(title: 'selected_location'),
        ),
      },
    ));

    // fetch new address
    if (newPosition.latitude != 0.0 && newPosition.longitude != 0.0) {
      await _getAddressFromLatLng(position: newPosition, context: context);
    }
  }

  void selectSpot(String spot) {
    if (isClosed) return;
    final selectedSpotData = [
      ..._availableSpots,
      ..._currentlyClosedSpots,
      ..._lockedSpots
    ].firstWhere((s) => s['spot'] == spot,
        orElse: () => {
              'spot': spot,
              'meterDistance': '0',
              'streetName': '',
              'partWayName': '',
              'wayNumber': ''
            });
    if (!isClosed) {
      emit(state.copyWith(
        selectedSpot: spot,
        selectedSpotDetails: selectedSpotData,
      ));
    }
  }

  List<Map<String, dynamic>> get availableSpots => _availableSpots;
  List<Map<String, dynamic>> get currentlyClosedSpots => _currentlyClosedSpots;
  List<Map<String, dynamic>> get lockedSpots => _lockedSpots;

  GoogleMapController? get mapController => _controller.isCompleted
      ? _controller.future as GoogleMapController
      : null;
}
