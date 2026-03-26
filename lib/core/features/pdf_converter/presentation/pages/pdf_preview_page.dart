import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewPage extends StatelessWidget {
  final String path;

  const PdfPreviewPage({required this.path});

  void sharePdf() {
    Share.shareXFiles([XFile(path)], text: "Converted PDF");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview PDF"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: sharePdf,
          )
        ],
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}