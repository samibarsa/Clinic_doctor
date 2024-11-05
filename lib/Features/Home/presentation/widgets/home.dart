import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_search_text_filed.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/list_tile_card.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Color(AppColor.primaryColor)));
        } else if (state is OrderLoaded) {
          final orders = state.orders;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrderCubit>().fetchOrders();
            },
            color: const Color(AppColor.primaryColor),
            child: _buildOrderList(orders),
          );
        } else if (state is OrderError) {
          return _buildErrorState(context, state.message);
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        const HomeSearchTextFiled(),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("< عرض الكل", style: _buildTextStyle()),
              Text("طلبات اليوم", style: _buildTitleStyle()),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: ListTileCard(
                  papatientName: order.patientName,
                  type: order.type,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: const Color(AppColor.primaryColor),
      fontSize: 11.sp,
      color: const Color(AppColor.primaryColor),
    );
  }

  TextStyle _buildTitleStyle() {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('حدث خطأ: $message'),
          SizedBox(height: 20.h),
          CustomButton(
            title: "إعادة تحميل",
            color: AppColor.primaryColor,
            onTap: () {
              context.read<OrderCubit>().fetchOrders();
            },
            titleColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
