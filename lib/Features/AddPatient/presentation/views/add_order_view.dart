import 'package:doctor_app/Features/AddPatient/presentation/widgets/add_patient_view_body.dart';
import 'package:flutter/material.dart';

class AddPatientView extends StatelessWidget {
  const AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text("معلومات المريض"),
      ),
      body: const AddOrederViewBody(),
    );
  }
}
