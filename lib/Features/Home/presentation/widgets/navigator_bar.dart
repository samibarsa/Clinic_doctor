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

void animateNavBar(int value, BuildContext context) {
  if (value == 0) {
    padding = EdgeInsets.only(right: MediaQuery.of(context).size.width / 9);
    currentIndex = 0;
    imagePath = ImagesPath.navbarHistory;
  } else if (value == 1) {
    padding = EdgeInsets.only(left: 220.w);
    currentIndex = 1;
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
          padding:
              EdgeInsets.only(bottom: 21.h), // استخدم نسباً أو ScreenUtil هنا
          child: SvgPicture.asset(imagePath,
              height: 54, // حجم نسبي للصورة
              width: 154 // عرض نسبي للصورة
              ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 35.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3,
                    top: MediaQuery.of(context).size.height / 100),
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
                    width: currentIndex == 0 ? 90.w : 45.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 90,
                    top: MediaQuery.of(context).size.height / 50),
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
                    width: currentIndex == 1 ? 90.w : 40.w,
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
