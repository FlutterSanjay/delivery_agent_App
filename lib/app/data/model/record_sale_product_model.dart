// lib/data/models/product_model.dart
class RecordSaleProductModel {
  final String id; // Unique ID from backend
  final String name;
  final double price;
  final int available;
  final String? imageUrl;
  final bool isExpired;

  RecordSaleProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    this.imageUrl,
    this.isExpired = false,
  });

  factory RecordSaleProductModel.fromJson(Map<String, dynamic> json) {
    return RecordSaleProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      available: json['available'] as int,
      imageUrl: json['imageUrl'] as String?,
      isExpired: json['isExpired'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'available': available,
      'imageUrl': imageUrl,
      'isExpired': isExpired,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecordSaleProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
