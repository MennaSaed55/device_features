import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';

class EmptyGalleryView extends StatelessWidget {
  const EmptyGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.medium),
            Text('No images yet', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Tap Pick Image to choose photos from your gallery.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
