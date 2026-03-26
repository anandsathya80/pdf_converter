import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pdf_cubit.dart';
import '../cubit/pdf_state.dart';
import 'pdf_preview_page.dart';

class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Scan to PDF"),
        centerTitle: true,
        elevation: 0,
      ),

      body: BlocListener<PdfCubit, PdfState>(
        listener: (context, state) {
          if (state is PdfPreview) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PdfPreviewPage(path: state.path),
              ),
            );
          }
        },

        child: BlocBuilder<PdfCubit, PdfState>(
          builder: (context, state) {

            if (state is PdfLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is PdfLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: state.images.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (_, i) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Image.file(
                                File(state.images[i].path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black54,
                                  child: Text(
                                    "${i + 1}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () =>
                          context.read<PdfCubit>().createPdf(),
                      child: Text("Convert to PDF"),
                    ),
                  )
                ],
              );
            }

            return Center(
              child: Text("Ambil gambar dulu 📸"),
            );
          },
        ),
      ),

      // 🔥 Bottom Action Bar
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [

              // Camera
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () =>
                      context.read<PdfCubit>().captureMultipleImages(),
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                ),
              ),

              SizedBox(width: 10),

              // Gallery
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () =>
                      context.read<PdfCubit>().pickImages(),
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}