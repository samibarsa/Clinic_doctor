import 'package:doctor_app/Features/Home/presentation/widgets/build_app_bar.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: const HomeViewBody());
  }
}
