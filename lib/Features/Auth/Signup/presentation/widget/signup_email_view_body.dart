import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_password_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: AuthViewBody(firstKeyboardType: TextInputType.emailAddress,
      secondKeyboardType: TextInputType.phone,
        firstTextEditingFiled: email,
        secondTextEditingFiled: phoneNumber,
        onTap: () {
          MovingNavigation.navTo(context, page:  SignUpPasswordView(email: email.text, phone: phoneNumber.text,));
        },
        firstFiled: "البريد الاكتروني",
        secondFiled: "رقم الهاتف",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
        buttontitle: 'التالي',
      ),
    );
  }
}
