import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/view/home_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
  late final String patientAge;
  late final String date;
  late final String time;

  String? selectedImageType;
  String? selectedExaminationOption;
  String? selectedOutputType;

  final Map<String, List<String>> examinationOptions = {
    "سيفالوماتريك": ["Full lateral جانبية", "Carpus العمر العظمي"],
    "C.B.C.T": ["الفكين معاً", "الفك السفلي", "الفك العلوي"],
    "بانوراما": ["وضعية Bite Wing", "مفصل TMJ"],
  };

  final Map<String, List<String>> examinationMode = {
    "سيفالوماتريك": ["Forntal جبهية", "SMV وضعية"],
    "C.B.C.T": [
      "كامل الجمجمة",
      "ساحة 5×5 مميزة للبية",
      "إجراء دراسة كاملة للمقطع",
      "نصف فك"
    ],
  };

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeOrderDetails();
    _initializeSelections();
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
    patientAge = widget.order.patientAge.toString();
    date = widget.order.date.toString().split(' ')[0];
    time = widget.order.date.toString().split(' ')[1].split('.')[0];
  }

  void _initializeSelections() {
    selectedImageType =
        examinationOptions.containsKey(widget.order.detail.type.typeName)
            ? widget.order.detail.type.typeName
            : examinationOptions.keys.first;
    selectedExaminationOption = examinationOptions[selectedImageType]?.first;
    selectedOutputType = examinationMode[selectedImageType]?.first;
  }

  @override
  void dispose() {
    patientNameController.dispose();
    outputTypeController.dispose();
    additionalNotesController.dispose();
    super.dispose();
  }

  void _onImageTypeChanged(String? value) {
    if (value != null && value != selectedImageType) {
      setState(() {
        selectedImageType = value;
        selectedExaminationOption =
            examinationOptions[selectedImageType]?.first;
        selectedOutputType = examinationMode[selectedImageType]?.first;
      });
    }
  }

  Widget _buildEditableTextField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _buildNonEditableTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        enabled: false,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required void Function(void Function()) setState,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: DropdownButton<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: (newValue) {
          setState(() => onChanged(newValue));
        },
        isExpanded: true,
        underline: Container(),
        dropdownColor: Colors.white,
        hint: Text(label),
      ),
    );
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
            _buildOrderDetailTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailTable() {
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
          value: patientAge,
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
          title: 'ملاحظات',
          value: additionalNotesController.text,
          topradius: 0,
          buttomradius: 12.r,
        ),
      ],
    );
  }
}
