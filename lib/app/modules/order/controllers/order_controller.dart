import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/model/order_model.dart';

class OrderController extends GetxController {
  // Observable list of orders
  final RxList<Order> _orders = <Order>[].obs;
  List<Order> get orders => _orders.toList(); // Getter for the orders list

  // Observable boolean to indicate loading state
  final RxBool isLoading = true.obs;

  // This will represent the currently logged-in delivery agent's ID.
  // In a real app, this would come from authentication.
  final String _currentDeliveryAgentId = '416575aa-038f-4264-8093-960c7ea93b52';

  @override
  void onInit() {
    super.onInit();
    fetchOrdersForAgent(); // Fetch orders when the controller is initialized
  }

  // Fetches orders for the current delivery agent.
  // Currently uses dummy data, but can be replaced with backend API calls.
  void fetchOrdersForAgent() async {
    isLoading.value = true; // Set loading to true
    // Simulate fetching data from a backend
    // In a real application, you would make an HTTP request here:
    // try {
    //   final response = await http.get(Uri.parse('YOUR_BACKEND_API/orders?deliveryAgentId=$_currentDeliveryAgentId'));
    //   if (response.statusCode == 200) {
    //     List<dynamic> jsonList = json.decode(response.body);
    //     _orders.value = jsonList.map((json) => Order.fromJson(json)).toList();
    //   } else {
    //     Get.snackbar('Error', 'Failed to load orders: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   Get.snackbar('Error', 'Failed to connect to server: $e');
    // }

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy data for demonstration based on the provided structure
    final List<Map<String, dynamic>> dummyOrders = [
      {
        "createdAt": "2025-06-26T13:43:01.669Z",
        "deliveryAddress": {
          "city": "Chicago",
          "country": "USA",
          "postalCode": "60601",
          "state": "IL",
          "street": "456 Minimal Ave",
        },
        "deliveryAgentId": "416575aa-038f-4264-8093-960c7ea93b52", // Matches agent ID
        "estimatedDeliveryTime": "2023-12-20T17:30:00Z", // UTC+5:30 converted to Z
        "orderId": "14e56d61-5f0f-4b27-8df2-1a0af0d1a437",
        "paymentMethod": "cash_on_delivery",
        "products": [
          {
            "name": "Sunflower Cooking Oil 1L",
            "price": 150,
            "productId": "02734d72-0438-496b-8327-d80ab4dc74fd",
            "quantity": 1,
          },
        ],
        "retailerId": "retailer_min",
        "status": "assigned",
        "storeId": ["336fcf34-a7d3-4fb2-b305-a4a6a202737b"],
        "supplierId": "supplier_min",
        "totalAmount": 150,
        "updatedAt": "2025-07-03T08:50:55.178Z",
        "warehouseId": "4aa557eb-e778-48ba-b1ef-d7c0b3f75642",
      },
      {
        "createdAt": "2025-06-27T10:00:00.000Z",
        "deliveryAddress": {
          "city": "New York",
          "country": "USA",
          "postalCode": "10001",
          "state": "NY",
          "street": "123 Main St",
        },
        "deliveryAgentId": "416575aa-038f-4264-8093-960c7ea93b52", // Matches agent ID
        "estimatedDeliveryTime": "2023-12-21T10:00:00Z",
        "orderId": "a1b2c3d4-e5f6-7890-1234-567890abcdef",
        "paymentMethod": "credit_card",
        "products": [
          {
            "name": "Organic Apples 2kg",
            "price": 250,
            "productId": "prod-apple-001",
            "quantity": 1,
          },
          {
            "name": "Whole Wheat Bread",
            "price": 50,
            "productId": "prod-bread-002",
            "quantity": 2,
          },
        ],
        "retailerId": "retailer_max",
        "status": "assigned",
        "storeId": ["store-nyc-001"],
        "supplierId": "supplier_max",
        "totalAmount": 350,
        "updatedAt": "2025-07-03T11:00:00.000Z",
        "warehouseId": "warehouse-nyc-001",
      },
      {
        "createdAt": "2025-06-28T09:00:00.000Z",
        "deliveryAddress": {
          "city": "Los Angeles",
          "country": "USA",
          "postalCode": "90001",
          "state": "CA",
          "street": "789 Oak Ave",
        },
        "deliveryAgentId": "another-agent-id-12345", // DOES NOT match agent ID
        "estimatedDeliveryTime": "2023-12-22T14:00:00Z",
        "orderId": "f0e9d8c7-b6a5-4321-fedc-ba9876543210",
        "paymentMethod": "cash_on_delivery",
        "products": [
          {
            "name": "Fresh Milk 1L",
            "price": 80,
            "productId": "prod-milk-003",
            "quantity": 1,
          },
        ],
        "retailerId": "retailer_mid",
        "status": "assigned",
        "storeId": ["store-la-001"],
        "supplierId": "supplier_mid",
        "totalAmount": 80,
        "updatedAt": "2025-07-03T10:00:00.000Z",
        "warehouseId": "warehouse-la-001",
      },
      {
        "createdAt": "2025-06-29T15:00:00.000Z",
        "deliveryAddress": {
          "city": "Chicago",
          "country": "USA",
          "postalCode": "60605",
          "state": "IL",
          "street": "101 Pine St",
        },
        "deliveryAgentId": "416575aa-038f-4264-8093-960c7ea93b52", // Matches agent ID
        "estimatedDeliveryTime": "2023-12-23T16:00:00Z",
        "orderId": "b2c1d0e3-f4a5-6789-0123-456789abcdef",
        "paymentMethod": "credit_card",
        "products": [
          {
            "name": "Ground Coffee 500g",
            "price": 300,
            "productId": "prod-coffee-004",
            "quantity": 1,
          },
        ],
        "retailerId": "retailer_min",
        "status": "pending_pickup",
        "storeId": ["store-chi-002"],
        "supplierId": "supplier_min",
        "totalAmount": 300,
        "updatedAt": "2025-07-03T15:00:00.000Z",
        "warehouseId": "4aa557eb-e778-48ba-b1ef-d7c0b3f75642",
      },
    ];

    // Filter orders for the specific delivery agent
    final agentOrders = dummyOrders
        .map((json) => Order.fromJson(json))
        .where((order) => order.deliveryAgentId == _currentDeliveryAgentId)
        .toList();

    _orders.value = agentOrders; // Update the observable list
    isLoading.value = false; // Set loading to false after data is loaded
  }

  // Marks an order as delivered
  void markOrderAsDelivered(String orderId) {
    final index = _orders.indexWhere((order) => order.orderId == orderId);
    if (index != -1) {
      // Create a new order object with updated status
      final updatedOrder = _orders[index].copyWith(status: 'delivered');
      _orders[index] = updatedOrder; // Update the observable list
      Get.snackbar(
        'Order Status',
        'Order $orderId marked as delivered!',
        snackPosition: SnackPosition.BOTTOM,
      );

      // In a real app, you would send this update to your backend:
      // await http.post(Uri.parse('YOUR_BACKEND_API/orders/$orderId/deliver'));
    }
  }

  // You can add more methods here for other actions like:
  // - acceptOrder(String orderId)
  // - rejectOrder(String orderId)
  // - navigateToOrder(Order order)
}
