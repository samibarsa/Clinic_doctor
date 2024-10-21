import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                SvgPicture.asset(ImagesPath.doctor),
                const Text("\tأحمد موسى")
              ],
            )),
      ),
      body: HomeViewBody(),
    );
  }
}
