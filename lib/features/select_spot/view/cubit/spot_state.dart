import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotsState {
  final LatLng? markerPosition;
  final String? address;
  final String? streetName;
  final String? fullAddress;
  final CameraPosition? initialCameraPosition;
  final Set<Marker> markers;
  final bool isMapLoaded;
  final bool isAddressSelected;
  final String? selectedSpot;
  final Map<String, dynamic>? selectedSpotDetails;

  SpotsState({
    this.markerPosition,
    this.address,
    this.streetName,
    this.fullAddress,
    this.initialCameraPosition,
    this.markers = const {},
    this.isMapLoaded = false,
    this.isAddressSelected = false,
    this.selectedSpot,
    this.selectedSpotDetails,
  });

  SpotsState copyWith({
    LatLng? markerPosition,
    String? address,
    String? streetName,
    String? fullAddress,
    CameraPosition? initialCameraPosition,
    Set<Marker>? markers,
    bool? isMapLoaded,
    bool? isAddressSelected,
    String? selectedSpot,
    Map<String, dynamic>? selectedSpotDetails,
  }) {
    return SpotsState(
      markerPosition: markerPosition ?? this.markerPosition,
      address: address ?? this.address,
      streetName: streetName ?? this.streetName,
      fullAddress: fullAddress ?? this.fullAddress,
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      markers: markers ?? this.markers,
      isMapLoaded: isMapLoaded ?? this.isMapLoaded,
      isAddressSelected: isAddressSelected ?? this.isAddressSelected,
      selectedSpot: selectedSpot ?? this.selectedSpot,
      selectedSpotDetails: selectedSpotDetails ?? this.selectedSpotDetails,
    );
  }
}
