// ignore_for_file: file_names

import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:doctor_app/core/utils/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthViewBody extends StatelessWidget {
 const AuthViewBody(
      {super.key,
      required this.firstFiled,
      required this.secondFiled,
      required this.state,
      required this.questestion,
      required this.onTap,
      required this.buttontitle,
      required this.firstTextEditingFiled,
      required this.secondTextEditingFiled,
      required this.firstKeyboardType,
      required this.secondKeyboardType,  this.formKey, this.validator});

  final String firstFiled;
 final String? Function(String?)? validator;
  final String secondFiled;
  final TextEditingController firstTextEditingFiled;
  final TextEditingController secondTextEditingFiled;
  final TextInputType firstKeyboardType;
  final TextInputType secondKeyboardType;
  final String state;
  final String questestion;
  final void Function()? onTap;
  final String buttontitle;
  final Key? formKey ; //
  void dispose() {
    firstTextEditingFiled.dispose();
    secondTextEditingFiled.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SvgPicture.asset(buttontitle=='تسجيل دخول'?ImagesPath.login:ImagesPath.creatAccount),
              SizedBox(
                height: 52.h,
              ),
              CustomTextField(
                validator: validator,
                keyboardType: firstKeyboardType,
                title: firstFiled,
                radius: 12,
                textEditingController: firstTextEditingFiled,
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextField(
                validator:validator,
                keyboardType: secondKeyboardType,
                radius: 12,
                title: secondFiled,
                textEditingController: secondTextEditingFiled,
              ),
              SizedBox(
                height: 54.5.h,
              ),
              CustomButton(
                  title: buttontitle,
                  color: AppColor.primaryColor,
                  onTap: onTap,
                  titleColor: Colors.white),
              SizedBox(
                height: 36.h,
              ),
              SvgPicture.asset(ImagesPath.or),
              SizedBox(
                height: 36.h,
              ),
              const GoogleButton(),
              SizedBox(
                height: 44.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state,
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  Text(
                    questestion,
                    style: TextStyle(
                        color: const Color(0xff898A8F), fontSize: 11.sp),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 
}
