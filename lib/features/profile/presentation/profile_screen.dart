import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_assets.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/features/profile/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _fullName = 'Sara Ahmed';
  static const String _email = 'sara.ahmed@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.large),
        child: Align(
          alignment: Alignment.topCenter,
          child: ProfileHeader(
            imageAsset: AppAssets.profileImage,
            fullName: _fullName,
            email: _email,
          ),
        ),
      ),
    );
  }
}
