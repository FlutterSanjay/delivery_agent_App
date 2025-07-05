import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:delivery_agent/app/modules/onboaeding/controllers/onboaeding_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../AppColor/appColor.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                GetBuilder<OnboardingController>(
                  builder: (controller) => Container(
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
                GetBuilder<OnboardingController>(
                  builder: (controller) => controller.showOtpFeild.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                          child: OTPTextField(
                            controller: controller.otpController,
                            length: 4,
                            width: Get.width * 0.7,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 45.w,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 10.r,
                            style: TextStyle(fontSize: 17.sp),
                            onChanged: (pin) {
                              debugPrint("Changed: $pin");
                            },
                            onCompleted: (pin) {
                              debugPrint("Completed: $pin");
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
                            onChanged: (value) => controller.phoneNumber.value = value,
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
                GetBuilder<OnboardingController>(
                  builder: (controller) => controller.showOtpFeild.value
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: Get.width * 0.1),
                            child: InkWell(
                              onTap: () {},
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
                GetBuilder<OnboardingController>(
                  builder: (controller) => Padding(
                    padding: EdgeInsets.only(
                      top: controller.showOtpFeild.value ? 20.h : 40.h,
                      bottom: 20.h,
                    ),
                    child: _loginOtpBtn(controller),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyle(color: AppColor.darkBackground, fontSize: 14.sp),
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
    );
  }

  Widget _loginOtpBtn(OnboardingController controller) {
    return SizedBox(
      width: Get.width * 0.9,
      height: 56.h, // Fixed height using ScreenUtil
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        onPressed: () {},
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
