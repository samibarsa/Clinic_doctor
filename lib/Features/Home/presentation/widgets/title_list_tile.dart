import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleListTile extends StatelessWidget {
  const TitleListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "اسم المريض",
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      " طلب تصوير شعاعي",
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
                        "التفاصيل",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(AppColor.primaryColor),
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(AppColor.primaryColor),
                        ),
                      ),
                      Text(
                        " >",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(AppColor.primaryColor),
                        ),
                      )
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
