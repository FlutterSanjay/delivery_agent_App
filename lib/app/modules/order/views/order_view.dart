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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'My Inventory',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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

        // 🔍 Filtering logic
        final filteredProducts = controller.products.where((product) {
          final matchesSearch = product.name.toLowerCase().contains(
            controller.searchText.value.toLowerCase(),
          );
          final matchesStatus =
              controller.selectedStatus.value == 'All' ||
              product.status.toLowerCase() ==
                  controller.selectedStatus.value.toLowerCase();
          return matchesSearch && matchesStatus;
        }).toList();

        return Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              // 🔍 Search Bar
              TextField(
                onChanged: (value) => controller.searchText.value = value,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColor.primaryVariant2,
                      width: 1, // border thickness
                    ),
                  ),

                  // Optional: show subtle grey border when not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColor.onBackground,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // 🏷️ Filter Chips
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip('All', controller.selectedStatus),
                      _buildChip('Delivered', controller.selectedStatus),
                      _buildChip('Pending', controller.selectedStatus),
                      _buildChip('Cancelled', controller.selectedStatus),
                      _buildChip('Available', controller.selectedStatus),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // 📦 Product List
              Expanded(
                child: filteredProducts.isEmpty
                    ? Center(
                        child: Text(
                          'No matching products found.',
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return OrderCard(
                            product: product,
                            onAddPressed: () {
                              // Add logic here if needed
                              // controller.addProductToInvoice(product);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // 🧩 Helper widget for Filter Chips
  Widget _buildChip(String label, RxString selectedStatus) {
    final isSelected = selectedStatus.value == label;

    return Obx(
      () => Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: ChoiceChip(
         
          
          label: Text(label),
          selected: selectedStatus.value == label,
          selectedColor: AppColor.primaryVariant2,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          checkmarkColor: Colors.white,
          onSelected: (selected) {
            selectedStatus.value = label;
          },
        ),
      ),
    );
  }
}
