// ignore_for_file: file_names

import 'package:doctor_app/Features/AddOrder/presentation/views/add_order_view.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/navigator_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomePageViewWidget extends StatefulWidget {
  const HomePageViewWidget({super.key});

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
  State<HomePageViewWidget> createState() => _HomePageViewWidgetState();
}

var pageController = PageController(initialPage: 1);

class _HomePageViewWidgetState extends State<HomePageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavBar(
            pageController: pageController,
          ),
          body: PageView(
            onPageChanged: (value) {
              setState(() {
                animateNavBar(value);
              });
            },
            controller: pageController,
            children: const [
              AddOrderView(),
              HomePage(),
            ],
          ),
        );
      },
    );
  }
}
