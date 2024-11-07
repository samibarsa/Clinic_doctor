import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailes extends StatelessWidget {
  const OrderDetailes({super.key, required this.order, required this.doctor});
  final Order order;
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    String dateTime = order.date.toString();
    var parts = dateTime.split(' ');
    String date = parts[0];
    String timefake = parts[1];
    var partTime = timefake.split('.');
    String time = partTime[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'معلومات الطلب',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableItem(
            title: 'اسم المريض',
            value: order.patientName,
            topradius: 12,
            buttomradius: 0,
          ),
          TableItem(
            title: 'اسم الطبيب',
            value: doctor.name,
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'نوع الصورة',
            value: order.type,
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'العمر',
            value: "${order.patientAge}",
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'الجزء المراد تصويره',
            value: order.examinationOptions ?? "لا يوجد",
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'شكل الصورة',
            value: order.outputType ?? "لا يوجد",
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'التاريخ',
            value: date,
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'التوقيت',
            value: time,
            topradius: 0,
            buttomradius: 0,
          ),
          TableItem(
            title: 'ملاحظات',
            value: order.additionalNotes ?? "لا يوجد",
            topradius: 0,
            buttomradius: 12,
          ),
        ],
      ),
    );
  }
}
