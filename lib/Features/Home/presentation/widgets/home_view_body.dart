import 'package:doctor_app/Features/Home/presentation/widgets/home_text_widgets.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/navigator_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    if (value == 1) {
      padding = EdgeInsets.only(right: 220.w);
      imagePath = ImagesPath.navbarHistory;
    } else if (value == 2) {
      padding = EdgeInsets.zero;
      imagePath = ImagesPath.navbarHome;
    } else if (value == 0) {
      padding = EdgeInsets.only(left: 220.w);
      imagePath = ImagesPath.navbarSettings;
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
             widget. animateNavBar(value);
            });
          },
          controller: 
         widget. pageController,
          children: const [Person(), MyCourses(), Home(),],
        ),
        // Nav BAr
        NavBar(
          homeViewBody: widget,
        ),
        SizedBox(height: 21.h,)
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
        SizedBox(
          height: 30.h,
        ),
        const HomeTextWidgets(),
        SizedBox(
          height: 40.h,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // GestureDetector(
          //     onTap: () {}, child: SvgPicture.asset(ImagesPath.orderHistory)),
          // GestureDetector(
          //     onTap: () {}, child: SvgPicture.asset(ImagesPath.addOrder)),
          Padding(
            padding:  EdgeInsets.only(bottom: 21.h),
            child: NavBar(homeViewBody: HomeViewBody()),
          ),
        ])
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

class MyCourses extends StatelessWidget {
  const MyCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        )
      ],
    );
  }
}
