import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_password_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: AuthViewBody(
        onTap: () {
          MovingNavigation.navTo(context, page: const SignUpPasswordView());
        },
        firstFiled: "البريد الاكتروني",
        secondFiled: "رقم الهاتف",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول", buttontitle: 'التالي',
      ),
    );
  }
}
