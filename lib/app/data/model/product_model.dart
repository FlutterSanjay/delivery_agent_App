class Product {
  final String id;
  final String title;
  final String subtitle;
  final String quantity;
  final double price;
  final double perPiecePrice;
  final String discount;
  final String imageUrl;
  final bool isPriceDrop;
  final String category; // Added category for filtering

  Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.perPiecePrice,
    required this.discount,
    required this.imageUrl,
    this.isPriceDrop = false,
    required this.category,
  });

  // Factory constructor for creating a Product from a JSON map (useful for backend data)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      perPiecePrice: json['perPiecePrice'].toDouble(),
      discount: json['discount'],
      imageUrl: json['imageUrl'],
      isPriceDrop: json['isPriceDrop'] ?? false,
      category: json['category'] ?? 'All', // Default to 'All' if category is missing
    );
  }

  // Method to convert a Product to a JSON map (useful for sending data to backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'quantity': quantity,
      'price': price,
      'perPiecePrice': perPiecePrice,
      'discount': discount,
      'imageUrl': imageUrl,
      'isPriceDrop': isPriceDrop,
      'category': category,
    };
  }
}
