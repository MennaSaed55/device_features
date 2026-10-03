import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<List<XFile>> pickImages() => _imagePicker.pickMultiImage();
}
