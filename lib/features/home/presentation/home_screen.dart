import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_routes.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/core/widgets/app_section_title.dart';
import 'package:flutter_device_features/core/widgets/app_snack_bar.dart';
import 'package:flutter_device_features/core/widgets/feature_card.dart';
import 'package:flutter_device_features/features/profile/data/biometric_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BiometricService _biometricService = BiometricService();
  bool _isAuthenticating = false;

  void _openRoute(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  Future<void> _openProfile() async {
    if (_isAuthenticating) return;

    _isAuthenticating = true;
    final result = await _biometricService.authenticate();
    _isAuthenticating = false;

    if (!mounted) return;

    switch (result) {
      case BiometricResult.authenticated:
        _openRoute(AppRoutes.profile);
      case BiometricResult.rejected:
        showAppSnackBar(
          context,
          'Authentication was cancelled or the fingerprint was not recognised.',
        );
      case BiometricResult.unavailable:
        showAppSnackBar(
          context,
          'Fingerprint authentication is not available on this device.',
        );
      case BiometricResult.error:
        showAppSnackBar(
          context,
          'Authentication failed. Make sure a fingerprint is enrolled and try again.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Features'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: _openProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          const AppSectionTitle(title: 'Available features'),
          const SizedBox(height: AppSpacing.small),
          FeatureCard(
            icon: Icons.phone_android,
            title: 'Device Info',
            subtitle: 'Device model and operating system version',
            onTap: () => _openRoute(AppRoutes.deviceInfo),
          ),
          FeatureCard(
            icon: Icons.photo_library_outlined,
            title: 'Image Gallery',
            subtitle: 'Pick multiple images from your gallery',
            onTap: () => _openRoute(AppRoutes.gallery),
          ),
          FeatureCard(
            icon: Icons.map_outlined,
            title: 'Google Map',
            subtitle: 'Map with a marker on Cairo',
            onTap: () => _openRoute(AppRoutes.map),
          ),
          FeatureCard(
            icon: Icons.mic_none,
            title: 'Audio Recorder',
            subtitle: 'Record your voice and play it back',
            onTap: () => _openRoute(AppRoutes.audio),
          ),
          FeatureCard(
            icon: Icons.fingerprint,
            title: 'Profile',
            subtitle: 'Protected by fingerprint authentication',
            onTap: _openProfile,
          ),
        ],
      ),
    );
  }
}
