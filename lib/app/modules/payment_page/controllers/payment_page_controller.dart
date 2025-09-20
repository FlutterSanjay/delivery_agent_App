import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Services/payment_api_service.dart';
import '../../../data/model/payment_transaction_model.dart';

enum PaymentMethod {
  cash,
  card,
  upi, // Unified Payments Interface (common in India)
  other,
}


class PaymentPageController extends GetxController {
  //TODO: Implement PaymentPageController
  final PaymentApiService _apiService = PaymentApiService();

  // Observable for the current payment transaction state
  final Rx<PaymentTransaction> transaction = PaymentTransaction(
    amountDue: 0.0, // This should be set when navigating to the screen
    paymentMethod: PaymentMethod.cash.name, // Default to cash
  ).obs;


var selectedTab = "upi".obs;

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
  
  // Rx variable for cash input field
  final TextEditingController cashInputController = TextEditingController();
  final RxDouble changeDue = 0.0.obs;

  // UI state variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the amount due from arguments passed during navigation
    if (Get.arguments != null &&
        Get.arguments is Map &&
        Get.arguments['amount'] != null) {
      final double amount = (Get.arguments['amount'] as num).toDouble();
      transaction.value = transaction.value.copyWith(amountDue: amount);
    }

    // Listener for cash input changes
    cashInputController.addListener(_calculateChange);
  }

  @override
  void onClose() {
    cashInputController.dispose();
    super.onClose();
  }

  // Updates the selected payment method
  void selectPaymentMethod(PaymentMethod method) {
    transaction.value = transaction.value.copyWith(paymentMethod: method.name);
    // Clear cash input and change if method changes from cash
    if (method != PaymentMethod.cash) {
      cashInputController.clear();
      changeDue.value = 0.0;
      transaction.value = transaction.value.copyWith(cashPaid: null, changeDue: null);
    }
  }

  // Calculates change when cash input changes
  void _calculateChange() {
    final double amountPaid = double.tryParse(cashInputController.text) ?? 0.0;
    final double due = transaction.value.amountDue;
    changeDue.value = amountPaid - due;
    transaction.value = transaction.value.copyWith(
      cashPaid: amountPaid,
      changeDue: changeDue.value,
    );
  }

  // Processes the payment
  Future<void> processPayment() async {
    isLoading.value = true;
    errorMessage.value = '';
    transaction.value = transaction.value.copyWith(status: 'processing');

    // Basic validation for cash payment
    if (transaction.value.paymentMethod == PaymentMethod.cash.name &&
        changeDue.value < 0) {
      errorMessage.value = 'Amount paid is less than amount due.';
      transaction.value = transaction.value.copyWith(status: 'failed');
      isLoading.value = false;
      return;
    }

    try {
      // Simulate API call using the service
      final PaymentTransaction result = await _apiService.processPayment(
        transaction.value,
      );

      transaction.value = result; // Update transaction with backend response
      Get.snackbar(
        'Payment Successful!',
        'Transaction ID: ${result.id ?? 'N/A'}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.greenColor,
        colorText: AppColor.onPrimary,
      );
      // Optional: Navigate to a success screen or clear inputs
      // Get.back(); // Pop payment screen
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      transaction.value = transaction.value.copyWith(status: 'failed');
      Get.snackbar(
        'Payment Failed',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.redColor,
        colorText: AppColor.onPrimary,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
