import 'package:doctor_app/Features/Home/presentation/widgets/home_search_text_filed.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/list_tile_card.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/navigator_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatefulWidget {
  HomeViewBody({
    super.key,
  });

  int currentIndex = 0;

  EdgeInsetsGeometry padding = const EdgeInsets.only();

  String imagePath = ImagesPath.navbarHome;

  var pageController = PageController(
    initialPage: 2,
  );

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
        // Nav BAr
        NavBar(
          homeViewBody: widget,
        ),
        SizedBox(
          height: 21.h,
        )
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Text(
                "< عرض الكل",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(AppColor.primaryColor),
                  fontSize: 11.sp,
                  color: const Color(AppColor.primaryColor),
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
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: const ListTileCard(
                      papatientName: 'aa',
                      type: 'X-Ray',
                    ),
                  ),
                  // إضافة padding فقط في آخر عنصر
                  if (index == 9) // تحقق إذا كنا في آخر عنصر
                    SizedBox(height: 60.h),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class Person extends StatelessWidget {
  const Person({
    super.key,
  });

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
