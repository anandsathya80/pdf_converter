import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'core/features/pdf_converter/data/datasource/pdf_local_data_source.dart';
import 'core/features/pdf_converter/data/repositories/pdf_repository_impl.dart';
import 'core/features/pdf_converter/domain/usecases/create_pdf_usecase.dart';
import 'core/features/pdf_converter/presentation/cubit/pdf_cubit.dart';
import 'core/features/pdf_converter/presentation/pages/pdf_page.dart';

void main() {
  final dataSource = PdfLocalDataSource(ImagePicker());
  final repository = PdfRepositoryImpl(dataSource);
  final useCase = CreatePdfUseCase(repository);

  runApp(MyApp(repository, useCase));
}

class MyApp extends StatelessWidget {
  final repository;
  final useCase;

  MyApp(this.repository, this.useCase);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PdfCubit(repository, useCase),
        child: PdfPage(),
      ),
    );
  }
}
