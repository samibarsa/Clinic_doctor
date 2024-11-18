import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/order_detail_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.order,
    required this.doctor,
    required this.patient,
  });

  final Order order;
  final Doctor doctor;
  final Patient patient;

  @override
  // ignore: library_private_types_in_public_api
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late final TextEditingController patientNameController;
  late final TextEditingController outputTypeController;
  late final TextEditingController additionalNotesController;

  late final String doctorName;
  late final int patientAge;
  late final String date;
  late final String time;

  String? selectedImageType;
  String? selectedExaminationOption;
  String? selectedOutputType;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeOrderDetails();
  }

  void _initializeControllers() {
    patientNameController = TextEditingController(text: widget.patient.name);
    outputTypeController = TextEditingController(
      text: widget.order.detail.mode?.modeName ?? "لا يوجد",
    );
    additionalNotesController = TextEditingController(
      text: widget.order.additionalNotes,
    );
  }

  void _initializeOrderDetails() {
    doctorName = widget.doctor.name;
    date = widget.order.date.toString().split(' ')[0];
    time = widget.order.date.toString().split(' ')[1].split('.')[0];
    patientAge = widget.patient.age;
  }

  @override
  void dispose() {
    patientNameController.dispose();
    outputTypeController.dispose();
    additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'معلومات الطلب',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 34.h),
            OrderDetailTable(
              patientNameController: patientNameController,
              doctorName: doctorName,
              patientAge: patientAge,
              widget: widget,
              selectedImageType: selectedImageType,
              date: date,
              time: DateFormat('hh:mm a').format(widget.order.date),
              additionalNotesController: additionalNotesController,
              price: widget.order.price,
            ),
          ],
        ),
      ),
    );
  }
}
