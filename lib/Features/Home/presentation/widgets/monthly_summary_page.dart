import 'dart:io';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MonthlySummaryPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> monthlySummary;
  final String doctorName;

  MonthlySummaryPage(
      {super.key, required this.monthlySummary, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
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
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _sharePdf(context), // زر المشاركة
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "تفاصيل الطلبات حسب النوع",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildOrderTypeSummary(),
                SizedBox(height: 24.h),
                const Divider(),
                Text(
                  "تفاصيل الجرد الشهري",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                ...monthlySummary.entries.map((entry) {
                  if (entry.key == "orderTypeCount") {
                    return const SizedBox.shrink();
                  }
                  final monthYear = entry.key;
                  final data = entry.value;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      title: Text("الشهر: $monthYear"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("عدد الطلبات: ${data['orderCount']}"),
                          Text(
                              "إجمالي الفواتير: ${data['totalPrice'].toStringAsFixed(2)} ل.س"),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderTypeSummary() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Table(
        border: TableBorder.all(color: Colors.grey.withOpacity(0.5)),
        columnWidths: const {
          0: FractionColumnWidth(0.4),
          1: FractionColumnWidth(0.2),
        },
        children: [
          _buildTableRow(
            title: "نوع الطلب",
            value: "عدد الطلبات",
            isHeader: true,
          ),
          _buildTableRow(
            title: "بانوراما",
            value: "${monthlySummary['orderTypeCount']?['بانوراما'] ?? 0}",
          ),
          _buildTableRow(
            title: "سيفالوماتريك",
            value: "${monthlySummary['orderTypeCount']?['سيفالوماتريك'] ?? 0}",
          ),
          _buildTableRow(
            title: "C.BC.T",
            value: "${monthlySummary['orderTypeCount']?['C.BC.T'] ?? 0}",
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(
      {required String title, required String value, bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: isHeader ? 16.sp : 14.sp,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: isHeader ? 16.sp : 14.sp,
            ),
          ),
        ),
      ],
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
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "ملخص الجرد الشهري",
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    if (doctorName.isNotEmpty)
                      pw.Text(
                        "دكتور: $doctorName",
                        style: const pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    pw.SizedBox(height: 16),
                    pw.Text(
                      "تفاصيل الطلبات حسب النوع",
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    pw.SizedBox(height: 16),
                    _buildOrderTypeSummaryPdf(),
                    pw.SizedBox(height: 24),
                    pw.Divider(),
                    pw.Text(
                      "تفاصيل الجرد الشهري",
                      style: const pw.TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    ...monthlySummary.entries.map((entry) {
                      if (entry.key == "orderTypeCount") {
                        return pw.SizedBox.shrink();
                      }
                      final monthYear = entry.key;
                      final data = entry.value;
                      return pw.Container(
                        margin: const pw.EdgeInsets.symmetric(vertical: 8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("الشهر: $monthYear"),
                            pw.Text("عدد الطلبات: ${data['orderCount']}"),
                            pw.Text(
                                "إجمالي الفواتير: ${data['totalPrice'].toStringAsFixed(2)} ل.س"),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),
                  ],
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل المشاركة: $e")),
      );
    }
  }

  pw.Widget _buildOrderTypeSummaryPdf() {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      columnWidths: const {
        0: pw.FractionColumnWidth(0.4),
        1: pw.FractionColumnWidth(0.2),
      },
      children: [
        _buildTableRowPdf(
          title: "نوع الطلب",
          value: "عدد الطلبات",
          isHeader: true,
        ),
        _buildTableRowPdf(
          title: "بانوراما",
          value: "${monthlySummary['orderTypeCount']?['بانوراما'] ?? 0}",
        ),
        _buildTableRowPdf(
          title: "سيفالوماتريك",
          value: "${monthlySummary['orderTypeCount']?['سيفالوماتريك'] ?? 0}",
        ),
        _buildTableRowPdf(
          title: "C.BC.T",
          value: "${monthlySummary['orderTypeCount']?['C.BC.T'] ?? 0}",
        ),
      ],
    );
  }

  pw.TableRow _buildTableRowPdf(
      {required String title, required String value, bool isHeader = false}) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: isHeader ? 16 : 14,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: isHeader ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }
}
