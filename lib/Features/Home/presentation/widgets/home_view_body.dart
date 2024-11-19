import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/filter_dialog.dart'; // تأكد من استيراد FilterDialog
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

  // متغيرات الفلاتر
  bool isPanorama = true;
  bool isCephalometric = true;
  bool isCBCT = true;

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
      // إذا كنت ترغب في إضافة زر الفلترة في AppBar، قد تحتاج إلى نقل بعض الكود هنا
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          ImagesPath.filter,
                          fit: BoxFit.none,
                        ),
                        onPressed: _showFilterDialog,
                      ),
                      // زر البحث
                      Expanded(
                        child:
                            CustomSearchBar(searchController: searchController),
                      ),
                      // زر الفلترة
                    ],
                  ),
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
                    child: filteredOrders.isEmpty
                        ? BuildListView(
                            orders: ordersToday,
                            state: state,
                          )
                        : BuildListView(
                            orders: filteredOrders,
                            state: state,
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

  TextStyle _textStyle() {
    return TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: const Color(AppColor.primaryColor),
      fontSize: 11.sp,
      color: const Color(AppColor.primaryColor),
    );
  }
}
