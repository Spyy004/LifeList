import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifelist/extensions/string_extensions.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/index.dart';

class PdfService extends ChangeNotifier {
  int ct = 0;
  generatePdf(Bucket bucket, List<Task?> tasks) async {
    final bucketPDF = pw.Document();
    final assetImage = pw.MemoryImage(
      (await rootBundle.load('assets/app_logo.png')).buffer.asUint8List(),
    );
    bucketPDF.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(width: 2, color: PdfColors.black)),
              ),
              child: pw.Row(
                children: [
                  pw.Image(
                    assetImage,
                    width: 40,
                    height: 40,
                    alignment: pw.Alignment.centerLeft,
                  ),
                  pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                  pw.Text(
                    bucket.name.capitalize(),
                    style: const pw.TextStyle(
                        fontSize: 42, color: PdfColors.purple),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
            pw.Paragraph(
                text: "Description: ${bucket.description}",
                style:
                    const pw.TextStyle(fontSize: 24, color: PdfColors.black)),
            pw.Divider(color: PdfColors.black, thickness: 1),
            pw.Row(
              children: [
                pw.Text(
                  "Category: ${bucket.bucketCategory.name.capitalize()}",
                  style:
                      const pw.TextStyle(fontSize: 16, color: PdfColors.black),
                ),
                pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                pw.Text(
                  'Deadline: ${bucket.deadline.year}/${bucket.deadline.month}/${bucket.deadline.day}',
                  style:
                      const pw.TextStyle(fontSize: 16, color: PdfColors.black),
                ),
                pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                pw.Text(
                  bucket.isCompleted
                      ? "Status: Completed"
                      : "Status: Not Completed",
                  style:
                      const pw.TextStyle(fontSize: 16, color: PdfColors.black),
                ),
              ],
            ),
            pw.Divider(color: PdfColors.black, thickness: 1),
            pw.Header(
              child: pw.Text(
                'Tasks',
                style: pw.TextStyle(
                  fontSize: 32,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              padding: const pw.EdgeInsets.all(4),
            ),
            pw.ListView(
                children: tasks
                    .map((task) => pw.Bullet(
                          text: task!.name,
                          textAlign: pw.TextAlign.left,
                          bulletColor: PdfColors.purple,
                          bulletMargin: const pw.EdgeInsets.all(8),
                          style: const pw.TextStyle(
                            fontSize: 24,
                            color: PdfColors.black,
                          ),
                        ))
                    .toList()),
          ]; // Center
        }));
    await downloadPdf(bucket, bucketPDF); //
  }

  downloadPdf(Bucket bucket, pw.Document bucketPDF) async {
    Fluttertoast.showToast(msg: 'Downloading PDF...');
    final bytes = await bucketPDF.save().onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      Uint8List x = Uint8List(0);
      return x;
    });
    if (bytes.isEmpty) return;
    var output = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final pdfFile = File("$output/${bucket.name + bucket.id.toString()}.pdf");
    await pdfFile.writeAsBytes(bytes);
    OpenFile.open(pdfFile.path);
  }
}
