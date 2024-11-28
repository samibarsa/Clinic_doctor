import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

class MonthlySummaryPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> monthlySummary;
  final String doctorName;

  final ScreenshotController screenshotController = ScreenshotController();

  MonthlySummaryPage(
      {super.key, required this.monthlySummary, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Screenshot(
        controller: screenshotController,
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
                icon: const Icon(Icons.camera_alt),
                onPressed: () =>
                    _takeScreenshot(context), // زر التقاط لقطة الشاشة
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareScreenshot(context), // زر المشاركة
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
                                "إجمالي الفواتير: ${data['totalPrice'].toStringAsFixed(2)}"),
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

  Future<void> _takeScreenshot(BuildContext context) async {
    try {
      final image = await screenshotController.capture(); // التقاط الصورة
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

        final file = File(imagePath);
        await file.writeAsBytes(image);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم حفظ لقطة الشاشة: $imagePath")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل التقاط لقطة الشاشة: $e")),
      );
    }
  }

  Future<void> _shareScreenshot(BuildContext context) async {
    try {
      final image = await screenshotController.capture();
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

        final file = File(imagePath);
        await file.writeAsBytes(image);

        final xFile = XFile(imagePath);

        // مشاركة الصورة
        await Share.shareXFiles([xFile], text: 'إليك ملخص الجرد الشهري');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل المشاركة: $e")),
      );
    }
  }
}
