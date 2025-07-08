import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  void navigatedToOnBoardScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3), () {
      //TODO: 1. Check the Authentication after splash screen
      // TODO: a. User Exist move to Home Screen
      // TODO: b. User Not Exist move to Login Screen
      Get.offNamed(Routes.ON_BOARDING_PAGE);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
