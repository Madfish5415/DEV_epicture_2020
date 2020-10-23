import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickerRepository {
  final ImagePicker _picker = ImagePicker();

  Future<File> getCameraImage() async {
    return _getImage(ImageSource.camera);
  }

  Future<File> getGalleryImage() async {
    return _getImage(ImageSource.gallery);
  }

  Future<File> _getImage(ImageSource imageSource) async {
    final PickedFile pickedFile = await _picker.getImage(source: imageSource);

    if (pickedFile == null) {
      throw Exception("No picked image");
    }

    return File(pickedFile.path);
  }
}
