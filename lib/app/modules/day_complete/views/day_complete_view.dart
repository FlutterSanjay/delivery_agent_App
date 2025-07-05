import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/day_complete_controller.dart';

class DayCompleteView extends GetView<DayCompleteController> {
  const DayCompleteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The image doesn't show an app bar, but it's good practice to have one for context
        // You can remove this AppBar if you want a completely full-screen content.
        title: const Text('Day Completion'),
        centerTitle: true,
        elevation: 0, // Remove shadow
        backgroundColor: Colors.transparent, // Make it transparent
        foregroundColor: AppColor.onSecondary, // Dark text for transparent app bar
      ),
      extendBodyBehindAppBar:
          true, // Allow body to extend behind app bar for seamless look
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: AppColor.redColor, size: 50.sp),
                  SizedBox(height: 10.h),
                  Text(
                    'Error: ${controller.errorMessage.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.redColor, fontSize: 16.sp),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => controller.fetchDayCompletionData(), // Retry button
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: Get.height,
            padding: EdgeInsets.only(
              left: 20.0.w,
              right: 20.0.w,
              top: 100.0.h,
              bottom: 20.h,
            ), // Adjust top padding for app bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vehicle Number
                Obx(
                  () => Text(
                    'Vehicle : ${controller.vehicleNumber.value}',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40.h),

                // Completion Icon
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2.w),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Day Completed Message
                Text(
                  'Day Completed!',
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  'All transactions have been successfully reconciled. Your inventory has been updated for tomorrow.',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),

                // First Summary Card
                _buildSummaryCardOne(),
                SizedBox(height: 10.h),

                // Second Summary Card
                _buildSummaryCardTwo(),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildSummaryCardOne() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(
                title: 'Cash in Hand',
                value:
                    '\$${controller.summaryOneData.value.cashInHand.toStringAsFixed(2)}',
              ),
              _SummaryItem(
                title: 'Sales Made',
                value: controller.summaryOneData.value.salesMade.toString(),
              ),
              _SummaryItem(
                title: 'Revenue',
                value: '\$${controller.summaryOneData.value.revenue.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCardTwo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SummaryItem(
                    title: 'Cash in Hand',
                    value:
                        '₹${controller.summaryTwoData.value.cashInHand.toStringAsFixed(2)}',
                  ),
                  _SummaryItem(
                    title: 'Online Transfer',
                    value:
                        '₹${controller.summaryTwoData.value.onlineTransfer.toStringAsFixed(2)}',
                  ),
                  _SummaryItem(
                    title: 'Revenue',
                    value:
                        '₹${controller.summaryTwoData.value.revenue.toStringAsFixed(2)}',
                  ),
                ],
              ),
              Divider(height: 30.h, thickness: 1.w, color: AppColor.onSecondary),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SummaryItem(
                    title: 'Returned Product',
                    value: controller.summaryTwoData.value.returnedProduct.toString(),
                  ),
                  _SummaryItem(
                    title: 'Store Visited',
                    value: controller.summaryTwoData.value.storeVisited.toString(),
                  ),
                  _SummaryItem(
                    title: 'Inventory in Van',
                    value: controller.summaryTwoData.value.inventoryInVanAction,
                    isClickable: true, // Mark this item as clickable
                    onTap: controller.onInventoryInVanClick,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable widget for displaying a summary item (title and value).
class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isClickable;
  final VoidCallback? onTap;

  const _SummaryItem({
    required this.title,
    required this.value,
    this.isClickable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: isClickable ? onTap : null,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            isClickable
                ? SizedBox(
                    width: Get.width * 0.19,
                    height: Get.height * 0.043,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.snackbar(
                          "Click Here",
                          "Inventory in Van: Click Here clicked!",
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        elevation: 1,
                        shadowColor: AppColor.greyColor,
                        side: BorderSide(style: BorderStyle.none),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        backgroundColor: AppColor.primaryVariant,
                      ),
                      child: Text(
                        "Click Here",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }
}
