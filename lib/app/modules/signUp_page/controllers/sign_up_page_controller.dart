import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/sign_up_api_services.dart';
import '../../../data/model/signup_request_model.dart';

class SignUpPageController extends GetxController {
  // Observables for form fields (these will hold the user's input)
  final username = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final userType = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  // Observable for loading state
  final isLoading = false.obs;

  // Observable for error messages
  final errorMessage = ''.obs;

  // GlobalKey for form validation
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Instance of your AuthService (which now uses sample data)
  final AuthService _authService = Get.find<AuthService>();

  // Form field controllers (optional, but useful for initial values or focus)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // You can set initial sample values here for demonstration
    // usernameController.text = 'john.doe';
    // emailController.text = 'john.doe@example.com';
    // phoneNumberController.text = '1234567890';
    // userTypeController.text = 'Buyer';
    // passwordController.text = 'SecureP@ss1';
    // confirmPasswordController.text = 'SecureP@ss1';

    // To bind controllers to Rx variables if you set initial text above
    // username.value = usernameController.text;
    // email.value = emailController.text;
    // phoneNumber.value = phoneController.text;
    // userType.value = userTypeController.text;
    // password.value = passwordController.text;
    // confirmPassword.value = confirmPasswordController.text;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    userTypeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validator functions remain the same as they validate user input regardless of backend
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // You can add more robust phone number validation here
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateUserType(String? value) {
    if (value == null || value.isEmpty) {
      return 'User type is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password.value) {
      // Compare with the password field
      return 'Passwords do not match';
    }
    return null;
  }

  // Method to handle signup (calls the simulated service)
  Future<void> signUpUser() async {
    Get.offAndToNamed('/store-list');
    errorMessage.value = ''; // Clear previous errors
    if (signUpFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        final request = SignUpRequest(
          username: username.value,
          email: email.value,
          phoneNumber: phoneNumber.value,
          userType: userType.value,
          password: password.value,
          confirmPassword: confirmPassword.value,
        );

        final response = await _authService.signUp(
          request,
        ); // This now calls the simulated service

        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Simulate navigation on success
        // Get.offAllNamed('/home'); // Uncomment when you have a /home route
        print('Sign up successful! User ID: ${response.userId}');
      } catch (e) {
        errorMessage.value = e.toString().replaceFirst('Exception: ', '');
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
