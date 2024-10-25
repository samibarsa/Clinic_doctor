import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_password_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpEmailView extends StatelessWidget {
  const SignUpEmailView({super.key, required this.doctorName});
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    TextEditingController email = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    void submitForm() {
      if (formKey.currentState!.validate()) {
        // النموذج صحيح
        MovingNavigation.navTo(context,
            page: SignUpPasswordView(
              email: email.text,
              phone: phoneNumber.text,
              doctorName: doctorName,
            ));
       
      } 
    }

    return Scaffold(
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

          return null; // لا يوجد خطأ
        },
        firstKeyboardType: TextInputType.emailAddress,
        secondKeyboardType: TextInputType.phone,
        firstTextEditingFiled: email,
        secondTextEditingFiled: phoneNumber,
        onTap: () {
          submitForm();
        },
        firstFiled: "البريد الاكتروني",
        secondFiled: "رقم الهاتف",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
        buttontitle: 'التالي',
      ),
    );
  }
}
