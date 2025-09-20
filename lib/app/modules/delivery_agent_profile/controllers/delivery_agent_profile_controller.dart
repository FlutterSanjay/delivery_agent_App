import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../AppColor/appColor.dart';

import '../../../data/model/delivery_agent_profile_model.dart';

class DeliveryAgentProfileController extends GetxController {
  var isActive = true.obs;
  var totalDeliveries = 250.obs;
  var pendingDeliveries = 5.obs;
  var earnings = 15000.obs;
  var rating = 4.8.obs;

  var phone = "+1-555-123-4567";
  var email = "ethan.carter@example.com";
  var vehicle = "Bike - KA 01 AB 1234";
  var zone = "Downtown";

  void toggleStatus() {
    isActive.value = !isActive.value;
  }

  void logout() {
    // Logout ka logic yaha dalna hai
    print("Logged Out");
  }
}
