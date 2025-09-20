import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image placeholder
            Container(
              width: Get.width * 0.32,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(width: 12.w),

            // Right content placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(height: 16.h, width: 140.w, color: Colors.white),
                  SizedBox(height: 10.h),

                  // Subtitle
                  Container(height: 14.h, width: 100.w, color: Colors.white),
                  SizedBox(height: 10.h),

                  // Address line
                  Container(height: 14.h, width: 160.w, color: Colors.white),
                  SizedBox(height: 20.h),

                  // Action buttons row
                  Row(
                    children: [
                      Container(height: 30.h, width: 80.w, color: Colors.white),
                      SizedBox(width: 8.w),
                      Container(height: 30.h, width: 30.h, color: Colors.white),
                      SizedBox(width: 8.w),
                      Container(height: 30.h, width: 30.h, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
