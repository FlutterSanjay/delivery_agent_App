import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../AppColor/appColor.dart';
import '../controllers/page_not_found_controller.dart';

class PageNotFoundView extends GetView<PageNotFoundController> {
  const PageNotFoundView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.success.withAlpha(10),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated '404' text
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showErrorText.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.8, end: 1.0), // Scale from 0.8 to 1.0
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.elasticOut, // Gives a nice bounce effect
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Text(
                        '404',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Animated "Oops! Page Not Found."
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showDetails.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Text(
                  'Oops! Page Not Found.',
                  style: TextStyle(color: AppColor.onPrimary, fontSize: 24.sp),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Animated "The page you are looking for..."
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showDetails.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Text(
                  'The page you are looking for does not exist.',

                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Animated "Go to Home" button
            Obx(
              () => AnimatedScale(
                scale: controller.showDetails.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack, // A fun bouncy scale-in
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryVariant1,
                  ),
                  onPressed: () => controller.goHome(),
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    'Go to Home',
                    style: TextStyle(color: AppColor.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
