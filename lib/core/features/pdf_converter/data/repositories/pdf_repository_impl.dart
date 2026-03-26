import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/pdf_repository.dart';
import '../datasource/pdf_local_data_source.dart';
import '../models/image_model.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfLocalDataSource dataSource;

  PdfRepositoryImpl(this.dataSource);

  @override
  Future<List<ImageEntity>> pickImages() async {
    final files = await dataSource.pickImages();
    return files.map((e) => ImageModel(path: e.path)).toList();
  }

  @override
  Future<String> createPdf(List<ImageEntity> images) async {
    final pdf = pw.Document();

    for (var img in images) {
      final file = File(img.path);
      final image = pw.MemoryImage(file.readAsBytesSync());

      pdf.addPage(
        pw.Page(
          build: (_) => pw.Center(child: pw.Image(image)),
        ),
      );
    }

    final dir = await Directory.systemTemp.createTemp();
    final file = File("${dir.path}/result.pdf");

    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  @override
  Future<ImageEntity?> pickSingleImageFromCamera() async {
    final file = await dataSource.pickFromCamera();
    if (file == null) return null;

    return ImageModel(path: file.path);
  }
  
}
