import 'dart:convert';

import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/Services/sign_up_service.dart';
import 'package:delivery_agent/app/auth/otp_service.dart';
import 'package:delivery_agent/app/modules/store_list/controllers/store_list_controller.dart';
import 'package:delivery_agent/app/modules/store_list/views/store_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/sign_up_api_services.dart';
import '../../../Services/warehouse/warehouseService.dart';
import '../../../data/model/signup_request_model.dart';
import '../../../data/model/warehouseModel/warehouseModel.dart';

class SignUpPageController extends GetxController {
  final storage = StorageService();
  final SignUpService signUpService = SignUpService();
  final OTPService tokenGeneration = OTPService();

  var warehouses = <Warehouse>[].obs;
  var isLoadingWarehouse = true.obs;
  var selectedWarehouseId = RxnString();

  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController idProof = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // Observable for loading state
  final isLoading = false.obs;

  // Observable for error messages
  final errorMessage = ''.obs;

  // GlobalKey for form validation
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Instance of your AuthService (which now uses sample data)
  final AuthService _authService = Get.find<AuthService>();

  // Form field controllers (optional, but useful for initial values or focus)

  @override
  void onInit() {
    fetchWarehouses();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    idProof.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  Future<void> fetchWarehouses() async {
    try {
      isLoadingWarehouse(true);
      final data = await WarehouseService.fetchWarehouses();
      warehouses.assignAll(data);
    } catch (e) {
      print("Error loading warehouses: $e");
    } finally {
      isLoadingWarehouse(false);
    }
  }

  void selectWarehouse(Warehouse warehouse) {
    selectedWarehouseId.value = warehouse.id;
  }

  // Validator functions remain the same as they validate user input regardless of backend
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'User Name is required';
    }
    // Username: only letters and spaces, 3-20 chars
    if (!RegExp(r'^[a-zA-Z ]{3,20}$').hasMatch(value)) {
      return 'Username must be 3-20 characters and contain only letters/spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Basic email regex
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // 10 digit Indian phone number
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateIdProof(String? value) {
    if (value == null || value.isEmpty) {
      return 'Id Proof is required \n eg. Aadhaar Card';
    }
    // Optional: only letters allowed
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Id must contain only letters and numbers without spaces';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // At least 1 uppercase, 1 digit, 1 special char
    if (!RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$',
    ).hasMatch(value)) {
      return 'Password must contain at least one uppercase letter,\n'
          'one number,\n'
          'one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Method to handle signup (calls the simulated service)
  Future<void> signUpUser() async {
    // Get.offAndToNamed('/store-list');
    errorMessage.value = ''; // Clear previous errors
    if (signUpFormKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        final userExist = await tokenGeneration.checkUserExist(
          phoneNumber.text,
        );
        if (userExist != 200) {
          final request = SignUpRequest(
            name: username.text,
            email: email.text,
            phoneNumber: phoneNumber.text,
            role: "deliveryAgent",
            idProof: idProof.text,
            warehouseId: selectedWarehouseId.value ?? 'N/A',
          );
          await storage.saveWarehouseId("${selectedWarehouseId.value}");

          final response = await signUpService.signUp(request);
          final userData = jsonDecode(response);
          // /TODO: if condition lagao userData   /
          if (userData['message'] == "Warehouse not found") {
            return;
          }

          final userId = userData["userId"];
          final phoneNum = userData["phoneNumber"];

          print(userData);
          await storage.saveUserName(userData["name"] ?? "NA");
          await storage.saveAgentId(userId);
          // custom function dobara call

          await tokenGeneration.TokenReceive(userId, phoneNum);

          // Simulate navigation on success
          Get.offAll(
            () => StoreListView(),
            transition: Transition.cupertino, // smooth iOS style
            duration: const Duration(milliseconds: 700), // smooth speed
            curve: Curves.easeInOutCubic, // smooth curve
          );
          // Uncomment when you have a /home route
          return;
        }
        Get.snackbar('Error', "User Exist Already");
        // print('Sign up successful! User ID: ${response.userId}');
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
