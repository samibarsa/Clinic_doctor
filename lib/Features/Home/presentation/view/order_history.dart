import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/monthly_summary_page.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/custom_shimmer.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/filter_dialog.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
  Map<String, Map<String, dynamic>> monthlySummary = {};
  bool isPanorama = true;
  bool isCephalometric = true;
  bool isCBCT = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterOrders);
    filteredOrders = widget.allOrders;
    _calculateMonthlySummary();
  }

  @override
  void dispose() {
    searchController.removeListener(_filterOrders);
    searchController.dispose();
    super.dispose();
  }

  void _calculateMonthlySummary() {
    monthlySummary.clear();
    Map<String, int> orderTypeCount = {
      "بانوراما": 0,
      "سيفالوماتريك": 0,
      "C.BC.T": 0,
    };

    for (var order in filteredOrders) {
      final date = DateTime.parse(
          order.date.toString()); // Assuming `order.date` is a String
      final monthYear = "${date.month}-${date.year}";
      final orderType = order.detail.type.typeName.toLowerCase();

      if (!monthlySummary.containsKey(monthYear)) {
        monthlySummary[monthYear] = {
          "totalPrice": 0.0,
          "orderCount": 0,
        };
      }

      monthlySummary[monthYear]!["totalPrice"] += order.price;
      monthlySummary[monthYear]!["orderCount"]++;

      // زيادة العداد لكل نوع بناءً على النوع
      if (orderType.contains("بانوراما")) {
        orderTypeCount["بانوراما"] = orderTypeCount["بانوراما"]! + 1;
      } else if (orderType.contains("سيفالوماتريك")) {
        orderTypeCount["سيفالوماتريك"] = orderTypeCount["سيفالوماتريك"]! + 1;
      } else if (orderType.contains("c.b.c.t")) {
        orderTypeCount["C.BC.T"] = orderTypeCount["C.BC.T"]! + 1;
      }
    }

    // تحديث الحالة لعرض الإحصائيات
    setState(() {
      monthlySummary["orderTypeCount"] = orderTypeCount;
    });
  }

  void _filterOrders() {
    final query = searchController.text.toLowerCase();
    final state = context.read<OrderCubit>().state;

    if (state is OrderLoaded) {
      setState(() {
        filteredOrders = state.orders.where((order) {
          final patient = state.patient.firstWhere(
            (patient) => patient.id == order.patientId,
            orElse: () => Patient(name: '', id: 0, age: 0),
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
        _calculateMonthlySummary();
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
          IconButton(
            onPressed: () async {
              final selectedDate = await showMonthYearPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2042),
                locale: const Locale('ar', 'Arabic'),
              );
              if (selectedDate != null) {
                BlocProvider.of<OrderCubit>(context).fetchOrders(
                  startDate: selectedDate,
                  endDate: DateTime(selectedDate.year, selectedDate.month + 1),
                );
              }
            },
            icon: const Icon(Icons.calendar_month),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MonthlySummaryPage(
                    monthlySummary: monthlySummary,
                    doctorName: widget.state.doctor.name, // البيانات الحالية
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _filterOrders();
            });

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  child: CustomSearchBar(searchController: searchController),
                ),
                Expanded(
                  child: filteredOrders.isNotEmpty
                      ? BuildListView(
                          orders: filteredOrders,
                          state: widget.state,
                        )
                      : const Center(
                          child: Text('لا توجد طلبات مطابقة.'),
                        ),
                ),
              ],
            );
          } else if (state is OrderLoading) {
            return const CustomShimmer();
          } else {
            return const Center(child: Text('حدث خطأ أثناء تحميل الطلبات.'));
          }
        },
      ),
    );
  }
}
