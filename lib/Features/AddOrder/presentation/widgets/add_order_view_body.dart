import 'package:doctor_app/Features/AddOrder/presentation/pages/add_pano_view_1.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddOrderViewBody extends StatelessWidget {
  const AddOrderViewBody({
    super.key,
    required this.patientId,
  });
  final int patientId;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          _buildCarrlListTile("تصوير ماجيك بانوراما", () {
            MovingNavigation.navTo(context,
                page: AddPanoView1(
                  patientId: patientId,
                ));
          }),
          _buildCarrlListTile("تصوير سيفالومتريك", () {}),
          _buildCarrlListTile("تصوير مقطعي C.B.C.T", () {}),
        ],
      ),
    );
  }
}

Widget _buildCarrlListTile(String title, void Function()? onTap) {
  return Card(
    margin: const EdgeInsets.all(12),
    child: InkWell(
      onTap: onTap,
      child: ListTile(
        minVerticalPadding: 24.h,
        trailing: SvgPicture.asset(ImagesPath.arrow),
        subtitle: Text(title),
        minTileHeight: 48.h,
      ),
    ),
  );
}
