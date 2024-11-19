import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/filter_dialog.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllOrdersPage extends StatefulWidget {
  final List<Order> allOrders;
  final OrderLoaded state;

  const AllOrdersPage(
      {super.key, required this.allOrders, required this.state});

  @override
  // ignore: library_private_types_in_public_api
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  TextEditingController searchController = TextEditingController();
  List<Order> filteredOrders = [];
  bool isPanorama = true;
  bool isCephalometric = true;
  bool isCBCT = true;

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
    final state = context.read<OrderCubit>().state;
    if (state is OrderLoaded) {
      setState(() {
        filteredOrders = state.orders.where((order) {
          final patient = state.patient.firstWhere(
            (patient) => patient.id == order.patientId,
            orElse: () => Patient(
              name: '',
              id: 0,
              age: 0, // Other fields with default values
            ),
          );
          final patientName = patient.name.toLowerCase();
          final orderType = order.detail.type.typeName.toLowerCase();

          bool matchesType = false;
          if (isPanorama && orderType.contains('بانوراما')) matchesType = true;
          if (isCephalometric && orderType.contains('سيفالوماتريك'))
            matchesType = true;
          if (isCBCT && orderType.contains('c.b.c.t')) matchesType = true;

          return patientName.contains(query) && matchesType;
        }).toList();
      });
    }
  }

  void _updateFilter(bool panorama, bool cephalometric, bool cbct) {
    setState(() {
      isPanorama = panorama;
      isCephalometric = cephalometric;
      isCBCT = cbct;
    });
    _filterOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('جميع الطلبات'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              ImagesPath.filter,
              fit: BoxFit.none,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FilterDialog(
                  isPanorama: isPanorama,
                  isCephalometric: isCephalometric,
                  isCBCT: isCBCT,
                  onFilterChanged: _updateFilter,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: CustomSearchBar(searchController: searchController),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text("لا يوجد بيانات حاليا"),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomButton(
                            title: "إعادة تحميل",
                            color: AppColor.primaryColor,
                            onTap: () async {
                              context.read<OrderCubit>().fetchOrders();
                            },
                            titleColor: Colors.white)
                      ],
                    ),
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
