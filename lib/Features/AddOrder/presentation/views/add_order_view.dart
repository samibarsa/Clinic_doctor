import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_oreder_view_body.dart';
import 'package:flutter/material.dart';

class AddOrderView extends StatelessWidget {
  const AddOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("معلومات المريض"),
      ),
      body: const AddOrederViewBody(),
    );
  }
}
