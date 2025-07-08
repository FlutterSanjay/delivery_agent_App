import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPageController extends GetxController {
  final pageController = PageController(); // Controls the PageView
  final currentPageIndex = 0.obs; // Observable for the current page index

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      // Update the observable index when page changes
      currentPageIndex.value = pageController.page?.round() ?? 0;
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPageIndex.value < 2) {
      // Assuming 3 pages (0, 1, 2)
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Last page, navigate to main app or login
      navigateToHome();
    }
  }

  void skipOnboarding() {
    // Directly navigate to main app or login
    navigateToHome();
  }

  void navigateToHome() {
    // Replace with your actual navigation logic
    // For now, we'll just print and pop the onboarding screen
    print("Navigating to Home/Login Screen!");
    Get.offAllNamed('/onboaeding'); // Example: Navigate to your home route
    // You might also set a flag in GetStorage here to indicate onboarding is complete
    // GetStorage().write('onboarding_complete', true);
  }
}
