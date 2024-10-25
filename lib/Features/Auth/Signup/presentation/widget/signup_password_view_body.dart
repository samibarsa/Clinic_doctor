import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPasswordView extends StatefulWidget {
  const SignUpPasswordView({
    Key? key,
    required this.email,
    required this.phone,
    required this.doctorName,
  }) : super(key: key);

  final String email;
  final String phone;
  final String doctorName;

  @override
  _SignUpPasswordViewState createState() => _SignUpPasswordViewState();
}

class _SignUpPasswordViewState extends State<SignUpPasswordView> {
  final formKey = GlobalKey<FormState>();
  bool inAsyncCall = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .signUp(widget.email, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            inAsyncCall = false;
          });
          // Save the phone and doctorName in SharedPreferences
          // تأكد من إضافة التهيئة الصحيحة لـ SharedPreferences هنا
          // prefs.setString(CachedName.phone, widget.phone);
          // prefs.setString(CachedName.doctorName, widget.doctorName);
        } else if (state is AuthLoading) {
          setState(() {
            inAsyncCall = true;
          });
        } else if (state is AuthFailure) {
          setState(() {
            inAsyncCall = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("إنشاء حساب"),
              centerTitle: true,
            ),
            body: AuthViewBody(
              formKey: formKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا يمكن أن يكون هذا الحقل فارغا'; // تحقق من أن الحقل ليس فارغًا
                }
                if (value != passwordController.text) {
                  return 'كلمة المرور غير متطابقة'; // تحقق من تطابق الحقول
                }
                return null; // لا يوجد خطأ
              },
              firstKeyboardType: TextInputType.text,
              secondKeyboardType: TextInputType.text,
              onTap: () => submitForm(context),
              firstFiled: "كلمة السر",
              secondFiled: "تأكيد كلمة السر",
              questestion: "لديك حساب بالغعل؟",
              state: "سجل دخول",
              buttontitle: 'انشىء حساب',
              firstTextEditingFiled: passwordController,
              secondTextEditingFiled: confirmPasswordController,
            ),
          ),
        );
      },
    );
  }
}
