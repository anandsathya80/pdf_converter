import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/pdf_repository.dart';
import '../../domain/usecases/create_pdf_usecase.dart';
import 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  final PdfRepository repository;
  final CreatePdfUseCase createPdfUseCase;

  PdfCubit(this.repository, this.createPdfUseCase) : super(PdfInitial());

  List<ImageEntity> images = [];

  Future<void> pickImages() async {
    emit(PdfLoading());
    try {
      images = await repository.pickImages();
      emit(PdfLoaded(images));
    } catch (e) {
      emit(PdfError(e.toString()));
    }
  }

  Future<void> createPdf() async {
    emit(PdfLoading());
    try {
      final path = await createPdfUseCase(images);
      emit(PdfPreview(path));
    } catch (e) {
      emit(PdfError(e.toString()));
    }
  }

  Future<void> captureMultipleImages() async {
    emit(PdfLoading());
    try {
      images = [];

      bool keepTaking = true;

      while (keepTaking) {
        final picked = await repository.pickSingleImageFromCamera();

        if (picked != null) {
          images.add(picked);
        }

        // stop kalau user cancel
        keepTaking = picked != null;
      }

      emit(PdfLoaded(images));
    } catch (e) {
      emit(PdfError(e.toString()));
    }
  }
}
