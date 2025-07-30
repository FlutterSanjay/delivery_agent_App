import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../AppColor/appColor.dart';
import '../../../AppColor/appTextStyle.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'assigned':
        backgroundColor = AppColor.warning;
        textColor = Colors.white;
        displayText = 'Assigned';
        break;
      case 'delivered':
        backgroundColor = AppColor.success;
        textColor = Colors.white;
        displayText = 'Delivered';
        break;
      default:
        backgroundColor = AppColor.grey;
        textColor = Colors.black;
        displayText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(displayText, style: AppTextStyles.smallText.copyWith(color: textColor)),
    );
  }
}
