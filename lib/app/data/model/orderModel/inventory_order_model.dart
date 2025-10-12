class InventoryOrderModel {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String status;

  InventoryOrderModel({
    required this.status,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory InventoryOrderModel.fromJson(Map<String, dynamic> json) {
    return InventoryOrderModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0).toDouble(),
      quantity: (json['quantity'] ?? 0).toInt(),
      status: json['status'] ?? 'available',
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'quantity': quantity,
    'status': status,
  };
}
