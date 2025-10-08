import 'package:delivery_agent/app/modules/payment_page/controllers/payment_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final String transactionId;
  final String amount;
  final PaymentPageController controller;

  const PaymentSuccessDialog({
    super.key,
    required this.transactionId,
    required this.amount,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80.r),
            SizedBox(height: 20.h),
            Text(
              "Payment Successful!",
              style: TextStyle(
                fontSize: 22.r,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 10.h),
            Text(
              "Transaction ID: $transactionId",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            ),
            Text("Amount: ₹$amount", style: TextStyle(color: Colors.black)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0,
                    minimumSize: const Size(50, 50),
                  ),

                  onPressed: () {
                    Get.back();
                    Get.offAllNamed('/store-assign');
                    // close dialog
                    // controller.generateCompactInvoice(ordersData);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 50), // width, height
                    backgroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    controller.createAndSendInvoice();
                    Get.offAllNamed('/store-assign');
                  },
                  child: const Text(
                    'Invoice',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
