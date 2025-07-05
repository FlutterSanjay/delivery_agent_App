/// Model for the second summary card data.
class SummaryDataTwo {
  final double cashInHand;
  final double onlineTransfer;
  final double revenue;
  final int returnedProduct;
  final int storeVisited;
  final String inventoryInVanAction; // This could be a URL or a specific action string

  SummaryDataTwo({
    required this.cashInHand,
    required this.onlineTransfer,
    required this.revenue,
    required this.returnedProduct,
    required this.storeVisited,
    required this.inventoryInVanAction,
  });

  // Factory constructor to create a SummaryDataTwo instance from a JSON map.
  factory SummaryDataTwo.fromJson(Map<String, dynamic> json) {
    return SummaryDataTwo(
      cashInHand: (json['cash_in_hand'] as num?)?.toDouble() ?? 0.0,
      onlineTransfer: (json['online_transfer'] as num?)?.toDouble() ?? 0.0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      returnedProduct: json['returned_product'] as int? ?? 0,
      storeVisited: json['store_visited'] as int? ?? 0,
      inventoryInVanAction: json['inventory_in_van_action'] as String? ?? 'Click Here',
    );
  }

  // Method to convert a SummaryDataTwo instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'cash_in_hand': cashInHand,
      'online_transfer': onlineTransfer,
      'revenue': revenue,
      'returned_product': returnedProduct,
      'store_visited': storeVisited,
      'inventory_in_van_action': inventoryInVanAction,
    };
  }
}
