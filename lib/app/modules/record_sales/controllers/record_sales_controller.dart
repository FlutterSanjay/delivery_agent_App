// lib/modules/sales/controllers/sales_controller.dart
import 'package:delivery_agent/app/data/model/record_sale_product_model.dart';
import 'package:get/get.dart';

import '../../../Services/record_sale_product_api.dart';

class RecordSalesController extends GetxController {
  //TODO: Implement RecordSalesController

  // Inject the ApiProvider using Get.find()
  // This assumes ApiProvider has been initialized via Get.put() or Get.lazyPut()
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  // Observable variables for UI updates
  var isLoading = true.obs;
  var availableProducts = <RecordSaleProductModel>[].obs;
  var cartItems = <RecordSaleProductModel, int>{}.obs; // Product and quantity
  var totalItems = 0.obs;
  var totalSale = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Fetch products when the controller is initialized
  }

  // GetxController lifecycle:
  // onInit(): Called once when the controller is first created. Perfect for initial data fetching.
  // onReady(): Called after the widget is rendered. Useful for showing dialogs, etc.
  // onClose(): Called when the controller is removed from memory. Good for disposing resources.

  Future<void> fetchProducts() async {
    try {
      isLoading(true); // Show loading indicator
      List<RecordSaleProductModel> fetchedProducts = await _apiProvider.fetchProducts();
      availableProducts.assignAll(fetchedProducts); // Update observable list
    } catch (e) {
      // Error handling is done in ApiProvider, but you can add more specific UI reactions here
      print('Error fetching products: $e');
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }

  void addItem(RecordSaleProductModel product) {
    if (product.isExpired) {
      Get.snackbar(
        'Cannot Add',
        '${product.name} is expired and cannot be added to cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if ((cartItems[product] ?? 0) >= product.available) {
      Get.snackbar(
        'Out of Stock',
        'No more ${product.name} available.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    cartItems.update(product, (value) => value + 1, ifAbsent: () => 1);
    _updateTotals();
  }

  void removeItem(RecordSaleProductModel product) {
    if (!cartItems.containsKey(product)) return;

    if (cartItems[product]! <= 1) {
      cartItems.remove(product);
    } else {
      cartItems.update(product, (value) => value - 1);
    }
    _updateTotals();
  }

  void _updateTotals() {
    totalItems.value = cartItems.values.fold(0, (sum, count) => sum + count);
    totalSale.value = cartItems.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );
  }

  int getQuantity(RecordSaleProductModel product) {
    return cartItems[product] ?? 0;
  }

  Future<void> completeSale() async {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Cart Empty',
        'Please add items to complete the sale.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading(true); // Show loading during sale completion
      final saleData = {
        'totalItems': totalItems.value,
        'totalSale': totalSale.value,
        'items': cartItems.entries
            .map(
              (entry) => {
                'productId': entry.key.id, // Use actual product ID
                'quantity': entry.value,
                'price': entry.key.price,
              },
            )
            .toList(),
      };
      await _apiProvider.recordSale(saleData);

      // Clear cart and update UI after successful sale
      cartItems.clear();
      _updateTotals();
      // Optionally, refetch products to update their availability on the UI
      fetchProducts();
    } catch (e) {
      // Error handling is managed by ApiProvider, but specific UI feedback can be added here
      print('Error completing sale: $e');
    } finally {
      isLoading(false); // Hide loading
    }
  }
}
