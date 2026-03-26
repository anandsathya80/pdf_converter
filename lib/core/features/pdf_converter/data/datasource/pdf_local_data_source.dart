import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PdfLocalDataSource {
  final ImagePicker picker;

  PdfLocalDataSource(this.picker);

  Future<List<File>> pickImages() async {
    final files = await picker.pickMultiImage();
    return files.map((e) => File(e.path)).toList();
  }

  Future<File?> pickFromCamera() async {
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    return file != null ? File(file.path) : null;
  }
}
