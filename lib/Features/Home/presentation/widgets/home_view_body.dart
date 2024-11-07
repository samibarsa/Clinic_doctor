import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_view_detiles.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_search_text_filed.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/list_tile_card.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/navigator_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key});

  int currentIndex = 0;
  EdgeInsetsGeometry padding = const EdgeInsets.only();
  String imagePath = ImagesPath.navbarHome;
  var pageController = PageController(initialPage: 1);

  void animateNavBar(int value) {
    if (value == 0) {
      padding = EdgeInsets.only(right: 220.w);
      imagePath = ImagesPath.navbarHistory;
    } else if (value == 1) {
      padding = EdgeInsets.only(left: 220.w);
      imagePath = ImagesPath.navbarHome;
    }
  }

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          onPageChanged: (value) {
            setState(() {
              widget.animateNavBar(value);
            });
          },
          controller: widget.pageController,
          children: const [
            Person(),
            Home(),
          ],
        ),
        NavBar(homeViewBody: widget),
        SizedBox(height: 21.h),
      ],
    );
  }
}

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
          final ordersToday = orders.where((order) {
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
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(AppColor.primaryColor),
                            fontSize: 11.sp,
                            color: const Color(AppColor.primaryColor),
                          ),
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
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: InkWell(
                              onTap: () {
                                MovingNavigation.navTo(context,
                                    page: OrderDetailes(
                                        order: order, doctor: state.doctor));
                              },
                              child: ListTileCard(
                                papatientName: order.patientName,
                                type: order.type,
                              ),
                            ),
                          ),
                          if (index == orders.length - 1)
                            SizedBox(height: 60.h),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is OrderError) {
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
        } else {
          return const Center(child: Text('لم يتم العثور على طلبات.'));
        }
      },
    );
  }
}

class Person extends StatelessWidget {
  const Person({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }
}
