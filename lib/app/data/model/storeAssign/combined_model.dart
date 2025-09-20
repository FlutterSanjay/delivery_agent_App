import 'package:delivery_agent/app/data/model/storeAssign/stores_model.dart';

import 'order_model.dart';

class CombinedResponse {
  final String message;
  final List<Order> orders;
  final List<Store> stores;

  CombinedResponse({required this.message, required this.orders, required this.stores});

  factory CombinedResponse.fromJson(Map<String, dynamic> json) {
    return CombinedResponse(
      message: json['message'] as String? ?? '',
      orders:
          (json['orders'] as List<dynamic>?)
              ?.map((orderJson) => Order.fromJson(orderJson as Map<String, dynamic>))
              .toList() ??
          [],
      stores:
          (json['stores'] as List<dynamic>?)
              ?.map((storeJson) => Store.fromJson(storeJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'orders': orders.map((order) => order.toJson()).toList(),
      'stores': stores.map((store) => store.toJson()).toList(),
    };
  }
}
