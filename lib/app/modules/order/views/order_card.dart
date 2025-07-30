import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/model/order_model.dart';
import '../controllers/order_controller.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final OrderController orderController =
      Get.find<OrderController>(); // Get the controller instance

  OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format date and time
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
    final estimatedTime = dateFormat.format(
      order.estimatedDeliveryTime.toLocal(),
    ); // Convert to local time

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.orderId.substring(0, 8)}...', // Shorten for display
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    order.status.capitalizeFirst!, // Capitalize first letter
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 16.h, thickness: 1.w),
            // Display products with a placeholder image
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Products:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  ...order.products
                      .map(
                        (p) => Padding(
                          padding: EdgeInsets.only(
                            left: 28.0.w,
                            bottom: 4.0.h,
                          ), // Indent product details
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${p.name} (x${p.quantity})',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              SizedBox(width: 8.w),

                              // Placeholder image for the item
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0.r),
                                child: Image.network(
                                  'https://cdn.shopify.com/s/files/1/2303/2711/files/2_e822dae0-14df-4cb8-b145-ea4dc0966b34.jpg?v=1617059123', // Generic placeholder image
                                  width: 60.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    Icons.image_not_supported,
                                    size: 30.r,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            _buildInfoRow(
              Icons.attach_money,
              'Total Amount:',
              '\$${order.totalAmount.toStringAsFixed(2)}',
            ),
            _buildInfoRow(
              Icons.location_on_outlined,
              'Delivery Address:',
              '${order.deliveryAddress.street}, ${order.deliveryAddress.city}, ${order.deliveryAddress.state} ${order.deliveryAddress.postalCode}, ${order.deliveryAddress.country}',
            ),
            _buildInfoRow(Icons.access_time_outlined, 'Est. Delivery:', estimatedTime),
            SizedBox(height: 16.h),
            if (order.status == 'assigned' || order.status == 'pending_pickup')
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Show a confirmation dialog instead of alert()
                    Get.defaultDialog(
                      title: "Confirm Delivery",
                      middleText:
                          "Are you sure you want to mark this order as delivered?",
                      textConfirm: "Yes",
                      textCancel: "No",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        orderController.markOrderAsDelivered(order.orderId);
                        Get.back(); // Close the dialog
                      },
                      onCancel: () {
                        Get.back(); // Close the dialog
                      },
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Mark as Delivered'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent info rows
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[600]),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800]),
                ),
                Text(value, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return Colors.orange;
      case 'pending_pickup':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
