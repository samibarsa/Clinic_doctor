import 'package:doctor_app/Features/Home/presentation/view/order_view_detiles.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailTable extends StatelessWidget {
  const OrderDetailTable({
    super.key,
    required this.patientNameController,
    required this.doctorName,
    required this.patientAge,
    required this.widget,
    required this.selectedImageType,
    required this.date,
    required this.time,
    required this.additionalNotesController,
    required this.price,
  });

  final TextEditingController patientNameController;
  final String doctorName;
  final int patientAge;
  final OrderDetails widget;
  final String? selectedImageType;
  final String date;
  final String time;
  final TextEditingController additionalNotesController;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableItem(
          title: 'اسم المريض',
          value: patientNameController.text,
          topradius: 12.r,
          buttomradius: 0,
        ),
        TableItem(
          title: 'اسم الطبيب',
          value: doctorName,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'العمر',
          value: patientAge.toString(),
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'نوع الصورة',
          value: widget.order.detail.type.typeName,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'الجزء المراد تصويره',
          value: widget.order.detail.option.optionName,
          topradius: 0,
          buttomradius: 0,
        ),
        if (selectedImageType != 'بانوراما')
          TableItem(
            title: 'وضعية الصورة',
            value: widget.order.detail.mode!.modeName,
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
          title: 'الفاتورة',
          value: "$price ل.س",
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'ملاحظات',
          value: additionalNotesController.text,
          topradius: 0,
          buttomradius: 12.r,
        ),
      ],
    );
  }
}
