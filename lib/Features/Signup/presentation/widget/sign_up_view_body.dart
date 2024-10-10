import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:doctor_app/core/utils/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 52.h,),
            const CustomTextField(
              title: "الاسم الأول",
            ),
            SizedBox(
              height: 24.h,
            ),
            const CustomTextField(
              title: "الاسم الثاني",
            ),
            SizedBox(
              height: 174.h,
            ),
            CustomButton(
                title: "التالي",
                color: 0xff4CAF50,
                onTap: () {},
                titleColor: Colors.white),
                SizedBox(height: 36.h,),
                SvgPicture.asset(ImagesPath.or),
                SizedBox(height: 36.h,),
                const GoogleButton(),
                SizedBox(height: 44.h,),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("سجل دخول",style:TextStyle(fontSize: 11.sp) ,),
                    Text("لديك حساب بالفعل؟",style: TextStyle(color:  const Color(0xff898A8F),fontSize: 11.sp),),
                  ],
                )



          ],
        ),
      ),
    );
  }
}
