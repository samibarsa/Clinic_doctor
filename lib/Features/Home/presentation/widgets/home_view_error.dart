import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewError extends StatelessWidget {
  const HomeViewError({
    super.key,
    required this.state,
  });
  final OrderError state;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('حدث خطأ: ${state.message}'),
          SizedBox(height: 20.h),
          CustomButton(
              title: "إعادة تحميل",
              color: AppColor.primaryColor,
              onTap: () async {
                context.read<OrderCubit>().fetchOrders();
              },
              titleColor: Colors.white)
        ],
      ),
    );
  }
}
