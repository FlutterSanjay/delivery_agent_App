import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/modules/payment_page/views/payment_page_view.dart';
import 'package:delivery_agent/app/modules/store_assign/controllers/store_assign_controller.dart';
import 'package:delivery_agent/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class OrderSummaryOneStore extends StatelessWidget {
  final StoreAssignController controller;
  const OrderSummaryOneStore({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryVariant2,
        title: Text(
          "Order Summary",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(12.w),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  final product = item.products![index];
                  print("Order Summary :${item.orderId}");
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.blue.shade100, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: Image.network(
                              'https://th.bing.com/th/id/OIP.uIdKn4nF_OU2UFV3zWbyLQHaEl?w=273&h=180&c=7&r=0&o=7&pid=1.7&rm=3',
                              width: 80.w,
                              height: 85.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80.w,
                                  height: 85.w,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    size: 32.sp,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),

                          // ✅ Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${product.name}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Status : ${item.status!}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "₹${product.price!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ✅ Quantity
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 14.r),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 9, 140, 233),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                    topRight: Radius.circular(0.r),
                                    bottomRight: Radius.circular(0.r),
                                  ),
                                ),
                                child: Text(
                                  "Qty: ${product.quantity!}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: 60.w,
                                height: 33.h, // yaha thoda bada rakho
                                margin: EdgeInsets.only(top: 30.h),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        item.paymentMethod == "cash_on_delivery"
                                        ? Colors.red
                                        : Colors.orange,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ), // chhota padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    //1. COD hoga tho Payment part Else Change the status

                                    // item.paymentMethod == "cash_on_delivery"?:;
                                    Get.to(
                                      () => PaymentPageView(),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text(
                                    item.paymentMethod == "cash_on_delivery"
                                        ? "Pay"
                                        : "Done",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✅ Bottom Summary
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.r,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _summaryRow(
                    "Subtotal",
                    "₹${controller.subtotal.toStringAsFixed(2)}",
                  ),
                  _summaryRow("Shipping", "Free"),
                  _summaryRow("Tax", "₹${controller.tax.toStringAsFixed(2)}"),
                  Divider(),
                  _summaryRow(
                    "Total",
                    "₹${controller.total.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _summaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBold ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBold ? Colors.black : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
