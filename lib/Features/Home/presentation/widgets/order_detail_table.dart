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
        if (patientNameController.text != "لا يوجد")
          TableItem(
            title: 'اسم المريض',
            value: patientNameController.text,
            topradius: 12.r,
            buttomradius: 0,
          ),
        if (patientAge.toString() != "لا يوجد")
          TableItem(
            title: 'العمر',
            value: patientAge.toString(),
            topradius: 0,
            buttomradius: 0,
          ),
        if (widget.patient.phoneNumber != "لا يوجد")
          TableItem(
            title: 'رقم هاتف المريض',
            value: widget.patient.phoneNumber!,
            topradius: 12.r,
            buttomradius: 0,
          ),
        if (doctorName != "لا يوجد")
          TableItem(
            title: 'اسم الطبيب',
            value: doctorName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (widget.order.detail.type.typeName != "لا يوجد")
          TableItem(
            title: 'نوع الصورة',
            value: widget.order.detail.type.typeName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (widget.order.detail.option.optionName != "لا يوجد")
          TableItem(
            title: 'الجزء المراد تصويره',
            value: widget.order.detail.option.optionName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (widget.order.detail.type.typeName != "C.B.C.T")
          TableItem(
            title: 'شكل الصورة',
            value: widget.order.output.outputType,
            topradius: 0,
            buttomradius: 0,
          ),
        if (widget.order.detail.option.optionName == "ساحة 5*5 مميزة للبية")
          TableItem(
              title: "رقم السن",
              value: widget.order.toothNumber.toString(),
              topradius: 0,
              buttomradius: 0),
        if (selectedImageType != 'بانوراما' &&
            widget.order.detail.mode!.modeName != "لا يوجد")
          TableItem(
            title: 'وضعية الصورة',
            value: widget.order.detail.mode!.modeName,
            topradius: 0,
            buttomradius: 0,
          ),
        if (date != "لا يوجد")
          TableItem(
            title: 'التاريخ',
            value: date,
            topradius: 0,
            buttomradius: 0,
          ),
        if (time != "لا يوجد")
          TableItem(
            title: 'التوقيت',
            value: time,
            topradius: 0,
            buttomradius: 0,
          ),
        if (price.toString() != "لا يوجد")
          TableItem(
            title: 'الفاتورة',
            value: "$price ل.س",
            topradius: 0,
            buttomradius: 0,
          ),
        if (additionalNotesController.text != "لا يوجد")
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
