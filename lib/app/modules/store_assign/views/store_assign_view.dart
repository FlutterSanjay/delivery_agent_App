import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:delivery_agent/app/modules/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Features/rich_text_feature.dart';
import '../../../Features/tag_feature.dart';
import '../../login_process/views/onboaeding_view.dart';
import '../../record_sales/views/record_sales_view.dart';
import '../../store_list/views/store_list_view.dart';
import '../controllers/store_assign_controller.dart';

class StoreAssignView extends GetView<StoreAssignController> {
  const StoreAssignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changePage(index);
            switch (index) {
              case 0:
                Get.offAll(() => OrderView()); // Replace with your home view
                break;
              case 1:
                Get.offAll(() => RecordSalesView()); // Replace with your store list view
                break;
              //   case 2:
              //     Get.offAll(() => AddStoreView()); // Replace with your add store view
              //     break;
              //   case 3:
              //     Get.offAll(() => ExpenseProfileView()); // Replace with your expense view
              //     break;
              // }
            }
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store List'),
            BottomNavigationBarItem(icon: Icon(Icons.add_business), label: 'Add Store'),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Expense Profile',
            ),
          ],
        ),
      ),
      backgroundColor: AppColor.lightGreyBackground,
      appBar: AppBar(
        backgroundColor: AppColor.onPrimary,
        title: CommonText(
          txtName: "Store Assigned Today",
          txtColor: AppColor.onSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Info Container
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.h, left: 20.w),
              width: Get.width * 0.75,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColor.primaryVariant,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: CommonText(
                txtName: "Assigned Route: Vijay Nagar, Bel Road",
                txtColor: AppColor.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
              ),
            ),

            // Sort Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  // Sort Dropdown
                  SizedBox(
                    width: Get.width * 0.46,
                    child: PopupMenuButton<String>(
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'distance', child: Text('Distance')),
                        PopupMenuItem(value: 'all', child: Text('All')),
                        PopupMenuItem(value: 'store_type', child: Text('Store Type')),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'distance':
                            controller.selectedValue.value = 'Distance';
                            break;
                          case 'all':
                            controller.selectedValue.value = 'All';
                            break;
                          case 'store_type':
                            controller.selectedValue.value = 'Store Type';
                            break;
                        }
                      },
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.5.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.h5Color),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: CommonText(
                                  txtName: "Sort By: ${controller.selectedValue.value}",
                                  txtColor: AppColor.h5Color,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, color: AppColor.h5Color),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20.w),

                  // Store Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextFeature(
                        primaryText: "Total Stores Assigned:",
                        primaryTextColor: AppColor.onSecondary,
                        primaryFontSize: 11.sp,
                        secondaryText: "86",
                        secondaryTextColor: AppColor.onSecondary,
                        secondaryFontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 3.h),
                      RichTextFeature(
                        primaryText: "Total Stores Visited:",
                        primaryTextColor: AppColor.onSecondary,
                        primaryFontSize: 11.sp,
                        secondaryText: "6",
                        secondaryTextColor: AppColor.onSecondary,
                        secondaryFontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status Filter
            SizedBox(
              height: 52.h,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 20.w, top: 6.h, bottom: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: controller.statusItem.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (context, index) => Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedItem.value == index
                          ? AppColor.h5Color
                          : AppColor.onPrimary,
                      elevation: 0,
                      side: BorderSide(color: AppColor.h5Color),
                    ),
                    onPressed: () => controller.selectedItem(index),
                    child: CommonText(
                      txtName: controller.statusItem[index],
                      txtColor: controller.selectedItem.value == index
                          ? AppColor.onPrimary
                          : AppColor.h5Color,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ),

            // Store List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(height: 13.h),
                itemBuilder: (context, index) => Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: AppColor.onPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(40),
                        spreadRadius: 2.r,
                        blurRadius: 2.r,
                        offset: Offset(0.w, 3.h),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Store Image
                      Container(
                        width: Get.width * 0.36,
                        height: 200.h,
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColor.onPrimary,
                          image: DecorationImage(
                            image: AssetImage(ImagePath.storeImg),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Store Details
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CommonText(
                              txtName: 'Apna Store',
                              txtColor: AppColor.onSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),

                            // Store Tags
                            Row(
                              children: [
                                TagFeature(
                                  txtName: "Super Mart",
                                  txtColor: AppColor.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  borderColor: AppColor.primary,
                                ),
                                SizedBox(width: 5.w),
                                TagFeature(
                                  txtName: "Yet To Deliver",
                                  txtColor: AppColor.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  borderColor: AppColor.primary,
                                ),
                              ],
                            ),

                            // Store Stats
                            Column(
                              children: [
                                RichTextFeature(
                                  primaryText: "Last Billed Amount: ",
                                  secondaryText: "6200",
                                  primaryTextColor: AppColor.onSecondary,
                                  secondaryTextColor: AppColor.onSecondary,
                                  primaryFontSize: 10.sp,
                                  secondaryFontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 5.h),
                                RichTextFeature(
                                  primaryText: "Avg Billed Amount: ",
                                  secondaryText: "6200",
                                  primaryTextColor: AppColor.onSecondary,
                                  secondaryTextColor: AppColor.onSecondary,
                                  primaryFontSize: 10.sp,
                                  secondaryFontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),

                            // Action Buttons
                            Row(
                              children: [
                                // Delivery Button
                                Container(
                                  width: Get.width * 0.28,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryVariant,
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  child: Center(
                                    child: CommonText(
                                      txtName: "Start Delivery",
                                      txtColor: AppColor.onPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),

                                // Call Button
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.call, color: AppColor.greenColor),
                                ),

                                // Distance
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: AppColor.redColor),
                                    SizedBox(width: 5.w),
                                    CommonText(
                                      txtName: "4KM",
                                      txtColor: AppColor.h5Color,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
