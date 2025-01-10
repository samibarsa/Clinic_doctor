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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Image.asset(
              ImagesPath.logo,
              height: MediaQuery.of(context).size.height * 0.25,
              width: 263.w,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.97,
                  child: SvgPicture.asset(
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                    ImagesPath.wellcome,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CustomButton(
                      onTap: () {
                        MovingNavigation.navTo(context,
                            page: const SignUpView());
                      },
                      title: "انشاء حساب",
                      color: AppColor.primaryColor,
                      titleColor: Colors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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
      ),
    );
  }
}
