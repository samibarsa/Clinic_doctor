import 'package:doctor_app/Features/Auth/Login/presentation/widget/update_password.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final String email;

  VerificationScreen({super.key, required this.email});
  
  void showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("خطأ"),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("حسنًا"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit, VerifyState>(
      listener: (context, state) {
        if (state is VerifySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("الرمز صحيح، قم بتحديث كلمة المرور")));
              MovingNavigation.navTo(context, page: const UpdatePassword());
        } else if (state is VerifyFailure) {
          showErrorDialog(context, state.error); // عرض رسالة الخطأ في حوار
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is VerifyLoading,
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "الرجاء التحقق من الايميل الخاص بك",
                    style: TextStyle(fontWeight: FontWeight.w800),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "$email :تم إرسال رمز التحقق إلى الإيميل",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff696969),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.number,
                      backgroundColor: Colors.white,
                      cursorColor: Colors.black,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        disabledColor: Colors.white,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        errorBorderColor: Colors.red,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 44,
                        fieldWidth: 44,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.black,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: pinController,
                      onCompleted: (tok) {
                        BlocProvider.of<VerifyCubit>(context)
                            .verifyToken(email, tok, context);
                      },
                    ),
                  ),

                  SizedBox(height: 172.h),

                  CustomButton(
                    title: "تحقق",
                    color: AppColor.primaryColor,
                    onTap: () {
                      BlocProvider.of<VerifyCubit>(context)
                          .verifyToken(email, pinController.text, context);
                    },
                    titleColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
