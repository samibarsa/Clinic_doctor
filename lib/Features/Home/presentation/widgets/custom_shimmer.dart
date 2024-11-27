import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 35.h,
            color: Colors.white,
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      color: Colors.white,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 14.h,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 12.h,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
