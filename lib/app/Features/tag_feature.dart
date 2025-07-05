import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../AppColor/appColor.dart';
import '../modules/onboaeding/views/onboaeding_view.dart';

class TagFeature extends StatelessWidget {
  final String txtName;
  final Color txtColor;
  final FontWeight fontWeight;
  final double fontSize;
  final Color borderColor;

  const TagFeature({
    super.key,
    required this.txtName,
    required this.txtColor,
    required this.fontWeight,
    required this.fontSize,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.27,
      height: Get.height * 0.04,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primary, width: 1.5),
      ),
      child: CommonText(
        txtName: txtName,
        txtColor: txtColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
