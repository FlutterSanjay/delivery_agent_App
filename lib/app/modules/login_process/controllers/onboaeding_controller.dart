import 'package:delivery_agent/app/modules/signUp_page/views/sign_up_page_view.dart';
import 'package:delivery_agent/app/modules/store_list/views/store_list_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../auth/otp_service.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboaedingController
  TextEditingController mobileNo = TextEditingController();
  RxBool showOtpFeild = false.obs;
  RxBool isLoading = false.obs;
  OTPService otpService = OTPService();
  bool isOtpSent = false;

  TextEditingController userEnterOtp = TextEditingController();

  void login() async {
    try {
      final phone = mobileNo.text.trim();
      if (phone.isEmpty || phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
        return;
      } else {
        final response = await otpService.checkUserExist(phone);
        if (response == 200) {
          print("Response :$response");
          showOtpFeild.value = true;

          await otpService.sendOTP(phone, isResend: isOtpSent);

          isOtpSent = true;

          Get.snackbar(
            'Success',
            'OTP ${isOtpSent ? "resent" : "sent"} to +91$phone',
            duration: 2.seconds,
          );
        } else {
          Get.snackbar('Error', 'User Not Register');
        }
        // Add navigation or other logic here
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  void verifyOTP() async {
    isLoading.value = true; // Start loading

    try {
      final verifyOtpService = await otpService.verifyOTP(userEnterOtp.text);

      if (verifyOtpService) {
        // ✅ OTP sahi hai
        isLoading.value = false;

        Get.offAll(
          () => StoreListView(),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
        return;
      } else {
        // ❌ OTP galat ya fail
        isLoading.value = false;
        Get.snackbar('Error', 'Invalid OTP, please try again');
      }
    } catch (e) {
      // ❌ Server error / exception
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  void navigateToSignUp() {
    Get.to(
      () => SignUpPageView(),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 600),
    );
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
    userEnterOtp.dispose();

    // phoneNumber.dispose();

    super.dispose();
  }
}
