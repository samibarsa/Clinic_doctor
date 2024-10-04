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
            textTheme:  const TextTheme(
              bodyMedium: TextStyle(
                fontFamily: AppFont.primaryFont, // Use your custom font here
                fontSize: 16.0, // Adjust the font size as needed
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
