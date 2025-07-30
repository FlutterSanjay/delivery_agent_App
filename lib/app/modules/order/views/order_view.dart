import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import 'order_card.dart';

class OrderView extends GetView<OrderController> {
  // Renamed from HomeView
  // Use Get.put to initialize the controller and make it available

  OrderView({Key? key}) : super(key: key); // Renamed from HomeView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Deliveries'),
        centerTitle: true,
        backgroundColor: AppColor.primaryVariant2,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        // Show a loading indicator if orders are being fetched
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        // Show a message if no assigned orders are found after loading
        else if (controller.orders.isEmpty) {
          return Center(
            child: Text(
              'No assigned orders found.',
              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
            ),
          );
        }
        // Display the list of orders
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return OrderCard(order: order);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh orders from backend (or dummy data for now)
          controller.fetchOrdersForAgent();
          Get.snackbar(
            'Refresh',
            'Orders refreshed!',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 1),
          );
        },
        backgroundColor: AppColor.primaryVariant1,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
