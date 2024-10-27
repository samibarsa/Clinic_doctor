import 'dart:developer';

import 'package:doctor_app/Features/Auth/Login/presentation/widget/resset_password.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).signIn(email.text, password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthViewBody(
          formKey: formKey,
          onTap: () {
            submitForm(context);
          },
          firstTextEditingFiled: email,
          secondTextEditingFiled: password,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'لا يمكن أن يكون هذا الحقل فارغا';
            }
            return null;
          },
          firstFiled: "البريد الاكتروني",
          secondFiled: "كلمة السر",
          questestion: "ليس لديك حساب ؟",
          state: "انشىء حساب",
          buttontitle: 'تسجيل دخول',
          firstKeyboardType: TextInputType.emailAddress,
          secondKeyboardType: TextInputType.text,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.w, top: 190.h),
          child: GestureDetector(
            onTap: () {
              log("message");
              MovingNavigation.navTo(context, page: RessetPassword());
            },
            child: Text(
              "هل نسيت كلمة المرور؟",
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xff898A8F),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
