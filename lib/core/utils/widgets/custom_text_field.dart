import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.validator,
      required this.title,
      required this.radius,
      required this.textEditingController,
      required this.keyboardType,
      this.prefix,
      this.suffix});
  final String title;
  final double radius;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width) / 10,
      height: MediaQuery.of(context).size.height / 18,
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        controller: textEditingController,
        style: TextStyle(fontSize: 12.sp, height: 1.h),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: prefix,
            focusColor: Colors.black,
            hintText: title,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
            border: outLineInputBorder(2, radius),
            enabledBorder: outLineInputBorder(1, radius),
            focusedBorder: outLineInputBorder(2, radius)),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder(
    double width,
    double radius,
  ) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
            color:
                title != "مريض,تصوير مقطعي" ? Colors.black : Colors.transparent,
            width: width));
  }
}
