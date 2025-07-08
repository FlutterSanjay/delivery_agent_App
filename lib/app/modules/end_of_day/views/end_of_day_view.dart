import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../login_process/views/onboaeding_view.dart';
import '../controllers/end_of_day_controller.dart';

class EndOfDayView extends GetView<EndOfDayController> {
  const EndOfDayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back using GetX
          },
        ),
        title: const Text('End of Day'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Use Obx here to react to isLoading and errorMessage
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 50.sp),
                  SizedBox(height: 10.h),
                  Text(
                    'Error: ${controller.errorMessage.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.redColor, fontSize: 16.sp),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => controller.fetchEndOfDayData(), // Retry button
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDailySummaryCard(),
                      SizedBox(height: 20.h),
                      _buildRemainingInventoryCard(),
                      SizedBox(height: 20.h), // Add spacing
                      _buildExpiredItemsCard(),
                    ],
                  ),
                ),
              ),
              _buildCompleteDayButton(),
            ],
          );
        }
      }),
    );
  }

  Widget _buildDailySummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Summary',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            // Access values directly from controller.dailySummary.value
            _SummaryItem(
              icon: Icons.attach_money,
              title: 'Cash in Hand',
              value: '\$${controller.dailySummary.value.cashInHand.toStringAsFixed(2)}',
              iconColor: Colors.green,
            ),
            _SummaryItem(
              icon: Icons.shopping_cart,
              title: 'Total Sales',
              value: '\$${controller.dailySummary.value.totalSales.toStringAsFixed(2)}',
              iconColor: Colors.blue,
            ),
            _SummaryItem(
              icon: Icons.receipt_long,
              title: 'Sales Transactions',
              value: controller.dailySummary.value.salesTransactions.toString(),
              iconColor: Colors.purple,
            ),
            _SummaryItem(
              icon: Icons.error_outline,
              title: 'Expired Products',
              value: '${controller.dailySummary.value.expiredProductTypes} types',
              iconColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemainingInventoryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remaining Inventory',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            // Use Obx to rebuild this section when remainingInventory changes
            Obx(
              () => Column(
                children: controller.remainingInventory
                    .map(
                      (item) => _InventoryItem(
                        imageUrl: item.imageUrl,
                        name: item.name,
                        price: item.price,
                        stock: item.stock,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Expired Item Card

  Widget _buildExpiredItemsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              txtName: "Expired Items",
              txtColor: AppColor.onSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
            ),
            SizedBox(height: 15.h),
            Obx(() {
              if (controller.expiredItems.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    'No expired items found.',
                    style: TextStyle(fontSize: 16.sp, color: AppColor.greyColor),
                  ),
                );
              }
              return Column(
                children: controller.expiredItems
                    .map(
                      (item) => _InventoryItem(
                        imageUrl: item.imageUrl,
                        name: item.name,
                        price: item.price,
                        stock: item
                            .stock, // Stock here represents the quantity of expired items
                      ),
                    )
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  // CompleteDay Button
  Widget _buildCompleteDayButton() {
    return Container(
      padding: EdgeInsets.all(16.r),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.completeDay(), // Call the async method
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 5,
        ),
        child: Text(
          'Complete Day',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Helper Widgets for Summary and Inventory Items (remain the same)
// ... (Paste _SummaryItem and _InventoryItem from previous response)
class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 16.sp)),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Inventory Items
class _InventoryItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final int stock;

  const _InventoryItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock.toString(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                'in stock',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
