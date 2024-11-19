import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_error.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  TextEditingController searchController = TextEditingController();
  List<Order> filteredOrders = [];
  bool isPanorama = false;
  bool isCephalometric = false;
  bool isCBCT = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterOrders);
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
      final today = DateTime.now();
      final ordersToday = state.orders.where((order) {
        return order.date.year == today.year &&
            order.date.month == today.month &&
            order.date.day == today.day;
      }).toList();

      setState(() {
        filteredOrders = ordersToday.where((order) {
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
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderLoaded) {
            final today = DateTime.now();
            final ordersToday =
                filteredOrders.isEmpty && searchController.text.isEmpty
                    ? state.orders.where((order) {
                        return order.date.year == today.year &&
                            order.date.month == today.month &&
                            order.date.day == today.day;
                      }).toList()
                    : filteredOrders;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<OrderCubit>().fetchOrders();
                context.read<OrderCubit>().fetchDoctorDataUseCase();
              },
              color: const Color(AppColor.primaryColor),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  CustomSearchBar(searchController: searchController),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            MovingNavigation.navTo(
                              context,
                              page: AllOrdersPage(
                                allOrders: state.orders,
                                state: state,
                              ),
                            );
                          },
                          child: Text(
                            "< عرض الكل",
                            style: _textStyle(),
                          ),
                        ),
                        Text(
                          "طلبات اليوم",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BuildListView(orders: ordersToday, state: state),
                ],
              ),
            );
          } else if (state is OrderError) {
            return HomeViewError(state: state);
          } else {
            return const Center(child: Text('لم يتم العثور على طلبات.'));
          }
        },
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: const Color(AppColor.primaryColor),
      fontSize: 11.sp,
      color: const Color(AppColor.primaryColor),
    );
  }
}

class FilterDialog extends StatefulWidget {
  final bool isPanorama;
  final bool isCephalometric;
  final bool isCBCT;
  final Function(bool, bool, bool) onFilterChanged;

  const FilterDialog({
    super.key,
    required this.isPanorama,
    required this.isCephalometric,
    required this.isCBCT,
    required this.onFilterChanged,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late bool isPanorama;
  late bool isCephalometric;
  late bool isCBCT;

  @override
  void initState() {
    super.initState();
    isPanorama = widget.isPanorama;
    isCephalometric = widget.isCephalometric;
    isCBCT = widget.isCBCT;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchOption("بانوراما", isPanorama, (value) {
              setState(() {
                isPanorama = value;
              });
            }),
            _buildSwitchOption("سيفالوماتريك", isCephalometric, (value) {
              setState(() {
                isCephalometric = value;
              });
            }),
            _buildSwitchOption("C.B.C.T", isCBCT, (value) {
              setState(() {
                isCBCT = value;
              });
            }),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                widget.onFilterChanged(isPanorama, isCephalometric, isCBCT);
                Navigator.of(context).pop();
              },
              child: Text('تطبيق'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
