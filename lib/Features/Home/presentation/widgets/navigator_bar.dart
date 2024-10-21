
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.homeViewBody});
  final HomeViewBody homeViewBody;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SvgPicture.asset(fit: BoxFit.fill, widget.homeViewBody.imagePath),
     
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.w, top: 30.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.homeViewBody.pageController.jumpToPage(0);
                    widget.homeViewBody.animateNavBar(0);
                  });
                },
                child: SizedBox(
                  height:60.h,
                  width: 60.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 60.w, top: 30.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.homeViewBody.pageController.jumpToPage(1);
                    widget.homeViewBody.animateNavBar(1);
                  });
                },
                child: SizedBox(
                
                  height: 60.h,
                  width: 60.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 60.w, top: 30.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.homeViewBody.pageController.jumpToPage(2);
                    widget.homeViewBody.animateNavBar(2);
                  });
                },
                child: SizedBox(
                  height: 60.h,
                  width: 60.w,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
