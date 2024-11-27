import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListTileCard extends StatelessWidget {
  const ShimmerListTileCard({super.key});

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
            trailing: Padding(
              padding: EdgeInsets.only(
                bottom: 15.h,
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  color: Colors.white,
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 16.h,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 14.h,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 12.h,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
