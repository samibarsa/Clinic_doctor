import 'package:doctor_app/Features/Auth/presentation/widget/verify_token.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RessetPassword extends StatelessWidget {
  RessetPassword({super.key});

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني")),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => VerificationScreen(
                      email: emailController.text,
                    )), // الصفحة الجديدة التي تريد الانتقال إليها
            (Route<dynamic> route) => false, // إزالة جميع الصفحات السابقة
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
              forceMaterialTransparency: true,
              centerTitle: true,
              title: const Text("إعادة تعيين كلمة المرور"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Text(
                        "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل بريدًا إلكترونيًا متضمناً رمز التحقق لإعادة ضبط كلمة المرور الخاصة بك",
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomTextField(
                        textEditingController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          return null; // في حال كان الإدخال صحيحًا
                        },
                        title: "البريد الإلكتروني",
                        radius: 6.r,
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    CustomButton(
                      title: "إرسال",
                      color: AppColor.primaryColor,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<AuthCubit>(context)
                              .ressetPassword(emailController.text);
                        }
                      },
                      titleColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
