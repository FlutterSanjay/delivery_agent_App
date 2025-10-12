import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/Features/custom_str_function.dart';
import 'package:delivery_agent/app/data/model/orderModel/inventory_order_model.dart';
import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final InventoryOrderModel product;
  final VoidCallback onAddPressed;

  const OrderCard({Key? key, required this.product, required this.onAddPressed})
    : super(key: key);
  final inventoryItemImage = ImagePath.defaultTaskItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1, // Thoda shadow zyada
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0.r),
      ), // Rounded edges
      margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 6.0.w),
      shadowColor: AppColor.primaryVariant2, // soft shadow color
      child: Padding(
        padding: EdgeInsets.all(14.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with border & shadow
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(inventoryItemImage),
                  fit: BoxFit.cover,
                ),
            
              ),

            ),
            SizedBox(width: 18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.onSecondary,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withAlpha(20),
                          offset: const Offset(0, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                          fontSize: 15.sp,
                      color: AppColor.primaryVariant1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(product.status),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          CustomStringFunction.capitalizeFirstChar(
                            product.status == 'ready_for_delivery'
                                ? "Approved"
                                : product.status,
                          ),
                          style: TextStyle(
                            color: getStatusTextColor(product.status),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Rating
                  Row(
                  
                    children: [

                      Text(
                        'Qty: ${product.quantity}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColor.onBackground,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.12),
                      RatingBarIndicator(
                        rating: 4.2,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '4.2',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColor.onBackground,
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
  }
}
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'delivered':
      return Colors.green.withAlpha(30);
    case 'ready_for_delivery':
      return Colors.orange.withAlpha(50);
    case 'cancelled':
      return Colors.red.withAlpha(30);
    case 'pending':
      return Colors.blue.withAlpha(30);
    default:
      return Colors.grey.withAlpha(30); // fallback color
  }
}

Color getStatusTextColor(String status) {
  switch (status.toLowerCase()) {
    case 'delivered':
      return Colors.green;
    case 'ready_for_delivery':
      return Colors.orange;
    case 'cancelled':
      return Colors.red;
    case 'pending':
      return Colors.blue;
    default:
      return Colors.grey; // fallback color
  }
}
