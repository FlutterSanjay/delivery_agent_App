import 'package:get/get.dart';

import '../../../data/model/summary_one.dart';
import '../../../data/model/summary_two.dart';

class DayCompleteController extends GetxController {
  var vehicleNumber = 'Loading...'.obs;

  // Observables for the two summary cards
  var summaryOneData = SummaryDataOne(cashInHand: 0.0, salesMade: 0, revenue: 0.0).obs;

  var summaryTwoData = SummaryDataTwo(
    cashInHand: 0.0,
    onlineTransfer: 0.0,
    revenue: 0.0,
    returnedProduct: 0,
    storeVisited: 0,
    inventoryInVanAction: 'Click Here',
  ).obs;

  // Loading and error states
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch data when the controller is initialized
    fetchDayCompletionData();
  }

  /// Simulates fetching day completion data from a backend.
  ///
  /// In a real application, this method would make API calls
  /// to retrieve the necessary data.
  Future<void> fetchDayCompletionData() async {
    isLoading.value = true; // Set loading state
    errorMessage.value = ''; // Clear any previous errors

    try {
      // --- Future Backend Integration Point: API Calls ---
      // Replace these simulated delays and sample data with actual API calls.
      // Example:
      // final vehicleResponse = await YourApiService.getVehicleInfo();
      // final summaryOneResponse = await YourApiService.getSummaryOne();
      // final summaryTwoResponse = await YourApiService.getSummaryTwo();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Sample data (replace with data from your API responses)
      final sampleVehicleNumber = 'JH-01-AB-2012';
      final sampleSummaryOne = SummaryDataOne(
        cashInHand: 10.99,
        salesMade: 1,
        revenue: 10.99,
      );
      final sampleSummaryTwo = SummaryDataTwo(
        cashInHand: 10.99,
        onlineTransfer: 0.00,
        revenue: 10.99,
        returnedProduct: 10,
        storeVisited: 1,
        inventoryInVanAction: 'Click Here', // Or a URL from backend
      );

      // Update observable data
      vehicleNumber.value = sampleVehicleNumber;
      summaryOneData.value = sampleSummaryOne;
      summaryTwoData.value = sampleSummaryTwo;
    } catch (e) {
      // --- Future Backend Integration Point: Error Handling ---
      // Catch specific exceptions (e.g., network errors, server errors)
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } finally {
      isLoading.value = false; // Always set loading to false
    }
  }

  /// Handles the action for "Inventory in Van".
  ///
  /// In a real app, this might navigate to a new screen,
  /// open a URL, or trigger another backend call.
  void onInventoryInVanClick() {
    // Example: Navigate to a detailed inventory screen
    // Get.to(() => InventoryDetailScreen());

    // Example: Open a URL if the action string is a URL
    // if (GetUtils.isURL(summaryTwoData.value.inventoryInVanAction)) {
    //   launchUrl(Uri.parse(summaryTwoData.value.inventoryInVanAction));
    // } else {
    Get.snackbar(
      'Action',
      'Inventory in Van: ${summaryTwoData.value.inventoryInVanAction} clicked!',
      snackPosition: SnackPosition.BOTTOM,
    );
    // }
  }
}
