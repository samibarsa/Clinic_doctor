import 'package:doctor_app/Features/Signup/presentation/widget/sign_up_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const Text("إنشاء حساب"),
      centerTitle: true,),
      body:const SignUpViewBody(),
    );
  }
}
