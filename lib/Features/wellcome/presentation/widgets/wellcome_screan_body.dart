import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreanBody extends StatelessWidget {
  const HomeScreanBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            ImagesPath.logo,
            height: 300,
            width: 300,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(ImagesPath.wellcome),
               Column(
                children: [
                  const CustomButton(
                    title: "انشاء حساب",
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: 24.h,),
                  const CustomButton(
                      title: 'تسجيل دخول', color: AppColor.secondColor),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
