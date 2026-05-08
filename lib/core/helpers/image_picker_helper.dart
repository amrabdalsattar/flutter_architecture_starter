import 'dart:io';
import 'package:image_picker/image_picker.dart';

final class ImagePickHelper {
  static bool _isPicking = false;

  static Future<File?> pickImage(ImageSource source) async {
    if (_isPicking) return null;
    _isPicking = true;

    try {
      final XFile? file = await ImagePicker().pickImage(
        source: source,
        requestFullMetadata: false,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (file == null) return null;

      // 🔹 Validate extension without path package
      final dotIndex = file.path.lastIndexOf('.');
      final ext = (dotIndex != -1
          ? file.path.substring(dotIndex).toLowerCase()
          : '');

      const allowed = ['.jpg', '.jpeg', '.png'];

      if (!allowed.contains(ext)) {
        throw const FormatException(
          'Invalid image type. Only JPG and PNG are allowed.',
        );
      }

      return File(file.path);
    } finally {
      _isPicking = false; // reset state
    }
  }

  static Future<File?> pickImageFromCamera() async {
    return pickImage(ImageSource.camera);
  }

  static Future<File?> pickImageFromGallery() async {
    return pickImage(ImageSource.gallery);
  }
}
