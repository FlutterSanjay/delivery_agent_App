import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerBarIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const DrawerBarIconButton({
    Key? key,
    this.icon = Icons.menu_rounded,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(8.w),

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          // borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: iconColor, size: 24.sp),
      ),
    );
  }
}
