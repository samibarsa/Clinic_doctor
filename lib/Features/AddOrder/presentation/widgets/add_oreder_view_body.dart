import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddOrederViewBody extends StatelessWidget {
  const AddOrederViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 48.h,
          ),
          CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا يمكن أن يكون هذا الحقل فارغا';
                }
                return null;
              },
              title: "اسم المربض",
              radius: 6.r,
              textEditingController: TextEditingController(),
              keyboardType: TextInputType.text),
          SizedBox(
            height: 26.h,
          ),
          CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا يمكن أن يكون هذا الحقل فارغا';
                }
                return null;
              },
              title: "رقم الهاتف",
              radius: 6.r,
              textEditingController: TextEditingController(),
              keyboardType: TextInputType.phone),
          SizedBox(
            height: 404.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(ImagesPath.nextButton),
              const Text("الخطوة 1/4")
            ],
          )
        ],
      ),
    );
  }
}
