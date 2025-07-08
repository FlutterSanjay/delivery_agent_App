import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboaedingController
  TextEditingController mobileNo = TextEditingController();
  RxBool showOtpFeild = true.obs;

  final phoneNumber = ''.obs;
  final OtpFieldController otpController = OtpFieldController();
  void login() {
    if (phoneNumber.value.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number');
    } else {
      Get.snackbar('Success', 'Login successful');
      // Add navigation or other logic here
    }
  }

  void navigateToSignUp() {
    // Add navigation to sign up screen
    Get.snackbar('Sign Up', 'Navigate to sign up screen');
  }

  final count = 0.obs;
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

  @override
  void dispose() {
    mobileNo.dispose();
    // phoneNumber.dispose();

    super.dispose();
  }

  void increment() => count.value++;
}
