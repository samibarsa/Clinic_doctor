import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomButton(title: "انشىء حساب بواسطة جوجل", color: 0xffE4F3E5, onTap: (){}, titleColor: Colors.black),
        Padding(
          padding: const EdgeInsets.only(top: 12,left: 280),
          child: SvgPicture.asset(ImagesPath.google),
        ),
      ],
    );
  }
}
