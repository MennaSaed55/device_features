import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/features/maps/presentation/widgets/map_marker_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  static const LatLng _cairoPosition = LatLng(30.0444, 31.2357);
  static const String _locationName = 'Cairo Governorate';
  static const String _country = 'Egypt';

  @override
  Widget build(BuildContext context) {
    final cairoMarker = Marker(
      markerId: const MarkerId('cairo'),
      position: _cairoPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: _locationName, snippet: _country),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _cairoPosition,
              zoom: 11,
            ),
            markers: {cairoMarker},
          ),
          const Positioned(
            left: AppSpacing.medium,
            right: AppSpacing.medium,
            bottom: AppSpacing.large,
            child: SafeArea(
              child: MapMarkerInfo(title: _locationName, subtitle: _country),
            ),
          ),
        ],
      ),

    );
  }
}
