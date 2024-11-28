import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryBody extends StatelessWidget {
  final Map<String, Map<String, dynamic>> monthlySummary;
  final String doctorName;

  const SummaryBody(
      {super.key, required this.monthlySummary, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 14.h),
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
            Divider(
              color: Colors.green[400],
            ),
            SizedBox(
              height: 20.h,
            ),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    _buildTableRow(
                        title: "الشهر",
                        value: monthYear,
                        buttomradius: 0,
                        topradius: 6.r),
                    _buildTableRow(
                        title: "عدد الطلبات",
                        value: data['orderCount'].toString(),
                        buttomradius: 0,
                        topradius: 6.r),
                    _buildTableRow(
                        title: "إجمالي الفواتير",
                        value: "${data['totalPrice'].toStringAsFixed(2)} ل.س",
                        buttomradius: 0,
                        topradius: 6.r),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTypeSummary() {
    return Column(
      children: [
        _buildTableRow(
          title: "نوع الطلب",
          value: "عدد الطلبات",
          buttomradius: 0,
          topradius: 6.r,
        ),
        _buildTableRow(
          title: "بانوراما",
          value: "${monthlySummary['orderTypeCount']?['بانوراما'] ?? 0}",
          buttomradius: 0,
          topradius: 0,
        ),
        _buildTableRow(
          title: "سيفالوماتريك",
          value: "${monthlySummary['orderTypeCount']?['سيفالوماتريك'] ?? 0}",
          buttomradius: 0,
          topradius: 0,
        ),
        _buildTableRow(
          title: "C.BC.T",
          value: "${monthlySummary['orderTypeCount']?['C.BC.T'] ?? 0}",
          buttomradius: 6.r,
          topradius: 0,
        ),
      ],
    );
  }

  TableItem _buildTableRow(
      {required String title,
      required String value,
      required double buttomradius,
      required double topradius}) {
    return TableItem(
      buttomradius: buttomradius,
      title: title,
      value: value,
      topradius: topradius,
    );
  }
}
