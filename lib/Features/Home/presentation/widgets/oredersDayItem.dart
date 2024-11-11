// ignore_for_file: file_names

import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/title_list_tile.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OredersDayItem extends StatelessWidget {
  const OredersDayItem({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: SizedBox(
          height: 80.h,
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            color: const Color(0xfffefefe),
            child: ListTile(
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'منذ ساعة',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
              leading: Padding(
                padding: EdgeInsets.only(bottom: 13.h),
                child: SvgPicture.asset(
                  ImagesPath.xray,
                  height: 44.h,
                  width: 44.w,
                ),
              ),
              title: TitleListTile(
                patientName: order.patientId.toString(),
                type: order.detail.type.typeName,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
