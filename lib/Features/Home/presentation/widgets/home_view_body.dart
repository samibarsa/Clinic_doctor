import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_error.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
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
              age: 0, /* other fields with default values */
            ),
          );
          final patientName = patient.name.toLowerCase();
          return patientName.contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
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
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffF6F7F7),
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  child: CustomTextField(
                    prefix: SvgPicture.asset(
                      ImagesPath.filter,
                      fit: BoxFit.none,
                    ),
                    suffix: const Icon(Icons.search),
                    title: "مريض,تصوير مقطعي",
                    radius: 12.r,
                    textEditingController: searchController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          MovingNavigation.navTo(context,
                              page: AllOrdersPage(
                                allOrders: state.orders,
                                state: state,
                              ));
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
