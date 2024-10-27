import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void submitForm(BuildContext context) {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<AuthCubit>(context).signIn(email.text, password.text);
      }
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Color(AppColor.primaryColor),
          ),
          inAsyncCall: state is AuthLoading,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("تسجيل الدخول"),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.w, top: 190.h),
                  child: Text(
                    "هل نسيت كلمة المرور؟",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xff898A8F),
                    ),
                  ),
                ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
