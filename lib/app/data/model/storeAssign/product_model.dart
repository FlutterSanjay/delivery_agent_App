class Product {
  final String productId;
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'name': name, 'price': price, 'quantity': quantity};
  }
}
