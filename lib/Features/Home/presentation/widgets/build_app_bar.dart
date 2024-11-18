import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_doctor_info.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(OrderState state) {
  return AppBar(
    title: Directionality(
      textDirection: TextDirection.rtl,
      child: buildDoctorInfo(state),
    ),
  );
}
