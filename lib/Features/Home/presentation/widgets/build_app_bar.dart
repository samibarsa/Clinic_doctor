import 'package:doctor_app/Features/Home/presentation/widgets/build_doctor_info.dart';
import 'package:flutter/material.dart';

buildAppBar(
  BuildContext context,
) {
  return AppBar(
    forceMaterialTransparency: true,
    title: Directionality(
      textDirection: TextDirection.rtl,
      child: buildDoctorInfo(
        context,
      ),
    ),
  );
}









/**
 * BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          final orders = state.orders;
          final today = DateTime.now();
          orders.where((order) {
            return order.date.year == today.year &&
                order.date.month == today.month &&
                order.date.day == today.day;
          }).toList();

          return AppBar(
        forceMaterialTransparency: true,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: buildDoctorInfo(context, state),
        ),
      );
        } else if (state is OrderError) {
          return HomeViewError(
            state: state,
          );
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
    );* */