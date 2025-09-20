import 'package:delivery_agent/app/modules/signUp_page/views/warehouseDropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../AppColor/appColor.dart';
import '../controllers/sign_up_page_controller.dart';

class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back
        ),
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // This line dismisses the keyboard
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0.r),
          child: Form(
            key: controller.signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: controller.username,
                  label: 'Username',
                  hint: 'Enter your username',
                  validator: controller.validateUsername,
                  onChanged: (value) => controller.username.text = value,
                  isPasswordField: false,
                ),
                SizedBox(height: 16.0.h),
                _buildTextField(
                  controller: controller.email,
                  label: 'Email',
                  hint: 'Enter your email',
                  validator: controller.validateEmail,
                  onChanged: (value) => controller.email.text = value,
                  keyboardType: TextInputType.emailAddress,
                  isPasswordField: false,
                ),
                SizedBox(height: 16.0.h),
                _buildTextField(
                  controller: controller.phoneNumber,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  validator: controller.validatePhoneNumber,
                  onChanged: (value) => controller.phoneNumber.text = value,
                  keyboardType: TextInputType.phone,
                  isPasswordField: false,
                ),
                SizedBox(height: 16.0.h),
                // User Type can be a DropdownButtonFormField or a segmented control
                _buildTextField(
                  // For simplicity, using a text field. Consider DropdownButtonFormField.
                  controller: controller.idProof,
                  label: 'Id Proof',
                  hint: 'e.g.,Aadhaar Card',
                  validator: controller.validateIdProof,
                  onChanged: (value) => controller.idProof.text = value,
                  isPasswordField: false,
                ),
                SizedBox(height: 16.0.h),
                // _buildTextField(
                //   controller: controller.password,
                //   label: 'Password',
                //   hint: 'Enter your password',
                //   validator: controller.validatePassword,
                //   onChanged: (value) => controller.password.text = value,
                //   isPasswordField: true,
                // ),
                // SizedBox(height: 16.0.h),
                // _buildTextField(
                //   controller: controller.confirmPassword,
                //   label: 'Confirm Password',
                //   hint: 'Re-enter your password',
                //   validator: controller.validateConfirmPassword,
                //   onChanged: (value) => controller.confirmPassword.text = value,
                //   isPasswordField: true,
                // ),
                // 🔥 Warehouse Dropdown Integrated
                WarehouseDropdown(controller: controller),
                SizedBox(height: 32.0.h),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.signUpUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary, // Example color
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: AppColor.onPrimary)
                        : Text(
                            'Create Account',
                            style: TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(height: 20.0.h),
                Obx(
                  () => controller.errorMessage.value.isNotEmpty
                      ? Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: AppColor.redColor, fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: 20.0.h),
                Text.rich(
                  TextSpan(
                    text: 'By creating an account, you agree with our ',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'terms of service',
                        style: const TextStyle(color: AppColor.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle tap on terms of service
                            print('Terms of Service tapped');
                          },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'privacy.',
                        style: const TextStyle(color: AppColor.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle tap on privacy
                            print('Privacy tapped');
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool isPasswordField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.0.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0.r),
              borderSide: const BorderSide(color: AppColor.lightGreyBackground),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0.r),
              borderSide: const BorderSide(color: AppColor.primary), // Focus color
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: isPasswordField,
        ),
      ],
    );
  }
}
