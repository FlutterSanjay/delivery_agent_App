// models/product_model.dart
class OrderModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double quantity; // Stock quantity in inventory
  final double rating;
  final String imageUrl;

  OrderModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.rating,
    required this.imageUrl,
  });

  // Factory constructor to create a ProductModel from a JSON map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      quantity: json['quantity'] as double,
      rating: json['rating'] as double,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
