// lib/data/providers/api_provider.dart
import 'package:delivery_agent/app/data/model/record_sale_product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider extends GetxService {
  // No base URL needed for demo data

  // Simulate a "database" of products
  final List<RecordSaleProductModel> _demoProducts = [
    RecordSaleProductModel(
      id: 'P001',
      name: 'Bottled Water (500ml)',
      price: 1.50,
      available: 48,
      imageUrl: 'assets/water.png',
    ),
    RecordSaleProductModel(
      id: 'P002',
      name: 'Fresh Milk (1L)',
      price: 3.25,
      available: 24,
      imageUrl: 'assets/milk.png',
    ),
    RecordSaleProductModel(
      id: 'P003',
      name: 'Bread Loaf',
      price: 2.75,
      available: 15,
      imageUrl: 'assets/bread.png',
    ),
    RecordSaleProductModel(
      id: 'P004',
      name: 'Chocolate Bar',
      price: 1.99,
      available: 36,
      imageUrl: 'assets/chocolate.png',
    ),
    RecordSaleProductModel(
      id: 'P005',
      name: 'Yogurt (150g)',
      price: 1.25,
      available: 10,
      imageUrl: 'assets/yogurt.png',
      isExpired: true,
    ),
    RecordSaleProductModel(
      id: 'P006',
      name: 'Apples (1kg)',
      price: 4.50,
      available: 20,
      imageUrl: 'assets/apples.png',
    ),
    RecordSaleProductModel(
      id: 'P007',
      name: 'Orange Juice (1.5L)',
      price: 3.80,
      available: 18,
      imageUrl: 'assets/orange_juice.png',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    print('ApiProvider initialized with demo data.');
  }

  Future<List<RecordSaleProductModel>> fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Return a copy of the demo products
    return List.from(_demoProducts);
  }

  Future<void> recordSale(Map<String, dynamic> saleData) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    print('--- DEMO BACKEND: Recording Sale ---');
    print(
      'Sale Data Received: ${json.encode(saleData)}',
    ); // Use json.encode for pretty printing
    print('-----------------------------------');

    // Simulate successful response
    Get.snackbar(
      'Demo Success',
      'Sale recorded successfully (simulated)!',
      snackPosition: SnackPosition.BOTTOM,
    );
    // In a real scenario, you might update the _demoProducts available quantities here
    // based on the saleData, to reflect changes in stock for subsequent fetches.
  }
}
