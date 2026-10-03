import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/features/gallery/presentation/widgets/picked_image_tile.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageList extends StatelessWidget {
  const PickedImageList({super.key, required this.images});

  final List<XFile> images;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.medium),
      itemCount: images.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.medium),
      itemBuilder: (context, index) =>
          PickedImageTile(imagePath: images[index].path),
    );
  }
}
