// ignore_for_file: file_names

import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/custom_shimmer.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Allorderview extends StatefulWidget {
  const Allorderview({super.key});

  @override
  State<Allorderview> createState() => _AllorderviewState();
}

class _AllorderviewState extends State<Allorderview> {
  TextEditingController searchController = TextEditingController();
  late OrderCubit orderCubit;
  List<Order> filteredOrders = []; // قائمة مفلترة

  @override
  void initState() {
    super.initState();
    orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.fetchOrders(
      startDate: DateTime(2000),
      endDate: DateTime.now(),
    );
    searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterOrders);
    searchController.dispose();

    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    orderCubit.fetchOrders(startDate: startOfMonth, endDate: endOfMonth);
    orderCubit.fetchDoctorDataUseCase();

    super.dispose();
  }

  void _filterOrders() {
    final query = searchController.text.toLowerCase();
    final state = orderCubit.state;

    if (state is OrderLoaded) {
      setState(() {
        filteredOrders = state.orders.where((order) {
          final patient = state.patient.firstWhere(
            (patient) => patient.id == order.patientId,
            orElse: () => Patient(
              name: '',
              id: 0,
              age: 0,
            ),
          );
          return patient.name.toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('عرض كل الطلبات'),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            final ordersToShow =
                searchController.text.isEmpty ? state.orders : filteredOrders;

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  child: CustomSearchBar(searchController: searchController),
                ),
                Expanded(
                  child: ordersToShow.isNotEmpty
                      ? BuildListView(
                          orders: ordersToShow,
                          state: state,
                        )
                      : const Center(
                          child: Text('لا توجد طلبات مطابقة.'),
                        ),
                ),
              ],
            );
          } else if (state is OrderLoading) {
            return const Directionality(
                textDirection: TextDirection.rtl, child: CustomShimmer());
          } else {
            return const Center(child: Text('حدث خطأ أثناء تحميل الطلبات.'));
          }
        },
      ),
    );
  }
}
