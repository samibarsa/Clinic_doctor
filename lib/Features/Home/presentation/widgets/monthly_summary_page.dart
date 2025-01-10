import 'dart:io';
import 'package:doctor_app/Features/Home/presentation/widgets/summary_body.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/summary_body_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class MonthlySummaryPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> monthlySummary;
  final String doctorName;

  const MonthlySummaryPage(
      {super.key, required this.monthlySummary, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ملخص الجرد الشهري",
                style: TextStyle(fontSize: 18.sp),
              ),
              if (doctorName.isNotEmpty)
                Text(
                  "دكتور: $doctorName",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePdf(context), // زر المشاركة
          ),
        ],
      ),
      body: SummaryBody(
        monthlySummary: monthlySummary,
        doctorName: doctorName,
      ),
    );
  }

  Future<void> _sharePdf(BuildContext context) async {
    try {
      final pdf = pw.Document();
      final fontData = await rootBundle.load("asset/fonts/Cairo-Regular.ttf");
      final font = pw.Font.ttf(fontData);

      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(base: font),
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(16.0),
                child: SummaryBodyPdf(
                  monthlySummary: monthlySummary,
                  doctorName: doctorName,
                ),
              ),
            );
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/monthly_summary_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      final xFile = XFile(filePath);

      await Share.shareXFiles([xFile], text: 'إليك ملخص الجرد الشهري');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل المشاركة: $e")),
      );
    }
  }
}
