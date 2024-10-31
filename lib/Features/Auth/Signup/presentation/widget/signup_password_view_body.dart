import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_state.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPasswordView extends StatefulWidget {
  const SignUpPasswordView({
    super.key,
    required this.email,
    required this.phone,
    required this.doctorName,
  });

  final String email;
  final String phone;
  final String doctorName;

  @override
  _SignUpPasswordViewState createState() => _SignUpPasswordViewState();
}

class _SignUpPasswordViewState extends State<SignUpPasswordView> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  bool inAsyncCall = false;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _progressAnimation = Tween<double>(begin: 2 / 3, end: 3 / 3).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).signUp(widget.email, passwordController.text);
    }
  }

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() => inAsyncCall = false);
        } else if (state is AuthLoading) {
          setState(() => inAsyncCall = true);
        } else if (state is AuthFailure) {
          setState(() => inAsyncCall = false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          color: const Color(AppColor.primaryColor),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) => LinearProgressIndicator(
                    value: _progressAnimation.value,
                    minHeight: 5,
                    color: Colors.green,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ),
            ),
            body: AuthViewBody(
              formKey: formKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا يمكن أن يكون هذا الحقل فارغا';
                }
                if (value != passwordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
              firstTextEditingFiled: passwordController,
              firstKeyboardType: TextInputType.text,
              secondTextEditingFiled: confirmPasswordController,
              secondKeyboardType: TextInputType.text,
              onTap: () => submitForm(context),
              firstFiled: "كلمة السر",
              secondFiled: "تأكيد كلمة السر",
              questestion: "لديك حساب بالفعل ؟",
              state: "سجل دخول",
              buttontitle: 'إنشاء حساب',
            ),
          ),
        );
      },
    );
  }
}
