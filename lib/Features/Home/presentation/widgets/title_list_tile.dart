import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleListTile extends StatelessWidget {
  const TitleListTile({
    super.key,
    required this.patientName,
    required this.type,
    required this.date,
  });
  final String patientName;
  final String type;
  final String date;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize10 = screenWidth * 0.035;
    return Padding(
      padding: EdgeInsets.only(left: 0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patientName,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize10),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      type,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, top: 4.h),
                  child: Row(
                    children: [
                      Text(
                        date,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(AppColor.primaryColor),
                          decorationColor: const Color(AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
