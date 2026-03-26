import '../repositories/pdf_repository.dart';
import '../entities/image_entity.dart';

class CreatePdfUseCase {
  final PdfRepository repository;

  CreatePdfUseCase(this.repository);

  Future<String> call(List<ImageEntity> images) {
    return repository.createPdf(images);
  }
}
