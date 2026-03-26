import '../entities/image_entity.dart';

abstract class PdfRepository {
  Future<List<ImageEntity>> pickImages();
  Future<String> createPdf(List<ImageEntity> images);
  Future<ImageEntity?> pickSingleImageFromCamera();
}
