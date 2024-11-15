import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  State<NavBar> createState() => _NavBarState();
}

int currentIndex = 0;
EdgeInsetsGeometry padding = const EdgeInsets.only();
String imagePath = ImagesPath.navbarHome;

void animateNavBar(int value) {
  if (value == 0) {
    padding = EdgeInsets.only(right: 220.w);
    imagePath = ImagesPath.navbarHistory;
  } else if (value == 1) {
    padding = EdgeInsets.only(left: 220.w);
    imagePath = ImagesPath.navbarHome;
  }
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 21.h),
          child: SvgPicture.asset(fit: BoxFit.fill, imagePath),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 120.w, top: 30.h),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    setState(() {
                      widget.pageController.jumpToPage(0);
                    });
                  },
                  child: SizedBox(
                    height: 30.h,
                    width: 45.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 45.w, top: 15.h),
                child: InkWell(
                  splashColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    setState(() {
                      widget.pageController.jumpToPage(1);
                    });
                  },
                  child: SizedBox(
                    height: 30.h,
                    width: 45.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
