import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../imagePath/imagePath.dart';
import '../controllers/on_boarding_page_controller.dart';

class OnBoardingPageView extends GetView<OnBoardingPageController> {
  const OnBoardingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.currentPageIndex.value = index; // Update observable on swipe
            },
            children: const [
              // Page 1: Boost Your Profits
              OnboardingPage(
                imagePath: ImagePath.wallet, // Create this asset
                title: 'Boost Your Profits',
                description: 'Low prices + high margins = Happy business!',
              ),
              // Page 2: Onboard Stores Effortlessly
              OnboardingPage(
                imagePath: ImagePath.coffee, // Create this asset
                title: 'Onboard Stores Effortlessly',
                description: 'Build Your Retail Empire',
              ),
              // Page 3: Delivery Ninja
              OnboardingPage(
                imagePath: ImagePath.map, // Create this asset
                title: 'Delivery Ninja',
                description: "Moon's List, Sun's Gift.",
              ),
            ],
          ),
          // Positioned controls (dots, skip, next/get started button)
          Positioned(
            bottom: 30.h, // Adjust as needed
            left: 0.w,
            right: 0.w,
            child: Column(
              children: [
                // Dots Indicator
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      // 3 pages
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: controller.currentPageIndex.value == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: controller.currentPageIndex.value == index
                              ? AppColor
                                    .primary // Active dot color
                              : AppColor.mostUsedGrey, // Inactive dot color
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip Button
                        controller.currentPageIndex.value == 2
                            ? const SizedBox.shrink() // Hide skip on last page
                            : TextButton(
                                style: TextButton.styleFrom(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  maximumSize: Size(90.w, 50.h),
                                  backgroundColor: AppColor.lightGreyBackground,
                                ),
                                onPressed: controller.skipOnboarding,
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: AppColor.mostUsedGrey,
                                  ),
                                ),
                              ),
                        // Next / Get Started Button
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: controller.nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                minimumSize: Size(90.w, 50.h), // Ensure button size
                              ),
                              child: Text(
                                controller.currentPageIndex.value == 2
                                    ? 'Get Started'
                                    : 'Next',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColor.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for individual onboarding pages
class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 250.h, // Adjust size as needed
          ),
          SizedBox(height: 40.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: AppColor.mostUsedGrey),
          ),
        ],
      ),
    );
  }
}
