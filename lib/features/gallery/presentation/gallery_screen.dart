import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/core/widgets/app_button.dart';
import 'package:flutter_device_features/core/widgets/app_snack_bar.dart';
import 'package:flutter_device_features/features/gallery/data/image_picker_service.dart';
import 'package:flutter_device_features/features/gallery/presentation/widgets/empty_gallery_view.dart';
import 'package:flutter_device_features/features/gallery/presentation/widgets/picked_image_list.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  List<XFile> _images = [];
  bool _isPicking = false;

  Future<void> _pickImages() async {
    setState(() => _isPicking = true);

    List<XFile> pickedImages = const [];
    String? errorMessage;
    try {
      pickedImages = await _imagePickerService.pickImages();
    } on PlatformException catch (error) {
      errorMessage = error.message ?? 'Unable to open the gallery.';
    }

    if (!mounted) return;

    setState(() {
      _isPicking = false;
      _images = [..._images, ...pickedImages];
    });

    if (errorMessage != null) {
      showAppSnackBar(context, errorMessage);
    } else if (pickedImages.isEmpty) {
      showAppSnackBar(context, 'No images selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Column(
        children: [
          Expanded(
            child: _images.isEmpty
                ? const EmptyGalleryView()
                : PickedImageList(images: _images),
          ),
          SafeArea(
            minimum: const EdgeInsets.all(AppSpacing.medium),
            child: AppButton(
              label: 'Pick Image',
              icon: Icons.add_photo_alternate_outlined,
              onPressed: _isPicking ? null : _pickImages,
            ),
          ),
        ],
      ),
    );
  }
}
