import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/oredersDayItem.dart';
import 'package:flutter/material.dart';

class AllOrdersPage extends StatelessWidget {
  final List<Order> allOrders;
  const AllOrdersPage({super.key, required this.allOrders});
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
          : ListView.builder(
              itemCount: allOrders.length,
              itemBuilder: (context, index) {
                return OredersDayItem(order: allOrders[index]);
              },
            ),
    );
  }
}
