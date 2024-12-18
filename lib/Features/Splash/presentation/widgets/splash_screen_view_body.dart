import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';

class SplashScreenViewBody extends StatelessWidget {
  const SplashScreenViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImagesPath.logo,
        height: 300,
        width: 300,
      ),
    );
  }
}
