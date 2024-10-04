import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.title, required this.color,
  });
    final String title;
    final int color;
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(color:   Color(color),
      borderRadius: BorderRadius.circular(5.r)
      ),
      width: 361.w,
      height: 44.h,
      child:  Center(child: Text(title,textAlign: TextAlign.center,style: const TextStyle(),)),
    );
  }
}
