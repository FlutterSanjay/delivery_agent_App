import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 70.w,
        height: 70.w,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: const [Colors.orange, Colors.green, Colors.blue],
          strokeWidth: 2.w,
        ),
      ),
    );
  }
}
