import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/index.dart';

class PdfService extends ChangeNotifier {
  final bucketPDF = pw.Document();

  generatePdf(Bucket bucket) async {
    bucketPDF.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(bucket.name),
          ); // Center
        }));
    await downloadPdf(); //
  }

  downloadPdf() async {
    final pdfFile = File("example.pdf");
    //final pdfFile = File('');
    await pdfFile.writeAsBytes(await bucketPDF.save());
  }
}
