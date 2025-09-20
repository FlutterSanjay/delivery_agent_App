import '../product_model.dart';
import 'estimate_time_delivery_model.dart';

class Order {
  final String orderId;
  final List<Product> products;
  final String storeId;
  final String warehouseId;
  final double totalAmount;
  final EstimatedDeliveryTime estimatedDeliveryTime;
  final String paymentMethod;
  final DateTime createdAt;
  final String vehicleId;
  final String status;
  final DateTime updatedAt;

  Order({
    required this.orderId,
    required this.products,
    required this.storeId,
    required this.warehouseId,
    required this.totalAmount,
    required this.estimatedDeliveryTime,
    required this.paymentMethod,
    required this.createdAt,
    required this.vehicleId,
    required this.status,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] as String? ?? '',
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (productJson) => Product.fromJson(productJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
      storeId: json['storeId'] as String? ?? '',
      warehouseId: json['warehouseId'] as String? ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? EstimatedDeliveryTime.fromJson(
              json['estimatedDeliveryTime'] as Map<String, dynamic>,
            )
          : EstimatedDeliveryTime(seconds: 0, nanoseconds: 0),
      paymentMethod: json['paymentMethod'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      vehicleId: json['vehicleId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'products': products.map((product) => product.toJson()).toList(),
      'storeId': storeId,
      'warehouseId': warehouseId,
      'totalAmount': totalAmount,
      'estimatedDeliveryTime': estimatedDeliveryTime.toJson(),
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'vehicleId': vehicleId,
      'status': status,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
