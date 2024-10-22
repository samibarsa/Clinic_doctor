import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTextWidgets extends StatelessWidget {
  const HomeTextWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(ImagesPath.filter),
        SizedBox(width: 10.w,),
        SizedBox(width: 329.w,child:  CustomTextField(title: "مريض,تصوير مقطعي",radius: 24.r, textEditingController: TextEditingController(),)),
        SizedBox(width: 10.w,),
      ],
    );
  }
}
