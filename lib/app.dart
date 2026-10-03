import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_routes.dart';
import 'package:flutter_device_features/core/theme/app_theme.dart';
import 'package:flutter_device_features/features/audio/presentation/audio_screen.dart';
import 'package:flutter_device_features/features/device_info/presentation/device_info_screen.dart';
import 'package:flutter_device_features/features/gallery/presentation/gallery_screen.dart';
import 'package:flutter_device_features/features/home/presentation/home_screen.dart';
import 'package:flutter_device_features/features/maps/presentation/google_map_screen.dart';
import 'package:flutter_device_features/features/profile/presentation/profile_screen.dart';

class DeviceFeaturesApp extends StatelessWidget {
  const DeviceFeaturesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Features',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.deviceInfo: (_) => const DeviceInfoScreen(),
        AppRoutes.gallery: (_) => const GalleryScreen(),
        AppRoutes.map: (_) => const GoogleMapScreen(),
        AppRoutes.audio: (_) => const AudioScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}
