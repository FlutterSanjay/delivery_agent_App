import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/daily_summary_model.dart';

import '../../../data/model/inventory_item.dart';

class EndOfDayController extends GetxController {
  var dailySummary = DailySummary(
    cashInHand: 0.0,
    totalSales: 0.0,
    salesTransactions: 0,
    expiredProductTypes: 0,
  ).obs;

  var remainingInventory = <InventoryItem>[].obs;
  // Add an observable list for expired items
  var expiredItems = <InventoryItem>[].obs;

  // RxBool to manage loading state for data fetching
  var isLoading = true.obs;
  // RxString to hold error messages, if any
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Call the data fetching method when the controller is initialized
    fetchEndOfDayData();
  }

  // Method to fetch end of day data from a backend
  Future<void> fetchEndOfDayData() async {
    isLoading.value = true; // Set loading to true before fetching
    errorMessage.value = ''; // Clear previous error messages

    try {
      // --- Future Backend Integration Point 1: API Call ---
      // Replace this section with your actual API calls.
      // Example using a hypothetical service or repository:
      // final response = await YourApiService.getEndOfDaySummary();
      // final inventoryResponse = await YourApiService.getRemainingInventory();

      // For now, simulating a network delay and success
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      // --- Future Backend Integration Point 2: Data Parsing ---
      // Assuming your API returns data that can be mapped to your models
      // Example:
      // final fetchedSummary = DailySummary.fromJson(response.data['summary']);
      // final fetchedInventory = (inventoryResponse.data['items'] as List)
      //     .map((itemJson) => InventoryItem.fromJson(itemJson))
      //     .toList();

      // Sample data (remove this once integrated with a real backend)
      final sampleDailySummary = DailySummary(
        cashInHand: 10.99,
        totalSales: 10.99,
        salesTransactions: 1,
        expiredProductTypes: 1,
      );

      final sampleRemainingInventory = <InventoryItem>[
        InventoryItem(
          name: 'Bottled Water (500ml)',
          price: 1.50,
          stock: 46,
          imageUrl: 'assets/image/bottle.webp',
        ),
        InventoryItem(
          name: 'Fresh Milk (1L)',
          price: 3.25,
          stock: 23,
          imageUrl: 'assets/image/bottle.webp',
        ),
        InventoryItem(
          name: 'Bread Loaf',
          price: 2.75,
          stock: 14,
          imageUrl: 'assets/image/bottle.webp',
        ),
        InventoryItem(
          name: 'Chocolate Bar',
          price: 1.99,
          stock: 35,
          imageUrl: 'assets/image/bottle.webp',
        ),
        InventoryItem(
          name: 'Yogurt (150g)',
          price: 1.25,
          stock: 10,
          imageUrl: 'assets/image/bottle.webp',
        ),
      ];

      // Sample data for expired items (new)
      final sampleExpiredItems = <InventoryItem>[
        InventoryItem(
          name: 'Expired Cheese (200g)',
          price: 5.00,
          stock: 2, // Quantity of expired items
          imageUrl: 'assets/image/bottle.webp', // Add this image
        ),
        InventoryItem(
          name: 'Expired Juice (1L)',
          price: 2.50,
          stock: 1,
          imageUrl: 'assets/image/bottle.webp', // Add this image
        ),
      ];

      // Update the observable variables with fetched data
      dailySummary.value = sampleDailySummary;
      remainingInventory.assignAll(sampleRemainingInventory);
      expiredItems.assignAll(sampleExpiredItems); // Assign expired items
    } catch (e) {
      // --- Future Backend Integration Point 3: Error Handling ---
      // Catch specific exceptions (e.g., DioError, SocketException) for better error messages
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      isLoading.value = false; // Set loading to false after completion (success or error)
    }
  }

  // Method to handle "Complete Day" action
  Future<void> completeDay() async {
    // Show a loading indicator if needed for the complete day operation
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // --- Future Backend Integration Point 4: Sending Data to Backend ---
      // Replace this with your API call to complete the day.
      // Example:
      // final response = await YourApiService.completeDay(dailySummary.value, remainingInventory.value);

      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay for completing day

      Get.back(); // Dismiss the loading dialog
      Get.snackbar(
        'Day Completed',
        'The day has been successfully closed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
      // Future: Navigate to another screen or clear data
    } catch (e) {
      Get.back(); // Dismiss the loading dialog
      errorMessage.value = 'Failed to complete day: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }
}
