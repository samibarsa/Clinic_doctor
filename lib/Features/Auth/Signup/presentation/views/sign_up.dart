import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_email_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body:  AuthViewBody(firstTextEditingFiled: firstName,
      secondTextEditingFiled: secondName,
        onTap: (){
          MovingNavigation.navTo(context, page: const SignUpEmailView());
          
        },
        firstFiled: "الاسم الأول",
        secondFiled: "الاسم الثاني",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول", buttontitle: 'التالي',
      ),
    );
  }
}
