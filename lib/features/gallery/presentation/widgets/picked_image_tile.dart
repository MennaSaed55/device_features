import 'dart:io';

import 'package:flutter/material.dart';

class PickedImageTile extends StatelessWidget {
  const PickedImageTile({super.key, required this.imagePath});

  static const double _height = 220;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(imagePath),
        height: _height,
        width: double.infinity,
        fit: BoxFit.cover,
        cacheWidth: 1000,
        errorBuilder: (_, _, _) => const SizedBox(
          height: _height,
          child: Center(child: Icon(Icons.broken_image_outlined)),
        ),
      ),
    );
  }
}
