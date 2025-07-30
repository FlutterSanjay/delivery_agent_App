class Product {
  final String name;
  final double price;
  final String productId;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'productId': productId, 'quantity': quantity};
  }
}

// Represents the delivery address for an order
class DeliveryAddress {
  final String city;
  final String country;
  final String postalCode;
  final String state;
  final String street;

  DeliveryAddress({
    required this.city,
    required this.country,
    required this.postalCode,
    required this.state,
    required this.street,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      city: json['city'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as String,
      state: json['state'] as String,
      street: json['street'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'state': state,
      'street': street,
    };
  }
}

// Represents an entire order
class Order {
  final DateTime createdAt;
  final DeliveryAddress deliveryAddress;
  final String deliveryAgentId;
  final DateTime estimatedDeliveryTime;
  final String orderId;
  final String paymentMethod;
  final List<Product> products;
  final String retailerId;
  final String status;
  final List<String> storeId;
  final String supplierId;
  final double totalAmount;
  final DateTime updatedAt;
  final String warehouseId;

  Order({
    required this.createdAt,
    required this.deliveryAddress,
    required this.deliveryAgentId,
    required this.estimatedDeliveryTime,
    required this.orderId,
    required this.paymentMethod,
    required this.products,
    required this.retailerId,
    required this.status,
    required this.storeId,
    required this.supplierId,
    required this.totalAmount,
    required this.updatedAt,
    required this.warehouseId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      createdAt: DateTime.parse(json['createdAt'] as String),
      deliveryAddress: DeliveryAddress.fromJson(
        json['deliveryAddress'] as Map<String, dynamic>,
      ),
      deliveryAgentId: json['deliveryAgentId'] as String,
      estimatedDeliveryTime: DateTime.parse(json['estimatedDeliveryTime'] as String),
      orderId: json['orderId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      products: (json['products'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      retailerId: json['retailerId'] as String,
      status: json['status'] as String,
      storeId: List<String>.from(json['storeId'] as List),
      supplierId: json['supplierId'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      warehouseId: json['warehouseId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'deliveryAddress': deliveryAddress.toJson(),
      'deliveryAgentId': deliveryAgentId,
      'estimatedDeliveryTime': estimatedDeliveryTime.toIso8601String(),
      'orderId': orderId,
      'paymentMethod': paymentMethod,
      'products': products.map((e) => e.toJson()).toList(),
      'retailerId': retailerId,
      'status': status,
      'storeId': storeId,
      'supplierId': supplierId,
      'totalAmount': totalAmount,
      'updatedAt': updatedAt.toIso8601String(),
      'warehouseId': warehouseId,
    };
  }

  // Method to update status - useful for backend integration
  Order copyWith({String? status}) {
    return Order(
      createdAt: createdAt,
      deliveryAddress: deliveryAddress,
      deliveryAgentId: deliveryAgentId,
      estimatedDeliveryTime: estimatedDeliveryTime,
      orderId: orderId,
      paymentMethod: paymentMethod,
      products: products,
      retailerId: retailerId,
      status: status ?? this.status,
      storeId: storeId,
      supplierId: supplierId,
      totalAmount: totalAmount,
      updatedAt: updatedAt,
      warehouseId: warehouseId,
    );
  }
}
