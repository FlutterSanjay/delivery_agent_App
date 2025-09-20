// controllers/inventory_controller.dart
import 'package:get/get.dart';

import 'dart:developer';

import '../../../data/model/order_model.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var products = <OrderModel>[].obs;
  var invoiceItems = <OrderModel>[].obs;

  @override
  void onInit() {
    fetchInventoryProducts();
    super.onInit();
  }

  void fetchInventoryProducts() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      final dummyData = [
        OrderModel(
          id: '1',
          name: 'Organic Honey (500g)',
          description: 'Pure, raw, and organic honey sourced from local farms.',
          price: 350.00,
          quantity: 25,
          rating: 4.8,
          imageUrl:
              'https://images.unsplash.com/photo-1587049352824-e221375d3148?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
        OrderModel(
          id: '2',
          name: 'Almond Butter (200g)',
          description: 'Healthy and delicious almond butter, perfect for breakfast.',
          price: 280.00,
          quantity: 15,
          rating: 4.5,
          imageUrl:
              'https://images.unsplash.com/photo-1628169121634-1925b90558b3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
        OrderModel(
          id: '3',
          name: 'Fresh Avocados (Pack of 3)',
          description: 'Fresh and ripe avocados, great for salads and toasts.',
          price: 150.00,
          quantity: 50,
          rating: 4.7,
          imageUrl:
              'https://images.unsplash.com/photo-1587979679803-b78b0292723c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
        OrderModel(
          id: '4',
          name: 'Organic Coffee Beans (250g)',
          description: 'Premium quality roasted coffee beans for a perfect brew.',
          price: 499.00,
          quantity: 30,
          rating: 4.9,
          imageUrl:
              'https://images.unsplash.com/photo-1541167715783-0570b777a83d?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
      ];

      products.assignAll(dummyData);
    } catch (e) {
      log('Error fetching products: $e');
      Get.snackbar('Error', 'Failed to load products. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  void addProductToInvoice(OrderModel product) {
    // 1. Add the product to the invoice list
    invoiceItems.add(product);

    // 2. Remove the product from the inventory list
    products.removeWhere((p) => p.id == product.id);

    log('Product added to invoice and removed from inventory: ${product.name}');
  }
}
