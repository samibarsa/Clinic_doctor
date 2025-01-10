import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.titleColor,
  });
  final String title;
  final int color;
  final void Function()? onTap;
  final Color titleColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(5.r)),
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width) / 10,
        height: MediaQuery.of(context).size.height / 18,
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: titleColor),
        )),
      ),
    );
  }
}
