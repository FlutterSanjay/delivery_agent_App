// controllers/inventory_controller.dart

import 'package:delivery_agent/app/Services/orderService/orderService.dart';
import 'package:delivery_agent/app/data/model/orderModel/inventory_order_model.dart';
import 'package:get/get.dart';

import 'dart:developer';

class OrderController extends GetxController {
  final RxString searchText = ''.obs;
  final RxString selectedStatus = 'All'.obs;
  var isLoading = true.obs;
  var products = <InventoryOrderModel>[].obs;
  final String vehicleId =
      "31ebd0f7-40c6-4e42-9117-bb8daa1e60e7"; // Example vehicle ID
  final OrderService _orderService = OrderService();
 

  @override
  void onInit() {
    super.onInit();
    fetchInventory();
  }



  void fetchInventory() async {
    try {
      isLoading.value = true;
      products.value = await _orderService.fetchInventoryProducts(vehicleId);
      print(products[0]);
    } catch (e) {
      log("Error fetching inventory products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
