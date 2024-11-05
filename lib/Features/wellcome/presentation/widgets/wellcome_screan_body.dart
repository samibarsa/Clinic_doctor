import 'package:doctor_app/Features/Auth/presentation/views/login_view.dart';
import 'package:doctor_app/Features/Auth/presentation/views/sign_up.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class WellcomeViewBody extends StatelessWidget {
  const WellcomeViewBody({
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
            height: 300.h,
            width: 300.w,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(ImagesPath.wellcome),
              Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  CustomButton(
                    onTap: () {
                      MovingNavigation.navTo(context, page: const SignUpView());
                    },
                    title: "انشاء حساب",
                    color: AppColor.primaryColor,
                    titleColor: Colors.white,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(AppColor.primaryColor)),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: CustomButton(
                        titleColor: Colors.black,
                        onTap: () {
                          MovingNavigation.navTo(context,
                              page: const LoginView());
                        },
                        title: 'تسجيل دخول',
                        color: 0xffFFFF),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
