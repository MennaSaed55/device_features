import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.imageAsset,
    required this.fullName,
    required this.email,
  });

  final String imageAsset;
  final String fullName;
  final String email;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 56, backgroundImage: AssetImage(imageAsset)),
        const SizedBox(height: AppSpacing.medium),
        Text(fullName, style: textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.small),
        Text(email, style: textTheme.bodyLarge),
      ],
    );
  }
}
