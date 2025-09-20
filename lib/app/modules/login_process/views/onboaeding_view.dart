import 'dart:ffi';

import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../AppColor/appColor.dart';
import '../controllers/onboaeding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            // Added to prevent overflow
            child: ConstrainedBox(
              // Added to ensure proper constraints
              constraints: BoxConstraints(
                minHeight: Get.height - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h), // Added spacing
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImagePath.onboardOne,
                      width: Get.width * 0.8, // Constrained image width
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.h,
                      left: Get.width * 0.1,
                      right: Get.width * 0.1, // Added right margin for balance
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Login Now',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'And Enjoy',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'High Margins',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: CommonText(
                        txtName: controller.showOtpFeild.value
                            ? "Enter OTP"
                            : "Phone Number",
                        txtColor: AppColor.onSecondary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.showOtpFeild.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                            child: OTPTextField(
                              length: 6,
                              width: Get.width * 0.9,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 45.w,
                              fieldStyle: FieldStyle.box,
                              outlineBorderRadius: 10.r,
                              style: TextStyle(fontSize: 17.sp),
                              onChanged: (pin) {
                                controller.userEnterOtp.text = pin;
                              },
                            ),
                          )
                        : Container(
                            width: Get.width * 0.9,
                            height: 56.h, // Fixed height using ScreenUtil
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              maxLength: 10,
                              autofocus: true,
                              cursorColor: AppColor.primary,
                              controller: controller.mobileNo,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                              onChanged: (value) => controller.mobileNo.text = value,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  horizontal: 20.w,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.h5Color),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Obx(
                    () => controller.showOtpFeild.value
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: Get.width * 0.06),
                              child: InkWell(
                                onTap: controller.login,
                                child: CommonText(
                                  txtName: "Resend OTP",
                                  txtColor: AppColor.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? CircularProgressIndicator(color: AppColor.primary)
                        : Padding(
                            padding: EdgeInsets.only(
                              top: controller.showOtpFeild.value ? 20.h : 40.h,
                              bottom: 20.h,
                            ),
                            child: _loginOtpBtn(
                              controller.showOtpFeild.value
                                  ? controller.verifyOTP 
                                  : controller.login,
                              context,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: InkWell(
                      onTap: () {
                        controller.navigateToSignUp();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account yet? ",
                          style: TextStyle(
                            color: AppColor.darkBackground,
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up here",
                              style: TextStyle(color: AppColor.primary, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginOtpBtn(Function onPressed, BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: 56.h, // Fixed height using ScreenUtil
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        onPressed: () {
          onPressed();
          FocusScope.of(context).unfocus();
        },
        child: CommonText(
          txtName: controller.showOtpFeild.value ? "Verify Phone Number" : "Login",
          txtColor: AppColor.onPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}

class CommonText extends StatelessWidget {
  String txtName;
  Color txtColor;
  FontWeight fontWeight;
  double fontSize;
  double? txtheight;

  CommonText({
    super.key,
    this.txtheight,
    required this.txtName,
    required this.txtColor,
    required this.fontWeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txtName,
      style: TextStyle(
        fontSize: fontSize,
        color: txtColor,
        fontWeight: fontWeight,
        height: txtheight,
      ),
    );
  }
}

// class CommonText extends StatelessWidget {
//   String txtName;
//   Color txtColor;
//   FontWeight fontWeight;
//   double fontSize;
//   double? txtheight;
//
//   CommonText({
//     super.key,
//     this.txtheight,
//     required this.txtName,
//     required this.txtColor,
//     required this.fontWeight,
//     required this.fontSize,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       txtName,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: txtColor,
//         fontWeight: fontWeight,
//         height: txtheight,
//       ),
//     );
//   }
// }
