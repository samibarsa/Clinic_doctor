import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddPatient/add_patient_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddPatient/add_patient_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddOrederViewBody extends StatelessWidget {
  const AddOrederViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController age = TextEditingController();
    final formKey = GlobalKey<FormState>();
    void submitForm(BuildContext context) {
      if (formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();
        Map<String, dynamic> patientInfo = {
          'patient_name': name.text,
          'phone_number': phone.text,
          'age': age.text
        };
        BlocProvider.of<AddPatientCubit>(context).addPatient(patientInfo);
      }
    }

    return BlocBuilder<AddPatientCubit, AddPatientState>(
      builder: (context, state) {
        if (state is AddPatientLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AddPatientSucsess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('! تم إضافة المريض بنجاح')),
            );
          });
        } else if (state is AddPatientError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          });
        }

        // Form UI code continues here...
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48.h),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لا يمكن أن يكون هذا الحقل فارغا';
                    }
                    return null;
                  },
                  title: "اسم المريض",
                  radius: 6.r,
                  textEditingController: name,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 26.h),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لا يمكن أن يكون هذا الحقل فارغا';
                    }
                    return null;
                  },
                  title: "رقم الهاتف",
                  radius: 6.r,
                  textEditingController: phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 26.h),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لا يمكن أن يكون هذا الحقل فارغا';
                    }
                    return null;
                  },
                  title: "العمر",
                  radius: 6.r,
                  textEditingController: age,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 200.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        submitForm(context);
                      },
                      child: SvgPicture.asset(ImagesPath.nextButton),
                    ),
                    const Text("الخطوة 1/4"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
