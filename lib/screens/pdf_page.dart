import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class PdfPage extends StatefulWidget {
  final String filePath; // Add a variable for file path

  const PdfPage({Key? key, required this.filePath}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  String localPath = "";
  late PdfController _pdfController;
  String? errorMessage; // Variable to store error message

  @override
  void initState() {
    super.initState();
    copyAsset(widget.filePath).then((path) {
      setState(() {
        localPath = path;
        _pdfController = PdfController(
          document: PdfDocument.openAsset(widget.filePath),
          initialPage: 1,
        );
      });
    }).catchError((error) {
      setState(() {
        errorMessage = 'Failed to load PDF: $error'; // Set the error message
      });
    });
  }

  Future<String> copyAsset(String assetPath) async {
    try {
      final fileName = assetPath.split('/').last;
      final docPath = (await getApplicationDocumentsDirectory()).path;
      final localPDFPath = "$docPath/$fileName";

      final file = File(localPDFPath);
      if (!(await file.exists())) {
        final data = await rootBundle.load(assetPath);
        final bytes = data.buffer.asUint8List();
        await file.writeAsBytes(bytes);
      }

      return localPDFPath;
    } catch (e) {
      throw Exception('Error copying asset: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: errorMessage != null
          ? Center(
              child: Text(errorMessage!)) // Show error message if there is one
          : localPath.isEmpty
              ? Center(child: CircularProgressIndicator())
              : PdfView(
                  controller: _pdfController,
                ),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}
