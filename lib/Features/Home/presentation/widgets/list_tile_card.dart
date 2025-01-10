import 'package:doctor_app/Features/Home/presentation/widgets/title_list_tile.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    super.key,
    required this.papatientName,
    required this.type,
    required this.date,
  });
  final String date;
  final String papatientName;
  final String type;
  @override
  Widget build(BuildContext context) {
    String imagePath = "";
    switch (type) {
      case "C.B.C.T":
        imagePath = ImagesPath.cbctIcon;
        break;
      case "سيفالوماتريك":
        imagePath = ImagesPath.cefaloIcon;
        break;
      case "بانوراما":
        imagePath = ImagesPath.panoramaIcon;
        break;
    }
    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize10 = screenWidth * 0.035;
    double fontSize12 = screenWidth * 0.050;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 80.h,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListTile(
              trailing: Padding(
                padding: EdgeInsets.only(
                  bottom: 15.h,
                ),
                child: SvgPicture.asset(
                  ImagesPath.arrowListTile,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SvgPicture.asset(imagePath),
              ),
              title: TitleListTile(
                patientName: papatientName,
                type: type,
                date: date,
              )),
        ),
      ),
    );
  }
}
