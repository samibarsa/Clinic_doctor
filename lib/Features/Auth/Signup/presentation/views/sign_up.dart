import 'package:doctor_app/Features/Auth/Signup/presentation/widget/signup_email_view_body.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/Auth_view_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = TextEditingController();
    TextEditingController secondName = TextEditingController();
    final formKey = GlobalKey<FormState>();
    void submitForm() {
      if (formKey.currentState!.validate()) {
        // النموذج صحيح
        MovingNavigation.navTo(context,
            page: SignUpEmailView(
              doctorName: "${firstName.text} ${secondName.text}",
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
        firstTextEditingFiled: firstName,
        firstKeyboardType: TextInputType.text,
        secondKeyboardType: TextInputType.text,
        secondTextEditingFiled: secondName,
        onTap: () {submitForm();},
        firstFiled: "الاسم الأول",
        secondFiled: "الاسم الثاني",
        questestion: "لديك حساب بالغعل ؟",
        state: "سجل دخول",
        buttontitle: 'التالي',
      ),
    );
  }
}
