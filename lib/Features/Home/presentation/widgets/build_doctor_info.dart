import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget buildDoctorInfo(OrderState state) {
  if (state is OrderLoading) {
    // إذا كانت البيانات لا تزال في حالة تحميل، عرض CircularProgressIndicator
    return Row(
      children: [
        SvgPicture.asset(ImagesPath.doctor),
        SizedBox(width: 8.w),
        const CircularProgressIndicator() // عرض المؤشر أثناء تحميل الاسم
      ],
    );
  } else if (state is OrderLoaded) {
    // إذا كانت البيانات قد تم تحميلها بنجاح، عرض اسم الطبيب
    return Row(
      children: [
        SvgPicture.asset(ImagesPath.doctor),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أهلاً وسهلاً!",
              style: TextStyle(fontSize: 12.sp, color: const Color(0xff6A6A6A)),
            ),
            Text(
              state.doctor.name, // عرض اسم الطبيب
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  } else {
    // يمكنك إضافة حالة أخرى هنا، مثل حالة خطأ
    return const Text("حدث خطأ في تحميل البيانات");
  }
}
