import 'package:get/get.dart';
import '../../../data/model/product_model.dart';

class OrderController extends GetxController {
  // Observable to hold the currently selected category
  final RxString selectedCategory = 'All'.obs;

  // Observable list to hold all products fetched (simulated)
  final RxList<Product> allProducts = <Product>[].obs;

  // Observable list for products displayed after filtering
  final RxList<Product> filteredProducts = <Product>[].obs;

  // Observable for loading state
  final RxBool isLoading = true.obs;

  var selectedItem = (-1).obs; // -1 means nothing selected

  RxList<String> statusItem = ['Sort', 'Brand', 'Price', 'Rating'].obs;

  void selectItem(int index) {
    selectedItem.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Simulate fetching products on controller initialization
    ever(selectedCategory, (_) => _filterProducts()); // React to category changes
  }

  // Simulate fetching products from a backend
  Future<void> fetchProducts() async {
    isLoading.value = true; // Set loading to true
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // This data would come from your backend API
    final List<Map<String, dynamic>> rawData = [
      {
        'id': 'p1',
        'title': 'Bhagwati\n - Rectangle Container',
        'subtitle': '14-500 ml,...',
        'quantity': '50 pc',
        'price': 287.54,
        'perPiecePrice': 5.75,
        'discount': '15% OFF',
        'imageUrl':
            'https://images.pexels.com/photos/1566308/pexels-photo-1566308.jpeg?cs=srgb&dl=pexels-jbigallery-1566308.jpg&fm=jpg',
        'category': 'All',
      },
      {
        'id': 'p2',
        'title': 'Bhagwati \n- Round Container',
        'subtitle': '03-500 ml,...',
        'quantity': '100 pc',
        'price': 418.75,
        'perPiecePrice': 4.19,
        'discount': '23% OFF',
        'imageUrl':
            'https://images.pexels.com/photos/1566308/pexels-photo-1566308.jpeg?cs=srgb&dl=pexels-jbigallery-1566308.jpg&fm=jpg',
        'isPriceDrop': true,
        'category': 'All',
      },
      {
        'id': 'p3',
        'title': 'Eco-Friendly\n Cutlery Set',
        'subtitle': 'Biodegradable, 100 pcs',
        'quantity': '100 pc',
        'price': 150.00,
        'perPiecePrice': 1.50,
        'discount': '10% OFF',
        'imageUrl':
            'https://images.pexels.com/photos/1566308/pexels-photo-1566308.jpeg?cs=srgb&dl=pexels-jbigallery-1566308.jpg&fm=jpg',
        'category': 'Cutlery & Tissues',
      },
      {
        'id': 'p4',
        'title': 'Paper Tissues\n (Bulk)',
        'subtitle': 'Soft, 500 sheets',
        'quantity': '1 pc',
        'price': 80.00,
        'perPiecePrice': 80.00,
        'discount': '5% OFF',
        'imageUrl':
            'https://images.pexels.com/photos/1566308/pexels-photo-1566308.jpeg?cs=srgb&dl=pexels-jbigallery-1566308.jpg&fm=jpg',
        'category': 'Cutlery & Tissues',
      },
      {
        'id': 'p5',
        'title': 'Large Round \nFood Container',
        'subtitle': '1000 ml, pack of 5',
        'quantity': '5 pc',
        'price': 300.00,
        'perPiecePrice': 60.00,
        'discount': '20% OFF',
        'imageUrl':
            'https://images.pexels.com/photos/1566308/pexels-photo-1566308.jpeg?cs=srgb&dl=pexels-jbigallery-1566308.jpg&fm=jpg',
        'category': 'Reusable Round Containers',
      },
    ];

    allProducts.value = rawData.map((json) => Product.fromJson(json)).toList();
    _filterProducts(); // Initial filter after fetching all products
    isLoading.value = false; // Set loading to false
  }

  // Method to update the selected category and re-filter products
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Filter products based on the selected category
  void _filterProducts() {
    if (selectedCategory.value == 'All') {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
