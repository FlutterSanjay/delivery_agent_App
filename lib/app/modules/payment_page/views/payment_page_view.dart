import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/payment_page_controller.dart';

class PaymentPageView extends GetView<PaymentPageController> {
  const PaymentPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20.0.w,
            100.0.h,
            20.0.w,
            20.0.h,
          ), // Adjust top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount Due:',
                style: TextStyle(fontSize: 18.sp, color: AppColor.onSecondary),
              ),
              SizedBox(height: 10.h),
              // Display Amount Due
              Align(
                alignment: Alignment.center,
                child: Text(
                  '\$${controller.transaction.value.amountDue.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // Payment Methods Card
              _buildPaymentMethodsCard(),
              SizedBox(height: 20.h),

              // Conditional Cash Payment Input
              if (controller.transaction.value.paymentMethod == PaymentMethod.cash.name)
                _buildCashPaymentInput(),
              SizedBox(height: 30.h),

              // Error Message
              if (controller.errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0.h),
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: AppColor.redColor, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Pay Button
              _buildPayButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPaymentMethodsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            Wrap(
              spacing: 10.0.h, // gap between adjacent chips
              runSpacing: 10.0.h, // gap between lines
              children: PaymentMethod.values.map((method) {
                return Obx(
                  () => ChoiceChip(
                    label: Text(method.name.capitalizeFirst!),
                    selected: controller.transaction.value.paymentMethod == method.name,
                    selectedColor: Colors.blue.shade100,
                    onSelected: (selected) {
                      if (selected) {
                        controller.selectPaymentMethod(method);
                      }
                    },
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: controller.transaction.value.paymentMethod == method.name
                          ? Colors.blue.shade700
                          : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(
                        color: controller.transaction.value.paymentMethod == method.name
                            ? Colors.blue.shade700
                            : Colors.transparent,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCashPaymentInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cash Payment Details',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            TextField(
              controller: controller.cashInputController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Amount Paid (Cash)',
                hintText: 'e.g., 50.00',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                prefixText: '\$',
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change Due:',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Obx(
                  () => Text(
                    '\$${controller.changeDue.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: controller.changeDue.value >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : () => controller.processPayment(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 5,
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                controller.transaction.value.paymentMethod == PaymentMethod.cash.name
                    ? 'Complete Cash Payment'
                    : 'Process ${controller.transaction.value.paymentMethod.capitalizeFirst!} Payment',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
