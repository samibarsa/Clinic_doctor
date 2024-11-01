import 'package:doctor_app/Features/Auth/Login/presentation/widget/resset_password.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_state.dart';
import 'package:doctor_app/Features/Home/presentation/view/home_view.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تسجيل الدخول بنجاح')),
          );
          // الانتقال إلى الصفحة الرئيسية
          MovingNavigation.navTo(context, page: const HomeView());
        }
        if (state is AuthFailure) {
          // عرض رسالة الفشل
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.w, top: 443.h),
              child: GestureDetector(
                onTap: () {
                  MovingNavigation.navTo(context, page: RessetPassword()); // تغيير هذا بناءً على صفحة إعادة تعيين كلمة المرور
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
      },
    );
  }
}
