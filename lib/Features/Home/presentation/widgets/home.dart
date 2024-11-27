import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_app_bar.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: const HomeViewBody());
  }
}
