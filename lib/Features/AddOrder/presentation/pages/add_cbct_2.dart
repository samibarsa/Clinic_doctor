import 'package:doctor_app/Features/AddOrder/presentation/pages/add_cbct_3.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/add_sefalo_3.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';

class AddCBCTView2 extends StatefulWidget {
  const AddCBCTView2(
      {super.key, required this.patientId, required this.examinationOption});
  final int patientId;
  final String examinationOption;
  @override
  State<AddCBCTView2> createState() => _AddPanoView1State();
}

class _AddPanoView1State extends State<AddCBCTView2> {
  String? selectedOption;

  final List<String> options = [
    'كامل الجمجمة',
    'ساحة 5*5 مميزة للبية',
    'إجراء دراسة كاملة للمقطع',
    'نصف فك'
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("صورة تصوير مقطعيC.B.C.T"),
        ),
        body: AddRadioBody(
          patientId: widget.patientId,
          options: options,
          selectedOption: selectedOption,
          onOptionChanged: (value) {
            setState(() {
              selectedOption = value;
            });
          },
          title: 'اختر وضعية الصورة:',
          titleButton: "التالي",
          onTap: () {
            if (selectedOption != null) {
              MovingNavigation.navTo(context,
                  page: AddCBCTView3(
                      examinationOption: widget.examinationOption,
                      patientId: widget.patientId,
                      examinationMode: selectedOption!));
            }
          },
        ),
      ),
    );
  }
}
