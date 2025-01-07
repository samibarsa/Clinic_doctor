import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenViewBody extends StatelessWidget {
  const SplashScreenViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagesPath.logo,
            height: 300.h, // استخدم ScreenUtil لتكون الأبعاد مرنة.
            width: 300.w,
          ),
          SizedBox(height: 20.h),
          Text(
            'ليس لدينا فرع آخر',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: Text(
              'حلب - الفرقان - دوار الشرطة - مفرق مشفى الفرقان',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis, // لتجنب تجاوز النص.
              maxLines: 2, // يضمن أن النص يعرض في سطرين كحد أقصى.
            ),
          ),
        ],
      ),
    );
  }
}
