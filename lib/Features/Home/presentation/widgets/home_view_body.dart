import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/custom_shimmer.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/filter_dialog.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_error.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/search_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
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

  bool isPanorama = true;
  bool isCephalometric = true;
  bool isCBCT = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterOrders);
    _updateFilter(isPanorama, isCephalometric, isCBCT);
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
              age: 0,
            ),
          );
          final patientName = patient.name.toLowerCase();
          final orderType = order.detail.type.typeName.toLowerCase();

          bool matchesType = false;
          if (isPanorama && orderType.contains('بانوراما')) matchesType = true;
          if (isCephalometric && orderType.contains('سيفالوماتريك')) {
            matchesType = true;
          }
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        isPanorama: isPanorama,
        isCephalometric: isCephalometric,
        isCBCT: isCBCT,
        onFilterChanged: _updateFilter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  SizedBox(height: 70.h),
                  const Expanded(child: CustomShimmer()),
                ],
              ),
            );
          } else if (state is OrderLoaded) {
            final today = DateTime.now();
            final ordersToday = state.orders.where((order) {
              return order.date.year == today.year &&
                  order.date.month == today.month &&
                  order.date.day == today.day;
            }).toList();

            const Duration(microseconds: 50000);
            return RefreshIndicator(
              onRefresh: () async {
                final now = DateTime.now();
                final startOfMonth = DateTime(now.year, now.month, 1);
                final endOfMonth = DateTime(now.year, now.month + 1, 0);
                context
                    .read<OrderCubit>()
                    .fetchOrders(startDate: startOfMonth, endDate: endOfMonth);
                context.read<OrderCubit>().fetchDoctorDataUseCase();
              },
              color: const Color(AppColor.primaryColor),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  _buildHeader(),
                  SizedBox(height: 24.h),
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
                            "< عرض كل الطلبات",
                            style: _textStyle().copyWith(fontSize: 14.sp),
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
                  Expanded(
                    child: filteredOrders.isNotEmpty
                        ? BuildListView(
                            orders: filteredOrders,
                            state: state,
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: const Text('لا توجد طلبات مطابقة.'),
                            ),
                          ),
                  ),
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

  Widget _buildHeader() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                ImagesPath.filter,
                fit: BoxFit.none,
              ),
              onPressed: _showFilterDialog,
            ),
            Expanded(
              child: CustomSearchBar(searchController: searchController),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("لا يوجد بيانات حاليا"),
          ),
          SizedBox(height: 40.h),
          CustomButton(
            title: "إعادة تحميل",
            color: AppColor.primaryColor,
            onTap: () async {
              final now = DateTime.now();
              final startOfMonth = DateTime(now.year, now.month, 1);
              final endOfMonth = DateTime(now.year, now.month + 1, 0);
              context
                  .read<OrderCubit>()
                  .fetchOrders(startDate: startOfMonth, endDate: endOfMonth);
            },
            titleColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

TextStyle _textStyle() {
  return TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: const Color(AppColor.primaryColor),
    fontSize: 11.sp,
    color: const Color(AppColor.primaryColor),
  );
}
