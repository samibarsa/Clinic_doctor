import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreanBody extends StatelessWidget {
  const HomeScreanBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            ImagesPath.logo,
            height: 300,
            width: 300,
          ),
          SvgPicture.asset(ImagesPath.wellcome),
        ],
      ),
    );
  }
}
