import 'package:doctor_app/Features/AddOrder/presentation/widgets/section_title.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_radio_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRadioBody extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onOptionChanged;
  final String title;
  final void Function() onTap;
  final String titleButton;
  final int patientId;
  const AddRadioBody({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.title,
    required this.onTap,
    required this.titleButton,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 54.h),
            SectionTitle(title: title),
            const SizedBox(height: 10),
            // توليد RadioTiles ديناميكيًا
            ...options.map((option) {
              return CustomRadioTile(
                title: option,
                value: option,
                groupValue: selectedOption,
                onChanged: onOptionChanged,
              );
            }),
            const Spacer(),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 9.w),
                width: 361.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: const Color(AppColor.primaryColor)),
                ),
                child: CustomButton(
                  title: titleButton,
                  color: 0xffFFFF,
                  onTap: onTap,
                  titleColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 145.h),
          ],
        ),
      ),
    );
  }
}
