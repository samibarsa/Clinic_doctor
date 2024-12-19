import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SummaryBodyPdf extends pw.StatelessWidget {
  final Map<String, Map<String, dynamic>> monthlySummary;
  final String doctorName;

  SummaryBodyPdf({required this.monthlySummary, required this.doctorName});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
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
    );
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
        ]);
  }
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
