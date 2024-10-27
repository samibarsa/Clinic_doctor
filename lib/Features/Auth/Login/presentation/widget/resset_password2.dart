import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("الرجاء التحقق من الإيميل الخاص بك"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "تم إرسال رمز التحقق إلى الإيميل",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 5, // عدد الخانات المطلوبة
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.grey.shade300,
                inactiveFillColor: Colors.grey.shade200,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: textEditingController,
              onCompleted: (v) {
                print("رمز التحقق: $v"); // يمكنك استخدام الرمز هنا
              },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                return true; // السماح بلصق النص
              },
            ),
          ],
        ),
      ),
    );
  }
}
