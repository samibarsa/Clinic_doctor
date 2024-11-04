import 'package:doctor_app/Features/Home/presentation/widgets/home_view_body.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/title_list_tile.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 80.h,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          color: const Color(0xfffefefe),
          child: ListTile(
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("منذ ساعة"),
              ],
            ),
            leading: SvgPicture.asset(ImagesPath.xray),
            title: const TitleListTile(),
          ),
        ),
      ),
    );
  }
}
