import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllOrdersPage extends StatefulWidget {
  final List<Order> allOrders;
  final OrderLoaded state;

  const AllOrdersPage(
      {super.key, required this.allOrders, required this.state});

  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  TextEditingController searchController = TextEditingController();
  List<Order> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterOrders);
    filteredOrders = widget.allOrders; // Initialize filteredOrders
  }

  @override
  void dispose() {
    searchController.removeListener(_filterOrders);
    searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredOrders = widget.allOrders.where((order) {
        final patient = widget.state.patient.firstWhere(
          (patient) => patient.id == order.patientId,
          orElse: () => Patient(
            name: '',
            id: 0,
            age: 0, /* other fields with default values */
          ),
        );
        final patientName = patient.name.toLowerCase();
        return patientName.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('جميع الطلبات'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: CustomSearchBar(searchController: searchController),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(
                    child: Text('لا توجد طلبات حالياً'),
                  )
                : BuildListView(
                    orders: filteredOrders,
                    state: widget.state,
                  ),
          ),
        ],
      ),
    );
  }
}
