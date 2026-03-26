import '../../domain/entities/image_entity.dart';

abstract class PdfState {}

class PdfInitial extends PdfState {}

class PdfLoading extends PdfState {}

class PdfLoaded extends PdfState {
  final List<ImageEntity> images;

  PdfLoaded(this.images);
}

class PdfPreview extends PdfState {
  final String path;

  PdfPreview(this.path);
}

class PdfError extends PdfState {
  final String message;

  PdfError(this.message);
}