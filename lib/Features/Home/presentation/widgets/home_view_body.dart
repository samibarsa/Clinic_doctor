import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_history.dart';
import 'package:doctor_app/Features/Home/presentation/view/order_view_detiles.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home.dart';
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
