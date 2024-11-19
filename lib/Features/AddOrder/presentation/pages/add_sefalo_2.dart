import 'package:doctor_app/Features/AddOrder/presentation/pages/add_sefalo_3.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';

class AddSefaloView2 extends StatefulWidget {
  const AddSefaloView2(
      {super.key, required this.patientId, required this.examinationOption});
  final int patientId;
  final String examinationOption;
  @override
  State<AddSefaloView2> createState() => _AddPanoView1State();
}

class _AddPanoView1State extends State<AddSefaloView2> {
  String? selectedOption;

  final List<String> options = [
    'Forntal جبهية',
    'SMV وضعية',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("صورة سيفالومتريك"),
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
                  page: AddSefaloView3(
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
