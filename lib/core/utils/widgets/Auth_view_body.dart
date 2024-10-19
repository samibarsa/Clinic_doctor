import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:doctor_app/core/utils/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody(
      {super.key,
      required this.firstFiled,
      required this.secondFiled,
      required this.state,
      required this.questestion,
      required this.onTap, required this.buttontitle});

  final String firstFiled;
  final String secondFiled;

  final String state;
  final String questestion;
  final void Function()? onTap;
    final String buttontitle ;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 52.h,
            ),
            CustomTextField(
              title: firstFiled,
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomTextField(
              title: secondFiled,
            ),
            SizedBox(
              height: 174.h,
            ),
            CustomButton(
                title: buttontitle,
                color: 0xff4CAF50,
                onTap: onTap,
                titleColor: Colors.white),
            SizedBox(
              height: 36.h,
            ),
            SvgPicture.asset(ImagesPath.or),
            SizedBox(
              height: 36.h,
            ),
            const GoogleButton(),
            SizedBox(
              height: 44.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state,
                  style: TextStyle(fontSize: 11.sp),
                ),
                Text(
                  questestion,
                  style: TextStyle(
                      color: const Color(0xff898A8F), fontSize: 11.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
