import 'package:doctor_app/Features/Login/presentation/views/login_view.dart';
import 'package:doctor_app/Features/Signup/presentation/views/sign_up.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
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
                  CustomButton(
                    onTap: () {
                      MovingNavigation.navTo(context, page: const SignUpView());
                    },
                    title: "انشاء حساب",
                    color: AppColor.primaryColor,
                    titleColor: Colors.black,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomButton(
                      titleColor: Colors.black,
                      onTap: () {
                        MovingNavigation.navTo(context,
                            page: const LoginView());
                      },
                      title: 'تسجيل دخول',
                      color: AppColor.secondColor),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
