import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPasswordView extends StatelessWidget {
  const SignUpPasswordView(
      {super.key, required this.email, required this.phone});

  final String email;
  final String phone;
  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        centerTitle: true,
      ),
      body: AuthViewBody(
        firstKeyboardType: TextInputType.text,
        secondKeyboardType: TextInputType.text,
        onTap: () async {
          BlocProvider.of<AuthCubit>(context).signUp(email, password.text);
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
