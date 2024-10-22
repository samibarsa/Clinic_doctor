import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPasswordView extends StatelessWidget {
  const SignUpPasswordView({super.key, required this.email});

final String email;
  @override
  Widget build(BuildContext context) {
    TextEditingController password =TextEditingController();
    TextEditingController confirmPassword= TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: AuthViewBody(
        onTap: ()async {
          final supabase = Supabase.instance.client;
          final AuthResponse res = await supabase.auth.signUp(
  email:email,
  password: password.text,
);
final Session? session = res.session;
final User? user = res.user;

        },
        firstFiled: "كلمة السر",
        secondFiled: "تأكيد كلمة السر",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
        buttontitle: 'انشىء حساب',
        firstTextEditingFiled: password,
        secondTextEditingFiled: confirmPassword,
      ),
    );
  }
}
