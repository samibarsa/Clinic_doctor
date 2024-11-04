import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeSearchTextFiled extends StatelessWidget {
  const HomeSearchTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF6F7F7),
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: CustomTextField(
        prefix: SvgPicture.asset(
          ImagesPath.filter,
          fit: BoxFit.none,
        ),
        suffix: const Icon(Icons.search),
        title: "مريض,تصوير مقطعي",
        radius: 12.r,
        textEditingController: TextEditingController(),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
