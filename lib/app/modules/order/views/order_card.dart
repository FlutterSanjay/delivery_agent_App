// inventory_card.dart
import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel product;
  final VoidCallback onAddPressed;

  const OrderCard({Key? key, required this.product, required this.onAddPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0.r)),
      margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
      child: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.r),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryVariant2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.primaryVariant1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: product.rating,
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 18.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '(${product.rating.toStringAsFixed(1)})',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: onAddPressed,
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('Add to Invoice'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryVariant1,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      ),
                    ),
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
