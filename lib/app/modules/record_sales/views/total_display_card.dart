// lib/widgets/total_display_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../AppColor/appColor.dart';

class TotalDisplayCard extends StatelessWidget {
  final String title;
  final String value;

  const TotalDisplayCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.455,
      height: Get.height * 0.12,
      child: Card(
        color: AppColor.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
