class InventoryItem {
  final String name;
  final double price;
  final int stock;
  final String imageUrl; // For displaying product image

  InventoryItem({
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  // Factory constructor to create an InventoryItem from a JSON map
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      name: json['name'] ?? 'Unknown',
      price: json['price']?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'] ?? '', // Assume backend provides image URL
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'stock': stock, 'image_url': imageUrl};
  }
}
