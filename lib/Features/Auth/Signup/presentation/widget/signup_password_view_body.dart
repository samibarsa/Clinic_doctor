
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpPasswordView extends StatelessWidget {
  const SignUpPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body:  AuthViewBody(
        onTap: (){
          
        },
        firstFiled: "كلمة السر",
        secondFiled: "تأكيد كلمة السر",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول", buttontitle: 'انشىء حساب',
      ),
    );
  }
}
