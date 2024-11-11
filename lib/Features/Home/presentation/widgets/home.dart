import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/build_list_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_search_text_filed.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_error.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderLoaded) {
          final orders = state.orders;
          final today = DateTime.now();
          orders.where((order) {
            return order.date.year == today.year &&
                order.date.month == today.month &&
                order.date.day == today.day;
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              // استدعاء دالة جلب البيانات من OrderCubit
              context.read<OrderCubit>().fetchOrders();
              context.read<OrderCubit>().fetchDoctorDataUseCase();
            },
            color: const Color(AppColor.primaryColor),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                const HomeSearchTextFiled(),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          MovingNavigation.navTo(context,
                              page: AllOrdersPage(allOrders: orders));
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
                BuildListView(orders: orders, state: state),
              ],
            ),
          );
        } else if (state is OrderError) {
          return HomeViewError(
            state: state,
          );
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
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
