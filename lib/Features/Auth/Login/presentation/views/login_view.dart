import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("تسجيل الدخول"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w, top: 190.h),
            child: Text(
              "هل نسيت كلمة المرور؟",
              style: TextStyle(fontSize: 12.sp, color: const Color(0xff898A8F)),
            ),
          ),
           AuthViewBody(onTap: (){},
              firstFiled: "البريد الاكتروني",
              secondFiled: "كلمة السر",
              questestion: "ليس لديك حساب ؟",
              state: "انشىء حساب", buttontitle: 'تسجيل دخول',),
        ],
      ),
    );
  }
}
