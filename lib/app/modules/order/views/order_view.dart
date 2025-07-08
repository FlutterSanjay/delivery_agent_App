import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../AppColor/appColor.dart';
import '../../../data/model/product_model.dart';

import '../../login_process/views/onboaeding_view.dart';
import '../controllers/order_controller.dart';
// Import the Product model

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order', style: TextStyle(color: AppColor.onSecondary)),
        centerTitle: true,
        backgroundColor: AppColor.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.onSecondary),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          _buildCategoryHeader(context),
          Expanded(
            child: Row(children: [_buildCategoryList(), _buildProductList(context)]),
          ),
          _buildRestaurantSetupCard(),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.0.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Packaging Materi...',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColor.lightGreyBackground),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      padding: EdgeInsets.only(left: 4.w),
      width: Get.width * 0.2,
      color: AppColor.onPrimary,
      child: ListView(
        children: [
          _buildCategoryItem(Icons.grid_view, 'All'),
          _buildCategoryItem(Icons.dinner_dining, 'Cutlery & Tissues'),
          _buildCategoryItem(Icons.circle, 'Reusable Round Containers'),
          _buildCategoryItem(Icons.square_foot, 'Reusable Rectangular Containers'),
          _buildCategoryItem(Icons.lunch_dining, 'Reusable Lunch Boxes'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return Obx(() {
      final bool currentlySelected = controller.selectedCategory.value == title;

      return GestureDetector(
        onTap: () => controller.selectCategory(title),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          decoration: BoxDecoration(
            color: currentlySelected ? Colors.red.withAlpha(10) : Colors.white,
            border: currentlySelected
                ? Border(
                    left: BorderSide(color: Colors.red, width: 4.0.w),
                  )
                : null,
          ),
          child: Column(
            children: [
              Icon(icon, color: currentlySelected ? AppColor.redColor : AppColor.h5Color),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentlySelected ? AppColor.redColor : AppColor.onSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProductList(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            _buildProductFilters(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.filteredProducts.isEmpty) {
                  return const Center(child: Text('No products found.'));
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(5.0.r),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == controller.filteredProducts.length - 1
                              ? 0
                              : 10.0.h,
                        ),
                        child: _buildProductCard(context, product),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductFilters() {
    return SizedBox(
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
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0.r)),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.isPriceDrop)
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'Price drop alert',
                        style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                      ),
                    ],
                  ),
                if (product.isPriceDrop) SizedBox(height: 4.h),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  product.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 12.sp),
                ),
                Text(
                  product.quantity,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '₹${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'at ₹${product.perPiecePrice.toStringAsFixed(2)}/pc',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          product.imageUrl,
                          width: 80.w,
                          height: 50.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/placeholder.png', // Fallback to a local asset if network fails
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0.r),
                            bottomLeft: Radius.circular(8.0.r),
                          ),
                        ),
                        child: Text(
                          product.discount,
                          style: TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      left: 0.w,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.star, color: Colors.white, size: 12.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  width: Get.width * 0.33,
                  height: Get.height * 0.04,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: Row(
                    spacing: 0.w,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red, size: 10.sp),
                        onPressed: () {
                          // Implement logic to decrease quantity
                        },
                      ),
                      Text(
                        'ADD',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.red, size: 10.sp),
                        onPressed: () {
                          // Implement logic to increase quantity
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantSetupCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.assignment, color: Colors.orange, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete your restaurant setup by 15 Sep to continue exploring',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Row(
              children: [
                Text('Start', style: TextStyle(color: Colors.white, fontSize: 16)),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
