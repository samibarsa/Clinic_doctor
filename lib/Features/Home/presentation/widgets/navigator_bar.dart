import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.homeView});
  final HomeViewBody homeView;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 21.h),
          child: SvgPicture.asset(fit: BoxFit.fill, widget.homeView.imagePath),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 120.w, top: 30.h),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.homeView.pageController.jumpToPage(0);
                      widget.homeView.animateNavBar(0);
                    });
                  },
                  child: SizedBox(
                    height: 60.h,
                    width: 60.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 30.h),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.homeView.pageController.jumpToPage(1);
                      widget.homeView.animateNavBar(1);
                    });
                  },
                  child: SizedBox(
                    height: 60.h,
                    width: 60.w,
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
