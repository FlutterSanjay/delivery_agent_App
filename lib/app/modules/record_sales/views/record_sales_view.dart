// lib/modules/sales/views/sales_view.dart
import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/modules/record_sales/views/product_list_item.dart';
import 'package:delivery_agent/app/modules/record_sales/views/total_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/record_sales_controller.dart';

class RecordSalesView extends GetView<RecordSalesController> {
  // GetView automatically provides the controller. No need for Get.find() here.
  const RecordSalesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FAFF),
      appBar: AppBar(
        backgroundColor: AppColor.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed('/store-assign'),
        ),
        title: const Text('Record Sale'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Top section with Total Items and Total Sale
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => TotalDisplayCard(
                    title: 'Total Items',
                    value: controller.totalItems.value.toString(),
                  ),
                ),
                Obx(
                  () => TotalDisplayCard(
                    title: 'Total Sale',
                    value: '\$${controller.totalSale.value.toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),
          ),
          // List of products with loading indicator
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.availableProducts.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.availableProducts.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              return ListView.builder(
                itemCount: controller.availableProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.availableProducts[index];
                  // Use Obx to rebuild only the quantity part of the item
                  return Obx(
                    () => ProductListItem(
                      product: product,
                      quantity: controller.getQuantity(product),
                      onAdd: () => controller.addItem(product),
                      onRemove: () => controller.removeItem(product),
                    ),
                  );
                },
              );
            }),
          ),
          // Complete Sale Button
          Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.totalItems.value > 0
                    ? () => controller.completeSale()
                    : null, // Disable if cart is empty
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: controller.isLoading.value && controller.totalItems.value > 0
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Complete Sale (\$${controller.totalSale.value.toStringAsFixed(2)})',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
