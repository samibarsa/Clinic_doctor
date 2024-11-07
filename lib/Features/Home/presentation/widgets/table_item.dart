import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    super.key,
    required this.title,
    required this.value,
    required this.topradius,
    required this.buttomradius,
  });
  final String title;
  final String value;
  final double topradius;
  final double buttomradius;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 40.h,
            width: 252.w,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE4F3E5))),
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            )),
        Container(
          height: 40.h,
          width: 109.w,
          decoration: BoxDecoration(
            color: const Color(0xffE4F3E5),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(topradius.r),
                bottomRight: Radius.circular(buttomradius.r)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        // 0xffE4F3E5
      ],
    );
  }
}
