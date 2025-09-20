class OrderResponse {
  final String? message;
  final List<Order>? orders;

  OrderResponse({this.message, this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      message: json['message'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((order) => Order.fromJson(order as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": orders?.map((o) => o.toJson()).toList(),
  };
}

class Order {
  final String? orderId;
  final List<Product>? products;
  final String? storeId;
  final String? warehouseId;
  final double? totalAmount;
  final EstimatedDeliveryTime? estimatedDeliveryTime;
  final String? paymentMethod;
  final String? deliveryAgentId;
  final DateTime? createdAt;
  final String? status;
  final DateTime? updatedAt;
  final String? vehicleId;

  Order({
    this.orderId,
    this.products,
    this.storeId,
    this.warehouseId,
    this.totalAmount,
    this.estimatedDeliveryTime,
    this.paymentMethod,
    this.deliveryAgentId,
    this.createdAt,
    this.status,
    this.updatedAt,
    this.vehicleId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList(),
      storeId: json['storeId'] as String?,
      warehouseId: json['warehouseId'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? EstimatedDeliveryTime.fromJson(
              json['estimatedDeliveryTime'] as Map<String, dynamic>,
            )
          : null,
      paymentMethod: json['paymentMethod'] as String?,
      deliveryAgentId: json['deliveryAgentId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      vehicleId: json['vehicleId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "products": products?.map((p) => p.toJson()).toList(),
    "storeId": storeId,
    "warehouseId": warehouseId,
    "totalAmount": totalAmount,
    "estimatedDeliveryTime": estimatedDeliveryTime?.toJson(),
    "paymentMethod": paymentMethod,
    "deliveryAgentId": deliveryAgentId,
    "createdAt": createdAt?.toIso8601String(),
    "status": status,
    "updatedAt": updatedAt?.toIso8601String(),
    "vehicleId": vehicleId,
  };
}

class Product {
  final String? productId;
  final String? name;
  final double? price;
  final int? quantity;

  Product({this.productId, this.name, this.price, this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "price": price,
    "quantity": quantity,
  };
}

class EstimatedDeliveryTime {
  final int? seconds;
  final int? nanoseconds;

  EstimatedDeliveryTime({this.seconds, this.nanoseconds});

  factory EstimatedDeliveryTime.fromJson(Map<String, dynamic> json) {
    return EstimatedDeliveryTime(
      seconds: json['_seconds'] as int?,
      nanoseconds: json['_nanoseconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_seconds": seconds,
    "_nanoseconds": nanoseconds,
  };

  /// ✅ Convert Firestore timestamp to DateTime safely
  DateTime? toDateTime() {
    if (seconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(seconds! * 1000);
  }
}
