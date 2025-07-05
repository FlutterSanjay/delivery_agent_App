// lib/widgets/product_list_item.dart
import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/data/model/record_sale_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListItem extends StatelessWidget {
  final RecordSaleProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.cardColor,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Row(
          children: [
            // Product Image (can use NetworkImage if imageUrl is a URL)
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.orange[200],
                // For demonstration, using a placeholder if no URL, otherwise you'd use NetworkImage
                // image: product.imageUrl != null
                //     ? DecorationImage(
                //         image: NetworkImage(product.imageUrl!),
                //         fit: BoxFit.cover,
                //       )
                //     : null,
              ),
              child: Icon(Icons.image, size: 30.r, color: Colors.grey), // Placeholder
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  if (!product.isExpired)
                    Text(
                      'Available: ${product.available}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                ],
              ),
            ),
            if (product.isExpired)
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    margin: EdgeInsets.only(bottom: 35.h),
                    decoration: BoxDecoration(
                      color: AppColor.redColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      'Expired',
                      style: TextStyle(
                        color: AppColor.onPrimary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Disabled button for expired items
                  OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      backgroundColor: AppColor.greyColor,
                      side: const BorderSide(color: AppColor.greyColor),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child: const Text(
                      'Expired',
                      style: TextStyle(color: AppColor.textGreyColor),
                    ),
                  ),
                ],
              )
            else
              Container(
                color: AppColor.greyColor,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: 16.sp),
                      onPressed: quantity > 0 ? onRemove : null,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: 16.sp),
                      onPressed: product.available > quantity ? onAdd : null,
                      color: Colors.deepPurple,
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
