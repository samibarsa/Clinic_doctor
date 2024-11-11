import 'dart:convert';
import 'dart:developer';

import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  String selectedImageType = "سيفالوماتريك";
  String? selectedExaminationOption;
  String? selectedOutputType;

  final Map<String, List<String>> examinationOptions = {
    "سيفالوماتريك": ["Full lateral جانبية", "Carpus العمر العظمي"],
    "c.b.c.t": ["الفكين معاً", "الفك السفلي", "الفك العلوي"],
    "بانوراما": ["وضعية Bite Wing", "مفصل TMJ"],
  };

  final Map<String, List<String>> examinationMode = {
    "سيفالوماتريك": ["Forntal جبهية", "SMV وضعية"],
    "c.b.c.t": [
      "كامل الجمجمة",
      "ساحة 5×5 مميزة للبية",
      "إجراء دراسة للمقطع",
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

  void _showEditFieldsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildBottomSheetContent(),
    );
  }

  Future<void> updateOrderFields(
      int orderId, Map<String, dynamic> fieldsToUpdate) async {
    final supabase = Supabase.instance.client;

    try {
      final updateResult = await supabase
          .from('orders')
          .update(fieldsToUpdate)
          .eq('order_id', orderId);

      if (updateResult.error != null) {
        throw Exception(
            'Failed to update fields: ${updateResult.error!.message}');
      } else {
        print('Fields updated successfully');
      }
    } catch (error) {
      print('Error updating fields: $error');
    }
  }

  Future<int?> getDetailId(
      String modeName, String typeName, String optionName) async {
    // قراءة الملف كـ String
    final String response = await rootBundle.loadString(FilesPath.detilesJson);

    // تحويل النص من JSON إلى قائمة من الكائنات
    final List<dynamic> data = json.decode(response);

    // البحث عن الكائن المطابق
    for (var item in data) {
      if (item['examinationmodes']['mode_name'] == modeName &&
          item['examinationtypes']['type_name'] == typeName &&
          item['examinationoptions']['option_name'] == optionName) {
        return item['detail_id'];
      }
    }

    // إذا لم يتم العثور على أي تطابق، قم بإرجاع null
    return null;
  }

  Widget _buildBottomSheetContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.w,
          right: 16.w,
          top: 16.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تعديل معلومات الطلب',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              _buildEditableTextField('اسم المريض', patientNameController),
              _buildNonEditableTextField('اسم الطبيب', doctorName),
              _buildDropdownField(
                label: 'نوع الصورة',
                value: selectedImageType,
                items: examinationOptions.keys.toList(),
                onChanged: (value) => _onImageTypeChanged(value),
              ),
              if (examinationOptions[selectedImageType] != null)
                _buildDropdownField(
                  label: 'اختار الجزء المراد تصويره',
                  value: selectedExaminationOption,
                  items: examinationOptions[selectedImageType]!,
                  onChanged: (value) => setState(() {
                    selectedExaminationOption = value;
                  }),
                ),
              if (selectedImageType != 'بانوراما' &&
                  examinationMode[selectedImageType] != null)
                _buildDropdownField(
                  label: 'اختار وضعية الصورة',
                  value: selectedOutputType,
                  items: examinationMode[selectedImageType]!,
                  onChanged: (value) => setState(() {
                    selectedOutputType = value;
                  }),
                ),
              _buildNonEditableTextField('التاريخ', date),
              _buildNonEditableTextField('التوقيت', time),
              _buildEditableTextField('ملاحظات', additionalNotesController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {}); // Refresh the UI
                  final detilId = await getDetailId(
                      selectedOutputType ?? "لا يوجد",
                      selectedImageType,
                      selectedExaminationOption!);
                  log(detilId.toString());
                  updateOrderFields(widget.order.orderId, {
                    'additional_notes': additionalNotesController.text,
                    'detiles_id': detilId
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: const Text('حفظ التغييرات'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
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
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: DropdownButton<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
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
      floatingActionButton: IconButton(
        onPressed: _showEditFieldsBottomSheet,
        icon: SvgPicture.asset(ImagesPath.editIcon),
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
          value: selectedImageType,
          topradius: 0,
          buttomradius: 0,
        ),
        TableItem(
          title: 'الجزء المراد تصويره',
          value: selectedExaminationOption ?? 'غير محدد',
          topradius: 0,
          buttomradius: 0,
        ),
        if (selectedImageType != 'بانوراما')
          TableItem(
            title: 'وضعية الصورة',
            value: selectedOutputType ?? 'غير محدد',
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