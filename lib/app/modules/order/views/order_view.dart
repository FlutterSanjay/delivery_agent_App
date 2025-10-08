import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';
import 'order_card.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('My Inventory'),
        centerTitle: true,
        backgroundColor: AppColor.primaryVariant2,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return Center(
            child: Text(
              'No products found in your inventory.',
              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return OrderCard(
              product: product,
              onAddPressed: () {
                // The 'Add' button now triggers a function to both add to the invoice
                // and remove from the inventory list.
                controller.addProductToInvoice(product);
              },
            );
          },
        );
      }),
      
    );
  }
}
