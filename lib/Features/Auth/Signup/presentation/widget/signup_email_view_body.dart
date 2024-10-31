import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_password_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpEmailView extends StatefulWidget {
  const SignUpEmailView({super.key, required this.doctorName});
  final String doctorName;

  @override
  _SignUpEmailViewState createState() => _SignUpEmailViewState();
}

class _SignUpEmailViewState extends State<SignUpEmailView> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _progressAnimation = Tween<double>(begin: 1 / 3, end: 2 / 3).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      MovingNavigation.navTo(
        context,
        page: SignUpPasswordView(
          email: emailController.text,
          phone: phoneNumberController.text,
          doctorName: widget.doctorName,
        ),
      );
    }
  }

  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        validator: (value) => value == null || value.isEmpty ? 'لا يمكن أن يكون هذا الحقل فارغا' : null,
        firstTextEditingFiled: emailController,
        firstKeyboardType: TextInputType.emailAddress,
        secondTextEditingFiled: phoneNumberController,
        secondKeyboardType: TextInputType.phone,
        onTap: submitForm,
        firstFiled: "البريد الإلكتروني",
        secondFiled: "رقم الهاتف",
        questestion: "لديك حساب بالفعل ؟",
        state: "سجل دخول",
        buttontitle: 'التالي',
      ),
    );
  }
}
