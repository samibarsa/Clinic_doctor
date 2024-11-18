import 'package:doctor_app/Features/AddOrder/presentation/pages/add_pano_view2.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/add_sefalo_2.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';

class AddSefaloView1 extends StatefulWidget {
  const AddSefaloView1({super.key, required this.patientId});
  final int patientId;
  @override
  State<AddSefaloView1> createState() => _AddPanoView1State();
}

class _AddPanoView1State extends State<AddSefaloView1> {
  String? selectedOption;

  final List<String> options = [
    'Full lateral جانبية',
    'Carpus العمر العظمي',
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
          title: 'اختر الجزء المراد تصويره:',
          titleButton: "التالي",
          onTap: () {
            if (selectedOption != null) {
              MovingNavigation.navTo(context,
                  page: AddSefaloView2(
                    patientId: widget.patientId,
                    examinationOption: selectedOption!,
                  ));
            }
          },
        ),
      ),
    );
  }
}