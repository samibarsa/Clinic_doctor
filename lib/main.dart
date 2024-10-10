import 'package:doctor_app/Features/Splash/splash_screan.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ClinicDoctor());
}

class ClinicDoctor extends StatelessWidget {
  const ClinicDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppFont.primaryFont, // تطبيق الخط على جميع النصوص
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
