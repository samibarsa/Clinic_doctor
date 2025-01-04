import 'package:doctor_app/Features/Home/presentation/view/order_view_detiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';

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
    required this.order,
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
  final Order order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              if (widget.patient.phoneNumber != null &&
                  widget.patient.phoneNumber != "لا يوجد")
                TableItem(
                  title: 'رقم هاتف المريض',
                  value: widget.patient.phoneNumber!,
                  topradius: 0,
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
              if (widget.order.detail.option.optionName ==
                  "ساحة 5*5 مميزة للبية")
                TableItem(
                  title: "رقم السن",
                  value: widget.order.toothNumber.toString(),
                  topradius: 0,
                  buttomradius: 0,
                ),
              if (selectedImageType != 'بانوراما' &&
                  widget.order.detail.mode?.modeName != null &&
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
              if (price != 0)
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
              SizedBox(height: 40.h),
              ShowOrderState(order: order)
            ],
          ),
        ),
      ),
    );
  }
}

class ShowOrderState extends StatelessWidget {
  const ShowOrderState({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color:
                order.isImaged ? Colors.green.shade100 : Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                order.isImaged ? Icons.check_circle : Icons.access_time_filled,
                color: order.isImaged ? Colors.green : Colors.amber,
                size: 24.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  order.isImaged
                      ? 'تم إتمام عملية التصوير بنجاح.'
                      : 'بانتظار وصول المريض لاستكمال إجراءات الطلب.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: order.isImaged
                        ? Colors.green.shade800
                        : Colors.amber.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
