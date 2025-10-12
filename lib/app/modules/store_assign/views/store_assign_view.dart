import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/Features/loader.dart';
import 'package:delivery_agent/app/Features/shimmer_effect.dart';
import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:delivery_agent/app/modules/agent_dashboard/views/agent_dashboard_view.dart';
import 'package:delivery_agent/app/modules/delivery_agent_profile/views/delivery_agent_profile_view.dart';
import 'package:delivery_agent/app/modules/drawer/views/drawer_Icon.dart';
import 'package:delivery_agent/app/modules/drawer/views/drawer_view.dart';
import 'package:delivery_agent/app/modules/map_interation/views/map_interation_view.dart';
import 'package:delivery_agent/app/modules/order/views/order_view.dart';
import 'package:delivery_agent/app/modules/store_assign/views/order_summary_one_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
        () => controller.loading.value
            ? SizedBox()
            : ConvexAppBar(
                height: 45.h,

                top: (-1.0),
                backgroundColor: Colors.orange,
                color: Colors.white,
                activeColor: Colors.white,
                initialActiveIndex: 0,
                items: [
                  TabItem(icon: Icons.home, title: 'Store'),
                  TabItem(
                    icon: Icons.delivery_dining_outlined,
                    title: 'Delivered',
                  ),
                  TabItem(icon: Icons.person, title: 'Profile'),
                ],
                onTap: (int index) {
                  controller.currentIndex(index);
                  // Navigate to the corresponding screen
                  if (index == 0) {
                    Get.offAll(
                      () => StoreAssignView(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 500),
                    );
                  } else if (index == 1) {
                    Get.offAll(
                      () => OrderView(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 500),
                    );
                  } else if (index == 2) {
                    Get.offAll(
                      () => DeliveryAgentProfileView(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 500),
                    );
                  }
                },
              ),
      ),

      backgroundColor: AppColor.lightGreyBackground,
      appBar: AppBar(
        backgroundColor: AppColor.onPrimary,
        automaticallyImplyLeading: false,
        title: CommonText(
          txtName: "Store Assigned Today",
          txtColor: AppColor.onSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        centerTitle: true,
        actions: const [DrawerBarIconButton()],
      ),
      body: Obx(
        () => controller.loading.value
            ? AppLoader()
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Route Info Container
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10.h, left: 20.w),
                      width: Get.width * 0.75,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryVariant1,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          // Sort Dropdown
                          SizedBox(
                            width: Get.width * 0.46,
                            child: PopupMenuButton<String>(
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'distance',
                                  child: Text('Distance'),
                                ),
                                PopupMenuItem(value: 'all', child: Text('All')),
                                PopupMenuItem(
                                  value: 'store_type',
                                  child: Text('Store Type'),
                                ),
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
                                    controller.selectedValue.value =
                                        'Store Type';
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
                                          txtName:
                                              "Sort By: ${controller.selectedValue.value}",
                                          txtColor: AppColor.h5Color,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.h5Color,
                                      ),
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
                                secondaryText: "${controller.stores.length}",
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
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 6.h,
                          bottom: 5.h,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.statusItem.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) => Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  controller.selectedItem.value == index
                                  ? AppColor.h5Color
                                  : AppColor.onPrimary,
                              elevation: 0,
                              side: BorderSide(color: AppColor.h5Color),
                            ),
                            onPressed: () => controller.selectItem(index),
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
                      child: Obx(() {
                        if (controller.filterLoading.value) {
                          return AppLoader();
                        } else if (controller.selectedItem.value == 1) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            itemCount: controller.stores.length,
                            separatorBuilder: (_, __) => SizedBox(height: 13.h),
                            itemBuilder: (context, index) {
                              final store = controller.stores[index];
                              final storeDetail = store['data'];

                              final storeLatitude =
                                  storeDetail['location']?['latitude'] ?? 0.0;
                              final storeLongitude =
                                  storeDetail['location']?['longitude'] ?? 0.0;

                              return GestureDetector(
                                onTap: () {
                                  final orderItem =
                                      storeDetail['orderedItems'][0];
                                  print(storeDetail['email']);
                                  controller.storage.saveStoreEmail(
                                    storeDetail['email'],
                                  );
                                  controller.storage.saveOrderId(orderItem);
                                  controller.fetchOrderItems(orderItem);

                                  Get.to(
                                    () => OrderSummaryOneStore(
                                      controller: controller,
                                      storeName: storeDetail['storeName'],
                                    ),
                                  );
                                },
                                child: Container(
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
                                            image: AssetImage(
                                              ImagePath.storeImg,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      // Store Details
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                CommonText(
                                                  txtName:
                                                      "${storeDetail['storeName']}",
                                                  txtColor:
                                                      AppColor.onSecondary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18.sp,
                                                ),
                                              ],
                                            ),
                                            // Store Tags
                                            Row(
                                              children: [
                                                TagFeature(
                                                  txtName:
                                                      "${storeDetail['storeType']}",
                                                  txtColor: AppColor.primary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
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
                                                  primaryText:
                                                      "Last Billed Amount: ",
                                                  secondaryText: "6200",
                                                  primaryTextColor:
                                                      AppColor.onSecondary,
                                                  secondaryTextColor:
                                                      AppColor.onSecondary,
                                                  primaryFontSize: 10.sp,
                                                  secondaryFontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                SizedBox(height: 5.h),
                                                RichTextFeature(
                                                  primaryText:
                                                      "Avg Billed Amount: ",
                                                  secondaryText: "6200",
                                                  primaryTextColor:
                                                      AppColor.onSecondary,
                                                  secondaryTextColor:
                                                      AppColor.onSecondary,
                                                  primaryFontSize: 10.sp,
                                                  secondaryFontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),

                                            // Action Buttons
                                            Row(
                                              spacing: 10.w,
                                              children: [
                                                // Delivery Button
                                                Container(
                                                  width: Get.width * 0.28,
                                                  height: 33.h,
                                                  decoration: BoxDecoration(
                                                    color: AppColor
                                                        .primaryVariant1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18.r,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: CommonText(
                                                      txtName: "Start Delivery",
                                                      txtColor:
                                                          AppColor.onPrimary,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13.sp,
                                                    ),
                                                  ),
                                                ),

                                                // Call Button
                                                IconButton(
                                                  onPressed: () {
                                                    controller.makePhoneCall(
                                                      storeDetail['phoneNumber']
                                                          .toString(),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.call,
                                                    size: 26.sp,
                                                    color: AppColor.greenColor,
                                                  ),
                                                ),

                                                // Distance
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      '/map-interation',
                                                      arguments: {
                                                        "lat": storeLatitude,
                                                        "lon": storeLongitude,
                                                        "storeName":
                                                            storeDetail['storeName'],
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.location_on,
                                                    size: 26.sp,
                                                    color: AppColor.redColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (controller.selectedItem.value == 0) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            itemCount: controller.filteredStores.length,
                            separatorBuilder: (_, __) => SizedBox(height: 13.h),
                            itemBuilder: (context, index) {
                              final store = controller.filteredStores[index];
                              final storeDetail = store['data'];

                              return Container(
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
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              CommonText(
                                                txtName:
                                                    "${storeDetail['storeName']}",
                                                txtColor: AppColor.onSecondary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp,
                                              ),
                                            ],
                                          ),
                                          // Store Tags
                                          Row(
                                            children: [
                                              TagFeature(
                                                txtName:
                                                    "${storeDetail['storeType']}",
                                                txtColor: AppColor.primary,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
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
                                                primaryText:
                                                    "Last Billed Amount: ",
                                                secondaryText: "6200",
                                                primaryTextColor:
                                                    AppColor.onSecondary,
                                                secondaryTextColor:
                                                    AppColor.onSecondary,
                                                primaryFontSize: 10.sp,
                                                secondaryFontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(height: 5.h),
                                              RichTextFeature(
                                                primaryText:
                                                    "Avg Billed Amount: ",
                                                secondaryText: "6200",
                                                primaryTextColor:
                                                    AppColor.onSecondary,
                                                secondaryTextColor:
                                                    AppColor.onSecondary,
                                                primaryFontSize: 10.sp,
                                                secondaryFontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),

                                          // Action Buttons
                                          Row(
                                            spacing: 10.w,
                                            children: [
                                              Container(
                                                width: Get.width * 0.28,
                                                height: 33.h,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColor.primaryVariant1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        18.r,
                                                      ),
                                                ),
                                                child: Center(
                                                  child: CommonText(
                                                    txtName: "Start Delivery",
                                                    txtColor:
                                                        AppColor.onPrimary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (controller.selectedItem.value == 2) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            itemCount: controller.filteredStores.length,
                            separatorBuilder: (_, __) => SizedBox(height: 13.h),
                            itemBuilder: (context, index) {
                              final store = controller.filteredStores[index];
                              final storeDetail = store['data'];

                              return Container(
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
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              CommonText(
                                                txtName:
                                                    "${storeDetail['storeName']}",
                                                txtColor: AppColor.onSecondary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp,
                                              ),
                                            ],
                                          ),
                                          // Store Tags
                                          Row(
                                            children: [
                                              TagFeature(
                                                txtName:
                                                    "${storeDetail['storeType']}",
                                                txtColor: AppColor.primary,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
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
                                                primaryText:
                                                    "Last Billed Amount: ",
                                                secondaryText: "6200",
                                                primaryTextColor:
                                                    AppColor.onSecondary,
                                                secondaryTextColor:
                                                    AppColor.onSecondary,
                                                primaryFontSize: 10.sp,
                                                secondaryFontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(height: 5.h),
                                              RichTextFeature(
                                                primaryText:
                                                    "Avg Billed Amount: ",
                                                secondaryText: "6200",
                                                primaryTextColor:
                                                    AppColor.onSecondary,
                                                secondaryTextColor:
                                                    AppColor.onSecondary,
                                                primaryFontSize: 10.sp,
                                                secondaryFontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),

                                          // Action Buttons
                                          Row(
                                            spacing: 10.w,
                                            children: [
                                              Container(
                                                width: Get.width * 0.28,
                                                height: 33.h,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColor.primaryVariant1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        18.r,
                                                      ),
                                                ),
                                                child: Center(
                                                  child: CommonText(
                                                    txtName: "Start Delivery",
                                                    txtColor:
                                                        AppColor.onPrimary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CommonText(
                              txtName: "No Data Found",
                              txtColor: AppColor.onSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          );
                        }
                      }),
                    )

                  ],
                ),
              ),
      ),
      drawer: DrawerBarView(),
    );
  }
}
