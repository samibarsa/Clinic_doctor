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
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
        } else if (state is OrderLoaded) {
          final orders = state.orders;
          final today = DateTime.now();
          orders.where((order) {
            return order.date.year == today.year &&
                order.date.month == today.month &&
                order.date.day == today.day;
          }).toList();

          return Scaffold(
              appBar: buildAppBar(context, state), body: const HomeViewBody());
        } else if (state is OrderError) {
          return HomeViewError(
            state: state,
          );
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
    );
  }
}
