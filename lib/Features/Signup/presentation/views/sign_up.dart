import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: const AuthViewBody(
        firstFiled: "الاسم الأول",
        secondFiled: "الاسم الثاني",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
      ),
    );
  }
}
