import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final storage = StorageService();
  void navigatedToOnBoardScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3), () {
      //TODO: 1. Check the Authentication after splash screen
      if (storage.getUserToken() != null) {
        Get.offNamed(Routes.STORE_LIST);
        return;
      }
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
