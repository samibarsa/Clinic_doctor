import 'package:doctor_app/Features/Splash/splash_screan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClinicDoctor());
}

class ClinicDoctor extends StatelessWidget {
  const ClinicDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
