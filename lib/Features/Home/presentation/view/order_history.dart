import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:flutter/material.dart';

class AllOrdersPage extends StatelessWidget {
  final List<Order> allOrders;

  final OrderLoaded state;
  const AllOrdersPage(
      {super.key, required this.allOrders, required this.state});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الطلبات'),
      ),
      body: allOrders.isEmpty
          ? const Center(
              child: Text('لا توجد طلبات حالياً'),
            )
          : BuildListView(
              orders: allOrders,
              state: state,
            ),
    );
  }
}
