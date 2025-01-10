import 'package:doctor_app/Features/Auth/presentation/maneger/update_password_cubit/update_password_cubit.dart';
import 'package:doctor_app/Features/wellcome/presentation/views/wellcome.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final confirmPasswordController = TextEditingController();
    final passwordController = TextEditingController();

    void submitForm(BuildContext context) {
      if (formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();
        BlocProvider.of<UpdatePasswordCubit>(context)
            .updatePassword(confirmPasswordController.text);
      }
    }

    return BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
      listener: (context, state) {
        if (state is UpdatePasswordSucsess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const WellcomeScrean(),
              ),
              (Route<dynamic> route) => false);
        }
        if (state is UpdatePasswordFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Color(AppColor.primaryColor),
          ),
          inAsyncCall: state is UpdatePasswordLoading,
          child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: const Text("انشئ كلمة مرور جديدة"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 34.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "يجب أن تكون كلمة المرور الجديدة الخاصة بك مختلفة عن كلمات المرور المستخدمة السابقة.",
                          style: TextStyle(
                              fontSize: 12.sp, color: const Color(0xff696969)),
                        ),
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لا يمكن أن يكون هذا الحقل فارغا';
                          }
                          if (value.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }
                          if (value != confirmPasswordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },
                        title: "كلمة السر",
                        radius: 5.r,
                        textEditingController: passwordController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لا يمكن أن يكون هذا الحقل فارغا';
                          }
                          if (value.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }
                          if (value != passwordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },
                        title: "تأكيد كلمة السر",
                        radius: 5.r,
                        textEditingController: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        // To hide password input
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      CustomButton(
                        title: "إعادة التعيين",
                        color: AppColor.primaryColor,
                        onTap: () {
                          submitForm(context);
                        },
                        titleColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
