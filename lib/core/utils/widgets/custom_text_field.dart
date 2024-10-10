import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 361.w,
      child: TextField(
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          focusColor: Colors.black,
          hintText: title,
          hintTextDirection: TextDirection.rtl,
          hintStyle:  TextStyle(fontWeight: FontWeight.w400, fontSize: 13.sp,),
          border: outLineInputBorder(2),
          enabledBorder: outLineInputBorder(1),
          focusedBorder: outLineInputBorder(2)
        ),
      ),
    );
  }

  OutlineInputBorder outLineInputBorder(double width) {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Colors.black,width: width)
        );
  }
}
