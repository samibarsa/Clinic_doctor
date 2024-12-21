import 'package:doctor_app/Features/Auth/presentation/views/login_view.dart';
import 'package:doctor_app/Features/Auth/presentation/widget/signup_email_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final int currentStep = 1;
  final int totalSteps = 3;

  @override
  void initState() {
    super.initState();
    // إعداد AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // مدة الأنيميشن
    )..forward(); // بدء الأنيميشن تلقائيًا عند التحميل
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = TextEditingController();
    TextEditingController secondName = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void submitForm() {
      if (formKey.currentState!.validate()) {
        MovingNavigation.navTo(
          context,
          page: SignUpEmailView(
            doctorName: "${firstName.text} ${secondName.text}",
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animationController.value * (currentStep / totalSteps),
                minHeight: 5,
                color: Colors.green,
                backgroundColor: Colors.grey[300],
              );
            },
          ),
        ),
      ),
      body: AuthViewBody(
        navigation: () {
          MovingNavigation.navTo(context, page: const LoginView());
        },
        formKey: formKey,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'لا يمكن أن يكون هذا الحقل فارغا'; // تحقق من أن الحقل ليس فارغًا
          }
          return null; // لا يوجد خطأ
        },
        firstTextEditingFiled: firstName,
        firstKeyboardType: TextInputType.text,
        secondKeyboardType: TextInputType.text,
        secondTextEditingFiled: secondName,
        onTap: () {
          submitForm();
        },
        firstFiled: "الاسم الأول",
        secondFiled: "الاسم الثاني",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
        buttontitle: 'التالي',
      ),
    );
  }
}
