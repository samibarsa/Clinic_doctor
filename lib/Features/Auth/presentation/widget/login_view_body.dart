import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_state.dart';
import 'package:doctor_app/Features/Auth/presentation/views/sign_up.dart';
import 'package:doctor_app/Features/Home/presentation/view/homePageViewWidget.dart';
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
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthCubit>(context).signIn(email.text, password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    const HomePageViewWidget()), // الصفحة الجديدة التي تريد الانتقال إليها
            (Route<dynamic> route) => false, // إزالة جميع الصفحات السابقة
          );
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 125.h),
              child: AuthViewBody(
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
                navigation: () {
                  MovingNavigation.navTo(context, page: const SignUpView());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
