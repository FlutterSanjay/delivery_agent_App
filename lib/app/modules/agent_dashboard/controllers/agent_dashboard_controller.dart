import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/agent_dashboard_model.dart';
import '../../../data/model/agent_dashboard_recent_activity_model.dart';
import '../../../data/model/delivery_agent_profile_model.dart';

class AgentDashboardController extends GetxController {
  // If you use an API service, uncomment this:
  // final HomeApiService _apiService = HomeApiService();

  final Rx<DeliveryAgentProfile?> agentProfile = Rx<DeliveryAgentProfile?>(
    DeliveryAgentProfile(
      id: "DA_001",
      name: "John Doe",
      email: "john.doe@example.com",
      phoneNumber: "+1234567890",
      vehicleType: "Bike",
      rating: 4.7,
      status: "on_duty",
      profilePictureUrl: "assets/image/store.jpg",
    ),
  );
  final Rx<AgentHomeStats?> homeStats = Rx<AgentHomeStats?>(
    AgentHomeStats(
      deliveriesToday: 5, // Example: 5 deliveries completed today
      earningsToday: 87.50, // Example: $87.50 earned today
      activeOrders: 2, // Example: 2 orders currently active
    ),
  );
  final RxList<RecentActivity> recentActivities = <RecentActivity>[].obs;
  final RxBool isOnline = false.obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData('agent_123'); // Assuming a fixed agent ID for this demo
  }

  Future<void> fetchHomeData(String agentId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await Future.delayed(const Duration(seconds: 2));

      final DeliveryAgentProfile sampleProfile = DeliveryAgentProfile(
        id: agentId,
        name: 'Alex Rider',
        phoneNumber: '+91 99112 23344',
        email: 'alex.rider@example.com',
        vehicleType: 'Bike',
        vehiclePlateNumber: 'KA-01-MN-5678',
        address: '789, Sunshine Apt, MG Road, Bangalore, India - 560001',
        status: 'on_duty',
        rating: 4.9,
        totalDeliveries: 2100,
        profilePictureUrl: "assets/image/store.jpg",
      );

      final AgentHomeStats sampleStats = AgentHomeStats(
        deliveriesToday: 12,
        earningsToday: 750.50,
        activeOrders: 3,
      );

      final List<RecentActivity> sampleActivities = [
        RecentActivity(
          id: 'act001',
          type: 'Delivery',
          description: 'Delivered Order #1234 to Customer A',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          status: 'Completed',
        ),
        RecentActivity(
          id: 'act002',
          type: 'Pickup',
          description: 'Picked up Order #5678 from Restaurant B',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          status: 'Completed',
        ),
        RecentActivity(
          id: 'act003',
          type: 'Delivery',
          description: 'Pending Delivery for Order #9101 to Customer C',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          status: 'Pending',
        ),
        RecentActivity(
          id: 'act004',
          type: 'Payment',
          description: 'Received payment for Order #1122',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: 'Completed',
        ),
        RecentActivity(
          id: 'act005',
          description: 'Activity with missing type',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      agentProfile.value = sampleProfile;
      homeStats.value = sampleStats;
      recentActivities.assignAll(sampleActivities);
      isOnline.value =
          sampleProfile.status == 'on_duty' || sampleProfile.status == 'active';
    } catch (e) {
      errorMessage.value = 'Failed to load home data: ${e.toString()}';
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

  Future<void> toggleOnlineStatus(bool value) async {
    isOnline.value = value;
    // You would integrate backend API call here to update status
    // try {
    //   await _apiService.updateAgentStatus(
    //     agentProfile.value?.id ?? 'agent_123',
    //     value ? 'on_duty' : 'offline',
    //   );
    //   Get.snackbar('Status Updated', 'You are now ${value ? "Online" : "Offline"}',
    //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    // } catch (e) {
    //   errorMessage.value = 'Failed to update status: ${e.toString()}';
    //   isOnline.value = !value; // Revert on error
    //   Get.snackbar('Error', errorMessage.value,
    //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    // }
    Get.snackbar(
      'Status Updated',
      'You are now ${value ? "Online" : "Offline"}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // --- Updated Navigation Methods for Action Buttons ---

  void goToProfile() {
    Get.toNamed('/agent-profile'); // Navigates to the profile screen
    print('Navigating to Agent Profile'); // For debugging
  }

  void startNewDelivery() {
    // This could navigate to a screen to create a new delivery,
    // or show a modal/dialog to input delivery details.
    Get.toNamed('/new-delivery'); // Navigate to a dedicated "New Delivery" screen
    print('Navigating to New Delivery screen'); // For debugging
  }

  void viewPaymentHistory() {
    Get.toNamed('/payment'); // Navigates to the payment history screen
    print('Navigating to Payment History'); // For debugging
  }

  void goToSupport() {
    // This could navigate to a support chat, FAQ page, or open an email client.
    Get.toNamed('/support'); // Navigate to a dedicated "Support" screen
    print('Navigating to Support screen'); // For debugging
  }
}
