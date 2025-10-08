import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class DeliveryAgentProfileController extends GetxController {
  final storage = StorageService();
  var agentData;

  var isLoading = true.obs;
  var isActive = true.obs;
  var totalDeliveries = "".obs;
  var pendingDeliveries = 5.obs;
  var earnings = 15000.obs;
  var rating = 4.8.obs;
  var name = "Unknown".obs;

  var phone = "+1-555-123-4567";
  var email = "ethan.carter@example.com";
  var vehicle = "Bike - KA 01 AB 1234";
  var zone = "Downtown";

  @override
  void onInit() {
    super.onInit();
    _loadedAgentDetails();
  }

  void _loadedAgentDetails() {
    try {
      agentData = (storage.getAgentData())?["AgentData"];
      name.value = agentData['name'];
      email = agentData['email'];
      phone = agentData['phoneNumber'];
      zone = storage.getAgentTown() ?? "unknown";
      vehicle = storage.getVehicleId() ?? " ";
      totalDeliveries.value = storage.getTotalDelivery() ?? "unknown";

      print(agentData['name']);
      isLoading.value = false;
    } catch (e) {
      print("Error Ocuured!: $e");
    }
  }

  void toggleStatus() {
    isActive.value = !isActive.value;
  }

  void logout() {
    // Logout ka logic yaha dalna hai
    print("Logged Out");
  }
}
