import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/table_item.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails(
      {super.key,
      required this.order,
      required this.doctor,
      required this.patient});
  final Order order;
  final Doctor doctor;
  final Patient patient;

  @override
  // ignore: library_private_types_in_public_api
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late TextEditingController patientNameController;
  late TextEditingController outputTypeController;
  late TextEditingController additionalNotesController;

  late final String doctorName;
  late final String patientAge;
  late final String date;
  late final String time;
  String selectedImageType = "سيفالومتريك";
  String? selectedExaminationOption;
  String? selectedOutputType;

  final Map<String, List<String>> examinationOptions = {
    "سيفالومتريك": ["Full lateral جانبية", "Carpus العمر العظمي"],
    "c.b.c.t": ["الفكين معاً", "الفك السفلي", "الفك العلوي"],
    "بانوراما": ["وضعية Bite Wing", "مفصل TMJ"],
  };

  final Map<String, List<String>> examinationMode = {
    "سيفالومتريك": ["Forntal جبهية", "SMV وضعية"],
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

    patientNameController = TextEditingController(text: widget.patient.name);
    outputTypeController = TextEditingController(
        text: widget.order.detail.mode!.modeName ?? "لا يوجد");
    additionalNotesController =
        TextEditingController(text: widget.order.additionalNotes ?? "لا يوجد");

    doctorName = widget.doctor.name;
    patientAge = widget.order.patientAge.toString();
    date = widget.order.date.toString().split(' ')[0];
    time = widget.order.date.toString().split(' ')[1].split('.')[0];
    selectedImageType = widget.order.detail.type.typeName;

    // تأكد من أن selectedExaminationOption يحتوي على قيمة صحيحة
    selectedExaminationOption = widget.order.detail.option.optionName;

    // تحقق من أنه تم تعيين القيمة بشكل صحيح (إذا كانت غير موجودة، اختر أول خيار في القائمة)
    if (examinationOptions[selectedImageType] != null &&
        !examinationOptions[selectedImageType]!
            .contains(selectedExaminationOption)) {
      selectedExaminationOption = examinationOptions[selectedImageType]!.first;
    }

    // إعادة تعيين selectedOutputType إلى القيمة الصحيحة بناءً على selectedImageType
    selectedOutputType = (examinationMode[selectedImageType] ?? []).isNotEmpty
        ? examinationMode[selectedImageType]!.first
        : null;
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
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
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
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      _buildEditableTextField(
                          'اسم المريض', patientNameController),
                      _buildNonEditableTextField('اسم الطبيب', doctorName),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: DropdownButton<String>(
                          value: selectedImageType,
                          items: const [
                            DropdownMenuItem(
                                value: "سيفالومتريك",
                                child: Text("سيفالومتريك")),
                            DropdownMenuItem(
                                value: "c.b.c.t", child: Text("c.b.c.t")),
                            DropdownMenuItem(
                                value: "بانوراما", child: Text("بانوراما")),
                          ],
                          onChanged: (value) {
                            if (value != null && value != selectedImageType) {
                              setState(() {
                                selectedImageType = value;
                                selectedExaminationOption =
                                    examinationOptions[selectedImageType]
                                        ?.first;
                                selectedOutputType =
                                    examinationMode[selectedImageType]!.first;
                              });
                            }
                          },
                          isExpanded: true,
                          underline: Container(),
                          dropdownColor: Colors.white,
                          hint: const Text('نوع الصورة'),
                        ),
                      ),
                      // القائمة المنسدلة ل "الجزء المراد تصويره"
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: DropdownButton<String>(
                          value: selectedExaminationOption,
                          items: (examinationOptions[selectedImageType] ?? [])
                              .map((option) {
                            return DropdownMenuItem(
                                value: option, child: Text(option));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedExaminationOption = value;
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                          dropdownColor: Colors.white,
                          hint: selectedExaminationOption != null
                              ? Text(selectedExaminationOption!)
                              : const Text('اختار الجزء المراد تصويره'),
                        ),
                      ),
                      // القائمة المنسدلة ل "وضعية الصورة"
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: DropdownButton<String>(
                          value: selectedOutputType,
                          items: (examinationMode[selectedImageType] ?? [])
                              .map((option) {
                            return DropdownMenuItem(
                                value: option, child: Text(option));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedOutputType = value;
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                          dropdownColor: Colors.white,
                          hint: selectedOutputType != null
                              ? Text(selectedOutputType!)
                              : const Text('اختار وضعية الصورة'),
                        ),
                      ),

                      _buildNonEditableTextField('التاريخ', date),
                      _buildNonEditableTextField('التوقيت', time),
                      _buildEditableTextField(
                          'ملاحظات', additionalNotesController),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: const Text('حفظ التغييرات'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            SizedBox(
              height: 34.h,
            ),
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
              value: widget.order.detail.option.optionName,
              topradius: 0,
              buttomradius: 0,
            ),
            selectedImageType != 'بانوراما' &&
                    widget.order.detail.mode!.modeName == ""
                ? TableItem(
                    title: 'وضعية الصورة',
                    value: widget.order.detail.mode!.modeName,
                    topradius: 0,
                    buttomradius: 0,
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
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
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: _showEditFieldsBottomSheet,
        icon: SvgPicture.asset(ImagesPath.editIcon),
      ),
    );
  }
}
