import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_order_view_body.dart';
import 'package:flutter/material.dart';

class AddOrderView extends StatelessWidget {
  const AddOrderView({super.key, required this.patientId});
  final int patientId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("اختيار نوع الصورة"),
      ),
      body: AddOrderViewBody(
        patientId: patientId,
      ),
    );
  }
}
